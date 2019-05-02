From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk case" to the asoc tree
Date: Thu,  2 May 2019 03:40:26 +0100 (BST)
Message-ID: <20190502024027.0D700441D3C@finisterre.ee.mobilebroadband>
References: <20190429105733.71FB83FBCC@swsrvapps-01.diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429105733.71FB83FBCC@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk case

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 1cd472d2ac1654f939ae01164b29e81fc76e0a93 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 29 Apr 2019 11:57:33 +0100
Subject: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled bclk/wclk
 case

For some platforms where DA7219 is the DAI clock master, BCLK/WCLK
will be set and enabled prior to the codec's hw_params() function
being called. It is possible the platform requires a different
BCLK configuration than would be chosen by hw_params(), for
example S16_LE format needed with a 64-bit frame to satisfy certain
devices using the clocks.

To handle those kinds of scenarios, the use of clk_round_rate() is
now employed as part of hw_params(). If BCLK is already enabled
then this function will just return the currently set rate, if it
is valid for the desired frame size, so the subsequent call to
clk_set_rate() will succeed and nothing changes with regards to
clocking. In addition the specific BCLK & WCLK recalc_rate()
implementations needed updating to always give back a real value,
as those functions are called as part of the clk init code and a
real value is needed for the clk_round_rate() call to work as
expected.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 5f5fa3416af3..206d01c6eb7e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1621,6 +1621,21 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 
 		if (bclk) {
 			bclk_rate = frame_size * sr;
+			/*
+			 * Rounding the rate here avoids failure trying to set a
+			 * new rate on an already enabled bclk. In that
+			 * instance this will just set the same rate as is
+			 * currently in use, and so should continue without
+			 * problem, as long as the BCLK rate is suitable for the
+			 * desired frame size.
+			 */
+			bclk_rate = clk_round_rate(bclk, bclk_rate);
+			if ((bclk_rate / sr) < frame_size) {
+				dev_err(component->dev,
+					"BCLK rate mismatch against frame size");
+				return -EINVAL;
+			}
+
 			ret = clk_set_rate(bclk, bclk_rate);
 			if (ret) {
 				dev_err(component->dev,
@@ -1927,9 +1942,6 @@ static unsigned long da7219_wclk_recalc_rate(struct clk_hw *hw,
 	struct snd_soc_component *component = da7219->component;
 	u8 fs = snd_soc_component_read32(component, DA7219_SR);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (fs & DA7219_SR_MASK) {
 	case DA7219_SR_8000:
 		return 8000;
@@ -2016,9 +2028,6 @@ static unsigned long da7219_bclk_recalc_rate(struct clk_hw *hw,
 	u8 bclks_per_wclk = snd_soc_component_read32(component,
 						     DA7219_DAI_CLK_MODE);
 
-	if (!da7219->master)
-		return 0;
-
 	switch (bclks_per_wclk & DA7219_DAI_BCLKS_PER_WCLK_MASK) {
 	case DA7219_DAI_BCLKS_PER_WCLK_32:
 		return parent_rate * 32;
-- 
2.20.1
