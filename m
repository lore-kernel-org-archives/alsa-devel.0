From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec: Convert to use
	SND_SOC_DAPM_AIF_IN" to the asoc tree
Date: Tue, 21 Mar 2017 18:45:46 +0000
Message-ID: <E1cqOmw-00017o-D1@debutante>
References: <20170318075509.3836-5-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1280448249241001156=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E78226736C
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 19:46:04 +0100 (CET)
In-Reply-To: <20170318075509.3836-5-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============1280448249241001156==
Content-Type: text/plain

The patch

   ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN

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

>From d1792285ca63e17f8a7eb42efa48834c261a2d8f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Sat, 18 Mar 2017 08:55:08 +0100
Subject: [PATCH] ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the driver to use SND_SOC_DAPM_AIF_IN instead of
SND_SOC_DAPM_DAC.
Rename the interface's widgets to be more precise on which slot
the interface is connected.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index adb13fbd2006..7527ba29a5a0 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -281,11 +281,13 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
 			    0, NULL, 0),
 
-	/* Analog DAC */
-	SND_SOC_DAPM_DAC("Digital Left DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
-			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
-	SND_SOC_DAPM_DAC("Digital Right DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
-			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
+	/* Analog DAC AIF */
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left", "Playback", 0,
+			    SUN8I_AIF1_DACDAT_CTRL,
+			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right", "Playback", 0,
+			    SUN8I_AIF1_DACDAT_CTRL,
+			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* DAC Mixers */
 	SND_SOC_DAPM_MIXER("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
@@ -331,14 +333,14 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "DAC", NULL, "MODCLK DAC" },
 
 	/* DAC Routes */
-	{ "Digital Left DAC", NULL, "DAC" },
-	{ "Digital Right DAC", NULL, "DAC" },
+	{ "AIF1 Slot 0 Right", NULL, "DAC" },
+	{ "AIF1 Slot 0 Left", NULL, "DAC" },
 
 	/* DAC Mixer Routes */
 	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
-	  "Digital Left DAC"},
+	  "AIF1 Slot 0 Left"},
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
-	  "Digital Right DAC"},
+	  "AIF1 Slot 0 Right"},
 };
 
 static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-- 
2.11.0


--===============1280448249241001156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1280448249241001156==--
