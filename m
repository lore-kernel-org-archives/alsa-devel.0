From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 2/5] ASoC: rockchip-max98090: Fix the Headset Mic route.
Date: Mon,  9 May 2016 12:46:32 +0200
Message-ID: <1462790795-25345-3-git-send-email-enric.balletbo@collabora.com>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

The path Headset Mic --> MICBIAS is wrong because connects a non-supply
widget as a source with a supply widget as a sink. It's the other way
around:

  MICBIAS (source) --> Headset Mic (sink).

This patch also shut up the following error message:

 rockchip-snd-max98090 sound: Connecting non-supply widget to supply widget is not supported (Headset Mic -> MICBIAS)
 rockchip-snd-max98090 sound: ASoC: no dapm match for Headset Mic --> (null) --> MICBIAS
 rockchip-snd-max98090 sound: ASoC: Failed to add route Headset Mic -> direct -> MICBIAS

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - Improve log message.

 sound/soc/rockchip/rockchip_max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index abb64a5..3da7891 100644
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
2.1.0
