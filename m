From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: ssm2602: Support setting the
	oscillator and the clock output state
Date: Tue, 27 Sep 2011 11:08:48 +0200
Message-ID: <1317114528-16736-3-git-send-email-lars@metafoo.de>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-133.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id EA3AC243DD
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 11:09:23 +0200 (CEST)
In-Reply-To: <1317114528-16736-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Currently the oscillator is always enabled and the clock output is always
disabled. This patch adds support for controlling the oscillator and clock
output state through snd_soc_dai_set_sysclk. Which makes it possible to
disable or enable them dynamically according to the requirements of the board
on which the CODEC is used.

This patch also slightly modifies the behavior as to when the oscillator is
going to be disabled in low-power states. Previously it would only be disabled
in BIAS_OFF, now it is also going to be disabled in BIAS_STANDBY, since no
components which depend on it should be active in this state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |   67 +++++++++++++++++++++++++++++++++----------
 sound/soc/codecs/ssm2602.h |    6 +++-
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index c9e0fdb..e149ec6 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -59,6 +59,7 @@ struct ssm2602_priv {
 	struct snd_pcm_substream *slave_substream;
 
 	enum ssm2602_type type;
+	unsigned int clk_out_pwr;
 };
 
 /*
@@ -356,16 +357,46 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	switch (freq) {
-	case 11289600:
-	case 12000000:
-	case 12288000:
-	case 16934400:
-	case 18432000:
-		ssm2602->sysclk = freq;
-		return 0;
+
+	if (dir == SND_SOC_CLOCK_IN) {
+		if (clk_id != SSM2602_SYSCLK)
+			return -EINVAL;
+
+		switch (freq) {
+		case 11289600:
+		case 12000000:
+		case 12288000:
+		case 16934400:
+		case 18432000:
+			ssm2602->sysclk = freq;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		unsigned int mask;
+
+		switch (clk_id) {
+		case SSM2602_CLK_CLKOUT:
+			mask = PWR_CLK_OUT_PDN;
+			break;
+		case SSM2602_CLK_XTO:
+			mask = PWR_OSC_PDN;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (freq == 0)
+			ssm2602->clk_out_pwr |= mask;
+		else
+			ssm2602->clk_out_pwr &= ~mask;
+
+		snd_soc_update_bits(codec, SSM2602_PWR,
+			PWR_CLK_OUT_PDN | PWR_OSC_PDN, ssm2602->clk_out_pwr);
 	}
-	return -EINVAL;
+
+	return 0;
 }
 
 static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -430,23 +461,27 @@ static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg = snd_soc_read(codec, SSM2602_PWR);
-	reg &= ~(PWR_POWER_OFF | PWR_OSC_PDN);
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* vref/mid, osc on, dac unmute */
-		snd_soc_write(codec, SSM2602_PWR, reg);
+		/* vref/mid on, osc and clkout on if enabled */
+		snd_soc_update_bits(codec, SSM2602_PWR,
+			PWR_POWER_OFF | PWR_CLK_OUT_PDN | PWR_OSC_PDN,
+			ssm2602->clk_out_pwr);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* everything off except vref/vmid, */
-		snd_soc_write(codec, SSM2602_PWR, reg | PWR_CLK_OUT_PDN);
+		snd_soc_update_bits(codec, SSM2602_PWR,
+			PWR_POWER_OFF | PWR_CLK_OUT_PDN | PWR_OSC_PDN,
+			PWR_CLK_OUT_PDN | PWR_OSC_PDN);
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* everything off, dac mute, inactive */
-		snd_soc_write(codec, SSM2602_PWR, 0xffff);
+		/* everything off */
+		snd_soc_update_bits(codec, SSM2602_PWR,
+			PWR_POWER_OFF, PWR_POWER_OFF);
 		break;
 
 	}
diff --git a/sound/soc/codecs/ssm2602.h b/sound/soc/codecs/ssm2602.h
index b98c691..fbd07d7 100644
--- a/sound/soc/codecs/ssm2602.h
+++ b/sound/soc/codecs/ssm2602.h
@@ -116,6 +116,10 @@
 
 #define SSM2602_CACHEREGNUM 	10
 
-#define SSM2602_SYSCLK	0
+enum ssm2602_clk {
+	SSM2602_SYSCLK,
+	SSM2602_CLK_CLKOUT,
+	SSM2602_CLK_XTO
+};
 
 #endif
-- 
1.7.2.5
