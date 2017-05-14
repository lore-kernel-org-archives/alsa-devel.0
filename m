From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 12/21] ALSA: pcm: add tracepoints for
	selection process of hardware parameters at
	SNDRV_PCM_IOCTL_HW_PARAMS
Date: Sun, 14 May 2017 17:57:47 +0900
Message-ID: <20170514085756.22382-13-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id BC2AC266B02
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
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

Results of ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE and
SNDRV_PCM_IOCTL_HW_PARAMS are different, because the latter has single
value for several parameters; e.g. channels of PCM substream. Selection
of the single value is done independently of application of constraints
and rules. It's helpful for developers to trace the selection process

This commit adds tracepoints to snd_pcm_hw_params_choose() for the
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2c5a4d9..47af1a8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -555,11 +555,35 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
 	const int *v;
 	int err;
 
+	struct snd_interval __maybe_unused old_interval;
+	struct snd_mask __maybe_unused old_mask;
+
 	for (v = vars; *v != -1; v++) {
+		/* Keep old parameter to trace. */
+		if (trace_hw_params_mask_enabled()) {
+			if (hw_is_mask(*v))
+				old_mask = *hw_param_mask(params, *v);
+		}
+		if (trace_hw_params_interval_enabled()) {
+			if (hw_is_interval(*v))
+				old_interval = *hw_param_interval(params, *v);
+		}
+
 		if (*v != SNDRV_PCM_HW_PARAM_BUFFER_SIZE)
 			err = snd_pcm_hw_param_first(pcm, params, *v, NULL);
 		else
 			err = snd_pcm_hw_param_last(pcm, params, *v, NULL);
+
+		/* Trace the parameter. */
+		if (hw_is_mask(*v)) {
+			trace_hw_params_mask(pcm, *v, -1, &old_mask,
+					     hw_param_mask(params, *v));
+		}
+		if (hw_is_interval(*v)) {
+			trace_hw_params_interval(pcm, *v, -1, &old_interval,
+						 hw_param_interval(params, *v));
+		}
+
 		if (snd_BUG_ON(err < 0))
 			return err;
 	}
-- 
2.9.3
