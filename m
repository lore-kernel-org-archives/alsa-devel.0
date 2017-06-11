From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: pcm: return error immediately for
	parameters handling
Date: Sun, 11 Jun 2017 23:56:12 +0900
Message-ID: <20170611145613.24929-2-o-takashi@sakamocchi.jp>
References: <20170611145613.24929-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id BC4BE2668E2
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 16:56:17 +0200 (CEST)
In-Reply-To: <20170611145613.24929-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When refining mask/interval parameters, helper functions can return error
code. This error is not handled immediately. This seems to return
parameters to userspace applications in its meddle of processing.

However, in general, when receiving error from system calls, the
application might not handle argument buffer. It's reasonable to
judge the above design as superfluity.

This commit handles the error immediately.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 66 ++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 076187ae8859..425f54827e78 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -276,14 +276,14 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 			old_mask = *m;
 
 		changed = snd_mask_refine(m, constrs_mask(constrs, k));
+		if (changed < 0)
+			return changed;
 
 		trace_hw_mask_param(substream, k, 0, &old_mask, m);
 
 		/* Set corresponding flag so that the caller gets it. */
 		if (changed)
 			params->cmask |= 1 << k;
-		if (changed < 0)
-			return changed;
 	}
 
 	return 0;
@@ -312,14 +312,14 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 			old_interval = *i;
 
 		changed = snd_interval_refine(i, constrs_interval(constrs, k));
+		if (changed < 0)
+			return changed;
 
 		trace_hw_interval_param(substream, k, 0, &old_interval, i);
 
 		/* Set corresponding flag so that the caller gets it. */
 		if (changed)
 			params->cmask |= 1 << k;
-		if (changed < 0)
-			return changed;
 	}
 
 	return 0;
@@ -406,6 +406,8 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 		}
 
 		changed = r->func(params, r);
+		if (changed < 0)
+			return changed;
 
 		if (hw_is_mask(r->var)) {
 			trace_hw_mask_param(substream, r->var, k + 1,
@@ -428,8 +430,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 			vstamps[r->var] = stamp;
 			again = true;
 		}
-		if (changed < 0)
-			return changed;
+
 		stamp++;
 	}
 
@@ -527,13 +528,16 @@ static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
 		return PTR_ERR(params);
 
 	err = snd_pcm_hw_refine(substream, params);
-	if (err >= 0)
-		err = fixup_unreferenced_params(substream, params);
-	if (copy_to_user(_params, params, sizeof(*params))) {
-		if (!err)
-			err = -EFAULT;
-	}
+	if (err < 0)
+		goto end;
 
+	err = fixup_unreferenced_params(substream, params);
+	if (err < 0)
+		goto end;
+
+	if (copy_to_user(_params, params, sizeof(*params)))
+		err = -EFAULT;
+end:
 	kfree(params);
 	return err;
 }
@@ -749,11 +753,12 @@ static int snd_pcm_hw_params_user(struct snd_pcm_substream *substream,
 		return PTR_ERR(params);
 
 	err = snd_pcm_hw_params(substream, params);
-	if (copy_to_user(_params, params, sizeof(*params))) {
-		if (!err)
-			err = -EFAULT;
-	}
+	if (err < 0)
+		goto end;
 
+	if (copy_to_user(_params, params, sizeof(*params)))
+		err = -EFAULT;
+end:
 	kfree(params);
 	return err;
 }
@@ -3699,14 +3704,17 @@ static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_hw_convert_from_old_params(params, oparams);
 	err = snd_pcm_hw_refine(substream, params);
-	if (err >= 0)
-		err = fixup_unreferenced_params(substream, params);
-	snd_pcm_hw_convert_to_old_params(oparams, params);
-	if (copy_to_user(_oparams, oparams, sizeof(*oparams))) {
-		if (!err)
-			err = -EFAULT;
-	}
+	if (err < 0)
+		goto out_old;
+
+	err = fixup_unreferenced_params(substream, params);
+	if (err < 0)
+		goto out_old;
 
+	snd_pcm_hw_convert_to_old_params(oparams, params);
+	if (copy_to_user(_oparams, oparams, sizeof(*oparams)))
+		err = -EFAULT;
+out_old:
 	kfree(oparams);
 out:
 	kfree(params);
@@ -3729,14 +3737,16 @@ static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
 		err = PTR_ERR(oparams);
 		goto out;
 	}
+
 	snd_pcm_hw_convert_from_old_params(params, oparams);
 	err = snd_pcm_hw_params(substream, params);
-	snd_pcm_hw_convert_to_old_params(oparams, params);
-	if (copy_to_user(_oparams, oparams, sizeof(*oparams))) {
-		if (!err)
-			err = -EFAULT;
-	}
+	if (err < 0)
+		goto out_old;
 
+	snd_pcm_hw_convert_to_old_params(oparams, params);
+	if (copy_to_user(_oparams, oparams, sizeof(*oparams)))
+		err = -EFAULT;
+out_old:
 	kfree(oparams);
 out:
 	kfree(params);
-- 
2.11.0
