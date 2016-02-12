From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 10/15] ASoC: hdac_hdmi: Fix possible memory
	leak in hw_params
Date: Fri, 12 Feb 2016 07:46:10 +0530
Message-ID: <1455243375-16067-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A3D265A82
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2016 03:15:34 +0100 (CET)
In-Reply-To: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

It's possible for hw_params to be called two times. So add NULL
check to prevent memory leak.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 36f1200..40db292 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -405,9 +405,14 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 		return -ENODEV;
 	}
 
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
-	if (!dd)
-		return -ENOMEM;
+	dd = (struct hdac_ext_dma_params *)
+		snd_soc_dai_get_dma_data(dai, substream);
+	if (!dd) {
+		dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+		if (!dd)
+			return -ENOMEM;
+	}
+
 	dd->format = snd_hdac_calc_stream_format(params_rate(hparams),
 			params_channels(hparams), params_format(hparams),
 			24, 0);
@@ -433,9 +438,11 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
 
-	kfree(dd);
+	if (dd) {
+		snd_soc_dai_set_dma_data(dai, substream, NULL);
+		kfree(dd);
+	}
 
 	return 0;
 }
-- 
1.9.1
