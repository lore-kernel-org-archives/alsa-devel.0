From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: constify snd_soc_ops structures
Date: Wed, 30 Aug 2017 17:58:14 +0800
Message-ID: <20170830095814.2030-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add const to dp/dmic snd_soc_ops.

Fixes: 626d84db64d7 (ASoC: rockchip: Add support for DMIC codec)
Fixes: 3313faf1053e (ASoC: rockchip: Add support for DP codec)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 5ab25962cabd..0513fe480353 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -301,11 +301,11 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_cdndp_ops = {
+static const struct snd_soc_ops rockchip_sound_cdndp_ops = {
 	.hw_params = rockchip_sound_cdndp_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_dmic_ops = {
+static const struct snd_soc_ops rockchip_sound_dmic_ops = {
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
 
-- 
2.11.0
