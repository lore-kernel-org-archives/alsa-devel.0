From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH] ASoC: rt5682: add default pdata for i2s mode
Date: Thu, 17 Jan 2019 06:08:53 +0800
Message-ID: <20190116220853.20009-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 38228266B69
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 11:08:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, shumingf@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

Add a default pdata which can fit most HW design. So we don't need to
add a lot of DMI checking in this driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/rt5682.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 89c43b26c379..bd45d0343913 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -43,6 +43,12 @@ static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
 	"VBAT",
 };
 
+static const struct rt5682_platform_data i2s_default_platform_data = {
+	.dmic1_data_pin = RT5682_DMIC1_DATA_GPIO2,
+	.dmic1_clk_pin = RT5682_DMIC1_CLK_GPIO3,
+	.jd_src = RT5682_JD1,
+};
+
 struct rt5682_priv {
 	struct snd_soc_component *component;
 	struct rt5682_platform_data pdata;
@@ -2534,6 +2540,8 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5682);
 
+	rt5682->pdata = i2s_default_platform_data;
+
 	if (pdata)
 		rt5682->pdata = *pdata;
 	else
-- 
2.17.1
