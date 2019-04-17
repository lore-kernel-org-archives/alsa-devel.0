From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tlv320aic32x4: Remove set but not used variable 'mclk_rate'
Date: Wed, 17 Apr 2019 23:01:57 +0800
Message-ID: <20190417150157.24044-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nh6z@nh6z.net
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_setup_clocks':
sound/soc/codecs/tlv320aic32x4.c:669:16: warning: variable 'mclk_rate' set but not used [-Wunused-but-set-variable]

It is not used since introduction in
commit 96c3bb00239d ("ASoC: tlv320aic32x4: Dynamically Determine Clocking")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6edee05..83608f3 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -684,9 +684,8 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	u8 madc, nadc, mdac, ndac, max_nadc, min_mdac, max_ndac;
 	u8 dosr_increment;
 	u16 max_dosr, min_dosr;
-	unsigned long mclk_rate, adc_clock_rate, dac_clock_rate;
+	unsigned long adc_clock_rate, dac_clock_rate;
 	int ret;
-	struct clk *mclk;
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "pll" },
@@ -700,9 +699,6 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	mclk = clk_get_parent(clocks[1].clk);
-	mclk_rate = clk_get_rate(mclk);
-
 	if (sample_rate <= 48000) {
 		aosr = 128;
 		adc_resource_class = 6;
-- 
2.7.4
