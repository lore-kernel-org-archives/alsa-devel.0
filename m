From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 20/21] ALSA: pcm: return error immediately
	for parameters refinement
Date: Sun, 14 May 2017 17:57:55 +0900
Message-ID: <20170514085756.22382-21-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 20358266BD4
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

When refining mask/interval parameters, helper functions can return error
code. This error is not handled immediately, thus there're useless
processing.

This commit handles the error immediately.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 92ab8b2..05230f4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -288,11 +288,13 @@ static int constrain_mask_params(struct snd_pcm_substream *substream,
 
 		trace_hw_params_mask(substream, k, -1, &old_mask, m);
 
+		if (changed < 0)
+			return changed;
+
+
 		/* Set corresponding flag so that applications get it. */
 		if (changed)
 			params->cmask |= 1 << k;
-		if (changed < 0)
-			return changed;
 	}
 
 	return 0;
@@ -326,11 +328,12 @@ static int constrain_interval_params(struct snd_pcm_substream *substream,
 
 		trace_hw_params_interval(substream, k, -1, &old_interval, i);
 
+		if (changed < 0)
+			return changed;
+
 		/* Set corresponding flag so that applications get it. */
 		if (changed)
 			params->cmask |= 1 << k;
-		if (changed < 0)
-			return changed;
 	}
 
 	return 0;
@@ -431,6 +434,9 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 						 hw_param_interval(params, r->var));
 		}
 
+		if (changed < 0)
+			return changed;
+
 		rstamps[k] = stamp;
 
 		/*
@@ -443,8 +449,6 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
 			vstamps[r->var] = stamp;
 			again = true;
 		}
-		if (changed < 0)
-			return changed;
 
 		stamp++;
 	}
-- 
2.9.3
