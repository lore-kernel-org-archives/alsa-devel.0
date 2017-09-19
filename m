From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v3 2/5] ASoC: rockchip: Add dapm route for DMic
Date: Tue, 19 Sep 2017 20:57:57 +0800
Message-ID: <20170919125800.336-3-jeffy.chen@rock-chips.com>
References: <20170919125800.336-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919125800.336-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add dapm route for DMIC codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/rk3399_gru_sound.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index b050510be65f..ad19e391c4a6 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -55,6 +55,7 @@ static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMIC1L", NULL, "Int Mic"},
 	{"DMIC1R", NULL, "Int Mic"},
+	{"DMic", NULL, "Int Mic"},
 
 	/* Output Lines */
 	{"Headphones", NULL, "HPL"},
-- 
2.11.0
