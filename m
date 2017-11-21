From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp
	dailink
Date: Tue, 21 Nov 2017 16:25:17 +0800
Message-ID: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A97F2670BC
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 09:25:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, mka@chromium.org, linux-arm-kernel@lists.infradead.org, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

The rt5514 dsp captures pcm data through spi directly, so we should not
use rockchip-i2s as it's cpu dai like other codecs.

Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index d64fbbd50544..aa8ffd035377 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -367,7 +367,8 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_dai_name = "rt5514-dsp-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
 	},
 };
 
@@ -528,7 +529,18 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		if (index < 0)
 			continue;
 
-		np_cpu = (index == DAILINK_CDNDP) ? np_cpu1 : np_cpu0;
+		switch (index) {
+		case DAILINK_CDNDP:
+			np_cpu = np_cpu1;
+			break;
+		case DAILINK_RT5514_DSP:
+			np_cpu = np_codec;
+			break;
+		default:
+			np_cpu = np_cpu0;
+			break;
+		}
+
 		if (!np_cpu) {
 			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
 				rockchip_dais[index].name);
@@ -538,7 +550,8 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
 		dai = &card->dai_link[card->num_links++];
 		*dai = rockchip_dais[index];
 
-		dai->codec_of_node = np_codec;
+		if (!dai->codec_name)
+			dai->codec_of_node = np_codec;
 		dai->platform_of_node = np_cpu;
 		dai->cpu_of_node = np_cpu;
 
-- 
2.11.0
