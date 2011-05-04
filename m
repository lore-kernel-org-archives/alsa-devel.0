From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 10/19] ASoC: upd9976: add microphone bias
	support
Date: Wed, 04 May 2011 21:45:44 +0800
Message-ID: <20110504134544.32443.43029.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E4E40103953
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:21 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/upd9976.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 8b2fff7..69d83ea 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -60,6 +60,23 @@ static inline int upd9976_write(struct snd_soc_codec *codec,
 	return ret;
 }
 
+static int upd9976_mic2_bias_event(struct snd_soc_dapm_widget *widget,
+				   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = widget->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_write(codec, UPD9976_AUXDBNC, 0xff);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_write(codec, UPD9976_AUXDBNC, 0x0);
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * Mixing Volume: from -25 dB to 6 dB in 1 dB steps.
  */
@@ -161,6 +178,12 @@ static const struct snd_soc_dapm_widget upd9976_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("PCM2 Mux", SND_SOC_NOPM, 0, 0,
 			 &upd9976_pcm2_mux_control),
 
+	/* Microphose Bias */
+	SND_SOC_DAPM_MICBIAS("MIC1 Bias", UPD9976_MICCTRL, 6, 0),
+	SND_SOC_DAPM_MICBIAS_E("MIC2 Bias", UPD9976_MICCTRL, 4, 0,
+			       upd9976_mic2_bias_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
 	/* PGA */
 	SND_SOC_DAPM_PGA("HP Playback Left", UPD9976_DRVPOWERCTRL,
 			 2, 0, NULL, 0),
