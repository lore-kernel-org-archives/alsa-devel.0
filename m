From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l51: add support of master mode" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:23 +0700 (+07)
Message-ID: <20190404135823.715FD441D3B@finisterre.ee.mobilebroadband>
References: <1554297817-14154-5-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554297817-14154-5-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l51: add support of master mode

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

>From 2f7c4ce09a43457666592f36e18a5db58cca86a0 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:34 +0200
Subject: [PATCH] ASoC: cs42l51: add support of master mode

Add support of master mode for cs42l51 cirrus audio codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 9b3ffa16b204..397b68901d1c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -340,6 +340,19 @@ static struct cs42l51_ratios slave_auto_ratios[] = {
 	{  256, CS42L51_DSM_MODE, 1 }, {  384, CS42L51_DSM_MODE, 1 },
 };
 
+/*
+ * Master mode mclk/fs ratios.
+ * Recommended configurations are SSM for 4-50khz and DSM for 50-100kHz ranges
+ * The table below provides support of following ratios:
+ * 128: SSM (%128) with div2 disabled
+ * 256: SSM (%128) with div2 enabled
+ * In both cases, if sampling rate is above 50kHz, SSM is overridden
+ * with DSM (%128) configuration
+ */
+static struct cs42l51_ratios master_ratios[] = {
+	{ 128, CS42L51_SSM_MODE, 0 }, { 256, CS42L51_SSM_MODE, 1 },
+};
+
 static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -362,11 +375,13 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	unsigned int ratio;
 	struct cs42l51_ratios *ratios = NULL;
 	int nr_ratios = 0;
-	int intf_ctl, power_ctl, fmt;
+	int intf_ctl, power_ctl, fmt, mode;
 
 	switch (cs42l51->func) {
 	case MODE_MASTER:
-		return -EINVAL;
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
 	case MODE_SLAVE:
 		ratios = slave_ratios;
 		nr_ratios = ARRAY_SIZE(slave_ratios);
@@ -402,7 +417,16 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	switch (cs42l51->func) {
 	case MODE_MASTER:
 		intf_ctl |= CS42L51_INTF_CTL_MASTER;
-		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		mode = ratios[i].speed_mode;
+		/* Force DSM mode if sampling rate is above 50kHz */
+		if (rate > 50000)
+			mode = CS42L51_DSM_MODE;
+		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(mode);
+		/*
+		 * Auto detect mode is not applicable for master mode and has to
+		 * be disabled. Otherwise SPEED[1:0] bits will be ignored.
+		 */
+		power_ctl &= ~CS42L51_MIC_POWER_CTL_AUTO;
 		break;
 	case MODE_SLAVE:
 		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
-- 
2.20.1
