From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 3/5] ASoC: rockchip-max98090: Fix jack detection and event reporting.
Date: Mon,  9 May 2016 12:46:33 +0200
Message-ID: <1462790795-25345-4-git-send-email-enric.balletbo@collabora.com>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Physically there is a jackset which includes a Headphone and a Jackset
Mic pin. The patch add thw two pins with the correct pin name so the
DAPM management can find the pin and make the jack detection and event
reporting work again.

The patch also shut up the following error:

 rockchip-snd-max98090 sound: ASoC: DAPM unknown pin Headset Jack

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - Improve log message.
 - Include Headphone and Jackset Mic pins.

 sound/soc/rockchip/rockchip_max98090.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 3da7891..e70ffad 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -34,13 +34,18 @@
 #define DRV_NAME "rockchip-snd-max98090"
 
 static struct snd_soc_jack headset_jack;
+
+/* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin headset_jack_pins[] = {
 	{
-		.pin = "Headset Jack",
-		.mask = SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-			SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3,
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
 	},
+
 };
 
 static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
-- 
2.1.0
