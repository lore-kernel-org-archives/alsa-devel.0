From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip-max98090: Fix jack detection and event reporting." to the asoc tree
Date: Tue, 10 May 2016 19:49:56 +0100
Message-ID: <E1b0CjE-0008Nv-EN@debutante>
References: <1462790795-25345-4-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462790795-25345-4-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip-max98090: Fix jack detection and event reporting.

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

>From 525aba92762666aa6fa56e1b92e7d4959bda426a Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Mon, 9 May 2016 12:46:33 +0200
Subject: [PATCH] ASoC: rockchip-max98090: Fix jack detection and event
 reporting.

Physically there is a jackset which includes a Headphone and a Jackset
Mic pin. The patch add thw two pins with the correct pin name so the
DAPM management can find the pin and make the jack detection and event
reporting work again.

The patch also shut up the following error:

 rockchip-snd-max98090 sound: ASoC: DAPM unknown pin Headset Jack

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 3da7891b7dfb..e70ffad07184 100644
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
2.8.1
