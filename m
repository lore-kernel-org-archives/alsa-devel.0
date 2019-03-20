From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Break out clock setting
	into separate function" to the asoc tree
Date: Wed, 20 Mar 2019 17:29:30 +0000 (GMT)
Message-ID: <20190320172930.1BA971126E4C@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43C15F80736
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 18:29:31 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Break out clock setting into separate function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bf31cbfbe25001036e1e096b1c260bf871766ea5 Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Mon, 18 Mar 2019 20:37:44 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Break out clock setting into separate
 function

Break the clock setting logic out from the main hw_params.  It's
rather large and unweildy and makes for a large function.  This
also better enables some of the following changes to the clock
tree access in the driver.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 96f1526cb258..1aa8f5aa4225 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -696,17 +696,13 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
-static int aic32x4_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
+static int aic32x4_setup_clocks(struct snd_soc_component *component,
+				unsigned int sample_rate,
+				unsigned int parent_rate)
 {
-	struct snd_soc_component *component = dai->component;
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
-	u8 iface1_reg = 0;
-	u8 dacsetup_reg = 0;
 	int i;
 
-	i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));
+	i = aic32x4_get_divs(parent_rate, sample_rate);
 	if (i < 0) {
 		printk(KERN_ERR "aic32x4: sampling rate not supported\n");
 		return i;
@@ -763,6 +759,20 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, AIC32X4_BCLKN,
 			    AIC32X4_BCLK_MASK, aic32x4_divs[i].blck_N);
 
+	return 0;
+}
+
+static int aic32x4_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
+	u8 iface1_reg = 0;
+	u8 dacsetup_reg = 0;
+
+	aic32x4_setup_clocks(component, params_rate(params), aic32x4->sysclk);
+
 	switch (params_width(params)) {
 	case 16:
 		iface1_reg |= (AIC32X4_WORD_LEN_16BITS <<
-- 
2.20.1
