From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator
 supply to cpvdd" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:16 +0000 (GMT)
Message-ID: <20190219155016.29FAB11284BB@debutante.sirena.org.uk>
References: <20190213070457.26049-2-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190213070457.26049-2-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to cpvdd

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

>From 5fd812e6f5ae0376134234ceb70e8de541ccb10d Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 13 Feb 2019 15:04:56 +0800
Subject: [PATCH] ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator
 supply to cpvdd

The A64 datasheet lists the supply rail for the headphone amp's charge
pump as "CPVDD". cpvdd-supply is the name of the property for this power
rail specified in the device tree bindings. "HPVCC" was the name used in
the A33 datasheet for the same function.

Rename the supply so it matches the datasheet, bindings, and the subject
from the original commit.

Fixes: ca0412a05756 ("ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index df1fed0aa001..d105c90c3706 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -274,7 +274,7 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
-	SND_SOC_DAPM_REGULATOR_SUPPLY("hpvcc", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
@@ -362,7 +362,7 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
 	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
-	{ "Headphone Amp", NULL, "hpvcc" },
+	{ "Headphone Amp", NULL, "cpvdd" },
 	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
-- 
2.20.1
