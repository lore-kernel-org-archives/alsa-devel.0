From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 09/14] ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev
Date: Wed,  5 Jun 2019 15:45:51 +0200
Message-ID: <20190605134556.10322-10-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When driver is probed, we iterate over NHLT and check if clk entries are
present. For each such entry we call register_skl_clk and keep the
result in data->clk[].
Currently data->clk is sparsely indexed using NHLT table iterator, while
when freeing we use number of registered entries. Let's just use
data->avail_clk_cnt as index, so it can be reset back in
unregister_src_clk.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-ssp-clk.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index cda1b5fa7436..5bb6e40d4d3e 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -276,10 +276,8 @@ static void unregister_parent_src_clk(struct skl_clk_parent *pclk,
 
 static void unregister_src_clk(struct skl_clk_data *dclk)
 {
-	u8 cnt = dclk->avail_clk_cnt;
-
-	while (cnt--)
-		clkdev_drop(dclk->clk[cnt]->lookup);
+	while (dclk->avail_clk_cnt--)
+		clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup);
 }
 
 static int skl_register_parent_clks(struct device *dev,
@@ -381,13 +379,13 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
 		if (clks[i].rate_cfg[0].rate == 0)
 			continue;
 
-		data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
-		if (IS_ERR(data->clk[i])) {
-			ret = PTR_ERR(data->clk[i]);
+		data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
+				&clks[i], clk_pdata, i);
+
+		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
+			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
 			goto err_unreg_skl_clk;
 		}
-
-		data->avail_clk_cnt++;
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.17.1
