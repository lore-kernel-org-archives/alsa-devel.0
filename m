From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip-max98090: Fix the Headset Mic route." to the asoc tree
Date: Tue, 10 May 2016 19:49:59 +0100
Message-ID: <E1b0CjH-0008Tj-FE@debutante>
References: <1462435421-21205-5-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462435421-21205-5-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip-max98090: Fix the Headset Mic route.

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

>From 570204232a9578e5d098e7ad0c0cde0b59d30089 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Mon, 9 May 2016 12:46:32 +0200
Subject: [PATCH] ASoC: rockchip-max98090: Fix the Headset Mic route.

The path Headset Mic --> MICBIAS is wrong because connects a non-supply
widget as a source with a supply widget as a sink. It's the other way
around:

  MICBIAS (source) --> Headset Mic (sink).

This patch also shut up the following error message:

 rockchip-snd-max98090 sound: Connecting non-supply widget to supply widget is not supported (Headset Mic -> MICBIAS)
 rockchip-snd-max98090 sound: ASoC: no dapm match for Headset Mic --> (null) --> MICBIAS
 rockchip-snd-max98090 sound: ASoC: Failed to add route Headset Mic -> direct -> MICBIAS

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index abb64a553967..3da7891b7dfb 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -53,7 +53,7 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
 	{"IN34", NULL, "MICBIAS"},
-	{"MICBIAS", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
 	{"Headphone", NULL, "HPR"},
-- 
2.8.1
