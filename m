From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 10/13] ASoC: OMAP: Add support for mono audio
	links in McBSP DAI
Date: Tue, 25 Nov 2008 15:44:46 +0000
Message-ID: <1227627889-8373-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD07324499
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:52 +0100 (CET)
In-Reply-To: <1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Patch adds support for mono audio links so that McBSP DAI can operate with
real mono codecs. In I2S, the signalling remains the same but only first
frame (left channel) is transmitting audio data and second frame having null
data. In DSP_A, only first frame is transmitted.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 252bc7e..e8f1314 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -203,7 +203,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
-	int wlen;
+	int wlen, channels;
 	unsigned long port;
 
 	if (cpu_class_is_omap1()) {
@@ -232,12 +232,17 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	switch (params_channels(params)) {
+	channels = params_channels(params);
+	switch (channels) {
 	case 2:
-		/* Set 1 word per (McBPSP) frame and use dual-phase frames */
-		regs->rcr2	|= RFRLEN2(1 - 1) | RPHASE;
+		/* Use dual-phase frames */
+		regs->rcr2	|= RPHASE;
+		regs->xcr2	|= XPHASE;
+	case 1:
+		/* Set 1 word per (McBSP) frame */
+		regs->rcr2	|= RFRLEN2(1 - 1);
 		regs->rcr1	|= RFRLEN1(1 - 1);
-		regs->xcr2	|= XFRLEN2(1 - 1) | XPHASE;
+		regs->xcr2	|= XFRLEN2(1 - 1);
 		regs->xcr1	|= XFRLEN1(1 - 1);
 		break;
 	default:
@@ -266,8 +271,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		regs->srgr2	|= FPER(wlen * 2 - 1);
-		regs->srgr1	|= FWID(wlen * 2 - 2);
+		regs->srgr2	|= FPER(wlen * channels - 1);
+		regs->srgr1	|= FWID(wlen * channels - 2);
 		break;
 	}
 
@@ -457,13 +462,13 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	.name = "omap-mcbsp-dai-"#link_id,			\
 	.id = (link_id),					\
 	.playback = {						\
-		.channels_min = 2,				\
+		.channels_min = 1,				\
 		.channels_max = 2,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
 	.capture = {						\
-		.channels_min = 2,				\
+		.channels_min = 1,				\
 		.channels_max = 2,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
-- 
1.5.6.5
