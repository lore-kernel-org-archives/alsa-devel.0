From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'
Date: Thu, 15 Aug 2019 17:06:02 +0800
Message-ID: <20190815090602.9000-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, bardliao@realtek.com, oder_chiou@realtek.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/rt1011.c:981:35: warning:
 dac_vol_tlv defined but not used [-Wunused-const-variable=]
sound/soc/codecs/rt1011.c:982:35: warning:
 adc_vol_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/rt1011.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 638abca..fa34565 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -978,9 +978,6 @@ static bool rt1011_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9435, 37, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1739, 37, 0);
-
 static const char * const rt1011_din_source_select[] = {
 	"Left",
 	"Right",
-- 
2.7.4
