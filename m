From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 1/1] ASoC: Fix incorrect DSP format
	in OMAP McBSP DAI and affected drivers
Date: Mon, 22 Dec 2008 10:21:36 +0200
Message-ID: <1229934096-4715-2-git-send-email-jarkko.nikula@nokia.com>
References: <1229934096-4715-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 73E7E1037EF
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 09:21:55 +0100 (CET)
In-Reply-To: <1229934096-4715-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

- OMAP McBSP DAI driver claims to support DSP_A format which has 1-bit data
  delay but configures link for 0-bit data delay which is in fact DSP_B
- Fix this by changing format from DSP_A to DSP_B
- Fix also TLV320AIC23 codec and OSK5912 machine drivers since the same
  error is populated also there

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/tlv320aic23.c |    2 +-
 sound/soc/omap/omap-mcbsp.c    |    4 ++--
 sound/soc/omap/osk5912.c       |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 39f5b98..cfdea00 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -541,7 +541,7 @@ static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_I2S:
 		iface_reg |= TLV320AIC23_FOR_I2S;
 		break;
-	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg |= TLV320AIC23_FOR_DSP;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7b86373..ec5e18a 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -270,7 +270,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr2	|= FPER(wlen * 2 - 1);
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
-	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(wlen * channels - 2);
 		break;
@@ -309,7 +309,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
-	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 845bf41..cd41a94 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -61,7 +61,7 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set codec DAI configuration */
 	err = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_DSP_B |
 				  SND_SOC_DAIFMT_NB_IF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
@@ -71,7 +71,7 @@ static int osk_hw_params(struct snd_pcm_substream *substream,
 
 	/* Set cpu DAI configuration */
 	err = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_DSP_B |
 				  SND_SOC_DAIFMT_NB_IF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (err < 0) {
-- 
1.5.6.5
