From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add flag to check to
	register FE dais from topology" to the asoc tree
Date: Fri, 13 Oct 2017 20:25:52 +0100
Message-ID: <E1e35ai-0006PI-2q@debutante>
References: <20171009055032.12158-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C64B267703
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 21:25:59 +0200 (CEST)
In-Reply-To: <20171009055032.12158-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add flag to check to register FE dais from topology

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c3ae22e39db79bee1909d398c0debe2f7cb87d3a Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Mon, 9 Oct 2017 11:20:30 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add flag to check to register FE dais
 from topology

Since FE dais can come from topology, split the FE dais from existing
dai array so that FE dais need not be registered if they come from
topology. Add use_tplg_pcm flag to check whether FE dais will be
registered from topology during dai driver component registration.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 38 ++++++++++++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl.c     |  9 ++++++++-
 sound/soc/intel/skylake/skl.h     |  4 +++-
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2b1e513b1680..9ca69b1fc128 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -652,7 +652,7 @@ static const struct snd_soc_dai_ops skl_link_dai_ops = {
 	.trigger = skl_link_pcm_trigger,
 };
 
-static struct snd_soc_dai_driver skl_platform_dai[] = {
+static struct snd_soc_dai_driver skl_fe_dai[] = {
 {
 	.name = "System Pin",
 	.ops = &skl_pcm_dai_ops,
@@ -796,8 +796,10 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.sig_bits = 32,
 	},
 },
+};
 
 /* BE CPU  Dais */
+static struct snd_soc_dai_driver skl_platform_dai[] = {
 {
 	.name = "SSP0 Pin",
 	.ops = &skl_be_ssp_dai_ops,
@@ -1362,6 +1364,8 @@ int skl_platform_register(struct device *dev)
 	int ret;
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dev);
 	struct skl *skl = ebus_to_skl(ebus);
+	struct snd_soc_dai_driver *dais;
+	int num_dais = ARRAY_SIZE(skl_platform_dai);
 
 	INIT_LIST_HEAD(&skl->ppl_list);
 	INIT_LIST_HEAD(&skl->bind_list);
@@ -1371,14 +1375,38 @@ int skl_platform_register(struct device *dev)
 		dev_err(dev, "soc platform registration failed %d\n", ret);
 		return ret;
 	}
+
+	skl->dais = kmemdup(skl_platform_dai, sizeof(skl_platform_dai),
+			    GFP_KERNEL);
+	if (!skl->dais) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if (!skl->use_tplg_pcm) {
+		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
+				sizeof(skl_platform_dai), GFP_KERNEL);
+		if (!dais) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		skl->dais = dais;
+		memcpy(&skl->dais[ARRAY_SIZE(skl_platform_dai)], skl_fe_dai,
+		       sizeof(skl_fe_dai));
+		num_dais += ARRAY_SIZE(skl_fe_dai);
+	}
+
 	ret = snd_soc_register_component(dev, &skl_component,
-				skl_platform_dai,
-				ARRAY_SIZE(skl_platform_dai));
+					 skl->dais, num_dais);
 	if (ret) {
 		dev_err(dev, "soc component registration failed %d\n", ret);
-		snd_soc_unregister_platform(dev);
+		goto err;
 	}
 
+	return 0;
+err:
+	snd_soc_unregister_platform(dev);
 	return ret;
 
 }
@@ -1398,5 +1426,7 @@ int skl_platform_unregister(struct device *dev)
 
 	snd_soc_unregister_component(dev);
 	snd_soc_unregister_platform(dev);
+	kfree(skl->dais);
+
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f94b484abb99..143ade31562f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -462,8 +462,11 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
 		return -EIO;
 	}
 
-	if (mach->pdata)
+	if (mach->pdata) {
+		skl->use_tplg_pcm =
+			((struct skl_machine_pdata *)mach->pdata)->use_tplg_pcm;
 		dev_set_drvdata(&pdev->dev, mach->pdata);
+	}
 
 	skl->i2s_dev = pdev;
 
@@ -900,6 +903,9 @@ static struct sst_codecs kbl_5663_5514_codecs = {
 	.codecs = {"10EC5663", "10EC5514"}
 };
 
+static struct skl_machine_pdata cnl_pdata = {
+	.use_tplg_pcm = true,
+};
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{
@@ -1003,6 +1009,7 @@ static const struct sst_acpi_mach sst_cnl_devdata[] = {
 		.id = "INT34C2",
 		.drv_name = "cnl_rt274",
 		.fw_filename = "intel/dsp_fw_cnl.bin",
+		.pdata = &cnl_pdata,
 	},
 };
 
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 8d9d6899f761..e00cde8200dd 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -53,6 +53,7 @@ struct skl {
 	struct platform_device *dmic_dev;
 	struct platform_device *i2s_dev;
 	struct snd_soc_platform *platform;
+	struct snd_soc_dai_driver *dais;
 
 	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
@@ -73,6 +74,7 @@ struct skl {
 	struct skl_debug *debugfs;
 	u8 nr_modules;
 	struct skl_module **modules;
+	bool use_tplg_pcm;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
@@ -85,9 +87,9 @@ struct skl_dma_params {
 	u8 stream_tag;
 };
 
-/* to pass dmic data */
 struct skl_machine_pdata {
 	u32 dmic_num;
+	bool use_tplg_pcm; /* use dais and dai links from topology */
 };
 
 struct skl_dsp_ops {
-- 
2.14.1
