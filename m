From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: Add control for HS and HF mono
	to stereo selection" to the asoc tree
Date: Wed, 05 Apr 2017 18:31:07 +0100
Message-ID: <E1cvolv-0000sL-KQ@debutante>
References: <20170403101239.2721-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CEEB526718D
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:31:16 +0200 (CEST)
In-Reply-To: <20170403101239.2721-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl6040: Add control for HS and HF mono to stereo selection

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0636e8b380418bda5b52bb06c8ae285028de3793 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 3 Apr 2017 13:12:39 +0300
Subject: [PATCH] ASoC: twl6040: Add control for HS and HF mono to stereo
 selection

The new controls will give user the ability to route the left PDM channel
data to the right headset/handsfree DAC.
HS mono to stereo switch: PDM channel 1 (or mono) data to both HS DAC.
HF mono to stereo switch: PDM channel 3 data to both HF DAC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 748036e851ea..2b6ad09e0886 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -606,6 +606,14 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 		twl6040_headset_power_get_enum,
 		twl6040_headset_power_put_enum),
 
+	/* Left HS PDM data routed to Right HSDAC */
+	SOC_SINGLE("Headset Mono to Stereo Playback Switch",
+		TWL6040_REG_HSRCTL, 7, 1, 0),
+
+	/* Left HF PDM data routed to Right HFDAC */
+	SOC_SINGLE("Handsfree Mono to Stereo Playback Switch",
+		TWL6040_REG_HFRCTL, 5, 1, 0),
+
 	SOC_ENUM_EXT("PLL Selection", twl6040_power_mode_enum,
 		twl6040_pll_get_enum, twl6040_pll_put_enum),
 };
-- 
2.11.0
