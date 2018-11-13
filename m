From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec: add missing route for ADC"
	to the asoc tree
Date: Tue, 13 Nov 2018 23:10:42 +0000 (GMT)
Message-ID: <20181113231042.E8F82440078@finisterre.ee.mobilebroadband>
References: <20181109042422.25653-2-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ECEF6267AF0
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 00:10:51 +0100 (CET)
In-Reply-To: <20181109042422.25653-2-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun8i-codec: add missing route for ADC

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

>From 9ee325d029c4abb75716851ce38863845911d605 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 8 Nov 2018 20:24:19 -0800
Subject: [PATCH] ASoC: sun8i-codec: add missing route for ADC

sun8i-codec misses a route from ADC to AIF1 Slot 0 ADC. Add it
to the driver to avoid adding it to every dts.

Fixes: eda85d1fee05d ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index c4196d4e5915..92c5de026c43 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -481,7 +481,11 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "AIF1 Slot 0 Right"},
 
-	/* ADC routes */
+	/* ADC Routes */
+	{ "AIF1 Slot 0 Right ADC", NULL, "ADC" },
+	{ "AIF1 Slot 0 Left ADC", NULL, "ADC" },
+
+	/* ADC Mixer Routes */
 	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
 	  "AIF1 Slot 0 Left ADC" },
 	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
-- 
2.19.1
