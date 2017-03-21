From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec: Remove analog "HP" widget"
	to the asoc tree
Date: Tue, 21 Mar 2017 18:45:57 +0000
Message-ID: <E1cqOn7-0001Bk-6c@debutante>
References: <20170210094133.11382-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281130112911099090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F4326737F
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 19:46:41 +0100 (CET)
In-Reply-To: <20170210094133.11382-2-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============1281130112911099090==
Content-Type: text/plain

The patch

   ASoC: sun8i-codec: Remove analog "HP" widget

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

>From a82f16188a32a3c889916c582ea2d9188e3c2734 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Sat, 18 Mar 2017 08:55:05 +0100
Subject: [PATCH] ASoC: sun8i-codec: Remove analog "HP" widget
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "HP" widget is already present and take part to
the analog part (sun8i-codec-analog).

Remove it from the digital part as it is unnecessary.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index b92bdc8361af..d60f6fbd36a2 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -321,8 +321,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST DAC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
-
-	SND_SOC_DAPM_OUTPUT("HP"),
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
@@ -344,10 +342,6 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	/* DAC Mixer Routes */
 	{ "Left DAC Mixer", "LSlot 0", "Digital Left DAC"},
 	{ "Right DAC Mixer", "RSlot 0", "Digital Right DAC"},
-
-	/* End of route : HP out */
-	{ "HP", NULL, "Left DAC Mixer" },
-	{ "HP", NULL, "Right DAC Mixer" },
 };
 
 static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-- 
2.11.0


--===============1281130112911099090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1281130112911099090==--
