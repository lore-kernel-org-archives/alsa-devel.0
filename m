From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: pcm: add tracepoints for final
	selection process of hardware parameters
Date: Fri,  9 Jun 2017 21:46:49 +0900
Message-ID: <20170609124650.19989-3-o-takashi@sakamocchi.jp>
References: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 1BA74267639
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 14:47:00 +0200 (CEST)
In-Reply-To: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
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

Results of ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE and
SNDRV_PCM_IOCTL_HW_PARAMS are different, because the latter has single
value for several parameters; e.g. channels of PCM substream. Selection
of the single value is done independently of application of constraints.
It's helpful for developers to trace the selection process.

This commit adds tracepoints to snd_pcm_hw_params_choose() for the
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8d9d181b1c03..076187ae8859 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -598,16 +598,38 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 		-1
 	};
 	const int *v;
+	struct snd_mask old_mask;
+	struct snd_interval old_interval;
 	int err;
 
 	for (v = vars; *v != -1; v++) {
+		/* Keep old parameter to trace. */
+		if (trace_hw_mask_param_enabled()) {
+			if (hw_is_mask(*v))
+				old_mask = *hw_param_mask(params, *v);
+		}
+		if (trace_hw_interval_param_enabled()) {
+			if (hw_is_interval(*v))
+				old_interval = *hw_param_interval(params, *v);
+		}
 		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
 			err = snd_pcm_hw_param_first(pcm, params, *v, NULL);
 		else
 			err = snd_pcm_hw_param_last(pcm, params, *v, NULL);
 		if (snd_BUG_ON(err < 0))
 			return err;
+
+		/* Trace the parameter. */
+		if (hw_is_mask(*v)) {
+			trace_hw_mask_param(pcm, *v, 0, &old_mask,
+					    hw_param_mask(params, *v));
+		}
+		if (hw_is_interval(*v)) {
+			trace_hw_interval_param(pcm, *v, 0, &old_interval,
+						hw_param_interval(params, *v));
+		}
 	}
+
 	return 0;
 }
 
-- 
2.11.0
