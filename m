From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 21/21] ALSA: pcm: return error immediately
	at refine ioctl
Date: Sun, 14 May 2017 17:57:56 +0900
Message-ID: <20170514085756.22382-22-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8B06B266BCE
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:06 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When refining parameters of runtime of PCM substream, helper functions can
return error but invalid data is copied to userspace. This copying is
useless.

This commit handles the error immediately. Old hw_refine/hw_params
implementation include the same issue and this commit modifies them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 05230f4..c8d2b85 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -614,13 +614,16 @@ static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
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
@@ -3759,9 +3762,9 @@ static int snd_pcm_hw_refine_old_user(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_hw_convert_from_old_params(params, oparams);
 	err = snd_pcm_hw_refine(substream, params);
-	snd_pcm_hw_convert_to_old_params(oparams, params);
-	if (copy_to_user(_oparams, oparams, sizeof(*oparams))) {
-		if (!err)
+	if (err >= 0) {
+		snd_pcm_hw_convert_to_old_params(oparams, params);
+		if (copy_to_user(_oparams, oparams, sizeof(*oparams)))
 			err = -EFAULT;
 	}
 
@@ -3789,9 +3792,9 @@ static int snd_pcm_hw_params_old_user(struct snd_pcm_substream *substream,
 	}
 	snd_pcm_hw_convert_from_old_params(params, oparams);
 	err = snd_pcm_hw_params(substream, params);
-	snd_pcm_hw_convert_to_old_params(oparams, params);
-	if (copy_to_user(_oparams, oparams, sizeof(*oparams))) {
-		if (!err)
+	if (err >= 0) {
+		snd_pcm_hw_convert_to_old_params(oparams, params);
+		if (copy_to_user(_oparams, oparams, sizeof(*oparams)))
 			err = -EFAULT;
 	}
 
-- 
2.9.3
