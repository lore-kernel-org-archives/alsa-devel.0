From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: add default pdata for i2s mode"
	to the asoc tree
Date: Thu, 17 Jan 2019 12:40:06 +0000 (GMT)
Message-ID: <20190117124006.899D71126FE2@debutante.sirena.org.uk>
References: <20190116220853.20009-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C87C426680F
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 13:40:14 +0100 (CET)
In-Reply-To: <20190116220853.20009-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, shumingf@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: add default pdata for i2s mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3ac1b2e4158c73175278a27c5551fa331c260b48 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Thu, 17 Jan 2019 06:08:53 +0800
Subject: [PATCH] ASoC: rt5682: add default pdata for i2s mode

Add a default pdata which can fit most HW design. So we don't need to
add a lot of DMI checking in this driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
