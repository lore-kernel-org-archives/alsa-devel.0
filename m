From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: Fix wrong allocation size of dapm routes
Date: Fri, 29 Sep 2017 11:52:52 +0800
Message-ID: <20170929035252.19808-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The allocation size of dapm routes is wrong, correct it.

Fixes: d9f9c167edae ("ASoC: rockchip: Init dapm routes dynamically")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 30eed83e8a13..008452e55ef8 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -493,14 +493,18 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 	struct device_node *np_codec;
 	struct snd_soc_dai_link *dai;
 	struct snd_soc_dapm_route *routes;
-	int i, index;
+	int i, index, max_num_routes;
 
 	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
 				      GFP_KERNEL);
 	if (!card->dai_link)
 		return -ENOMEM;
 
-	routes = devm_kzalloc(dev, sizeof(rockchip_routes),
+	max_num_routes = 0;
+	for (i = 0; i < ARRAY_SIZE(rockchip_dais); i++)
+		max_num_routes += rockchip_routes[i].num_routes;
+
+	routes = devm_kzalloc(dev, max_num_routes * sizeof(*routes),
 			      GFP_KERNEL);
 	if (!routes)
 		return -ENOMEM;
-- 
2.11.0
