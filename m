From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add error logs on probe,
	remove dependency on NHLT" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:03 +0000 (GMT)
Message-ID: <20181213181103.0A31711254D1@debutante.sirena.org.uk>
References: <20181207235008.22988-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 773AE267CA7
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:11:08 +0100 (CET)
In-Reply-To: <20181207235008.22988-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add error logs on probe, remove dependency on NHLT

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

>From f231c34ca9772f0b0e2d1b781e9c415847aff522 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 7 Dec 2018 17:50:07 -0600
Subject: [PATCH] ASoC: Intel: Skylake: add error logs on probe, remove
 dependency on NHLT

Add error logs to make probe debug easier.

Also remove hard-coded dependency on NHLT. NHLT literally stands for
NonHdaudioLinkTable and is only required for SSP/DMIC interfaces.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-nhlt.c |  3 +++
 sound/soc/intel/skylake/skl.c      | 41 +++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 01a050cf8775..5d125a3df527 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -180,6 +180,9 @@ int skl_get_dmic_geo(struct skl *skl)
 	unsigned int dmic_geo = 0;
 	u8 j;
 
+	if (!nhlt)
+		return 0;
+
 	epnt = (struct nhlt_endpoint *)nhlt->desc;
 
 	for (j = 0; j < nhlt->endpoint_count; j++) {
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f04e9ec4432b..f9888b1d5521 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1010,8 +1010,10 @@ static int skl_probe(struct pci_dev *pci,
 	bus = skl_to_bus(skl);
 
 	err = skl_first_init(bus);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(bus->dev, "skl_first_init failed with err: %d\n", err);
 		goto out_free;
+	}
 
 	skl->pci_id = pci->device;
 
@@ -1020,26 +1022,39 @@ static int skl_probe(struct pci_dev *pci,
 	skl->nhlt = skl_nhlt_init(bus->dev);
 
 	if (skl->nhlt == NULL) {
+#if !IS_ENABLED(CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC)
+		dev_err(bus->dev, "no nhlt info found\n");
 		err = -ENODEV;
 		goto out_free;
-	}
+#else
+		dev_warn(bus->dev, "no nhlt info found, continuing to try to enable HDaudio codec\n");
+#endif
+	} else {
 
-	err = skl_nhlt_create_sysfs(skl);
-	if (err < 0)
-		goto out_nhlt_free;
+		err = skl_nhlt_create_sysfs(skl);
+		if (err < 0) {
+			dev_err(bus->dev, "skl_nhlt_create_sysfs failed with err: %d\n", err);
+			goto out_nhlt_free;
+		}
 
-	skl_nhlt_update_topology_bin(skl);
+		skl_nhlt_update_topology_bin(skl);
+
+		/* create device for dsp clk */
+		err = skl_clock_device_register(skl);
+		if (err < 0) {
+			dev_err(bus->dev, "skl_clock_device_register failed with err: %d\n", err);
+			goto out_clk_free;
+		}
+	}
 
 	pci_set_drvdata(skl->pci, bus);
 
-	/* create device for dsp clk */
-	err = skl_clock_device_register(skl);
-	if (err < 0)
-		goto out_clk_free;
 
 	err = skl_find_machine(skl, (void *)pci_id->driver_data);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(bus->dev, "skl_find_machine failed with err: %d\n", err);
 		goto out_nhlt_free;
+	}
 
 	err = skl_init_dsp(skl);
 	if (err < 0) {
@@ -1056,8 +1071,10 @@ static int skl_probe(struct pci_dev *pci,
 
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(bus->dev, "skl_dmic_device_register failed with err: %d\n", err);
 		goto out_dsp_free;
+	}
 
 	schedule_work(&skl->probe_work);
 
-- 
2.19.0.rc2
