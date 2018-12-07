From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Skylake: add error logs on
	probe, remove dependency on NHLT
Date: Fri,  7 Dec 2018 17:50:07 -0600
Message-ID: <20181207235008.22988-6-pierre-louis.bossart@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E20E267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:07 +0100 (CET)
In-Reply-To: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Add error logs to make probe debug easier.

Also remove hard-coded dependency on NHLT. NHLT literally stands for
NonHdaudioLinkTable and is only required for SSP/DMIC interfaces.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
