From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH v2 2/3] ASoC: rockchip: i2s: set TDL and RDL to 16 samples
Date: Wed, 24 Dec 2014 17:37:01 +0800
Message-ID: <1419413822-11539-3-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, heiko@sntech.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sonnyrao@chromium.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Jianqun Xu <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Set Transmit Data Level(TDL) and Receive Data Level(RDL) to 16 samples.
Without this setting, the TDL is default to be 0x00 (means 0 sample),
and the RDL is default to be 0x1f (means 32 samples).

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
changes since v1:
- modify commit message "bit" to "sample", suggested by dgreid

 sound/soc/rockchip/rockchip_i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c74ba37..1cd7efc 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -247,6 +247,10 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
 	regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
+	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
+			   I2S_DMACR_TDL(16));
+	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
+			   I2S_DMACR_RDL(16));
 
 	return 0;
 }
-- 
1.9.1
