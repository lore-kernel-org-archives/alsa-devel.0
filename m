From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/6] ASoC: Intel: Skylake: remove useless tests
	on HDaudio capabilities
Date: Fri,  7 Dec 2018 17:50:06 -0600
Message-ID: <20181207235008.22988-5-pierre-louis.bossart@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 9184B267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:05 +0100 (CET)
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

bus->ppcap is now tested upfront, there is no need to re-check if the
hardware is exposed as needed. Remove tests and remove indentation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 40 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 72e366bbba33..f04e9ec4432b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -826,12 +826,10 @@ static void skl_probe_work(struct work_struct *work)
 		return;
 	}
 
-	if (bus->ppcap) {
-		err = skl_machine_device_register(skl);
-		if (err < 0) {
-			dev_err(bus->dev, "machine register failed: %d\n", err);
-			goto out_err;
-		}
+	err = skl_machine_device_register(skl);
+	if (err < 0) {
+		dev_err(bus->dev, "machine register failed: %d\n", err);
+		goto out_err;
 	}
 
 	/*
@@ -1034,25 +1032,23 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, bus);
 
-	/* check if dsp is there */
-	if (bus->ppcap) {
-		/* create device for dsp clk */
-		err = skl_clock_device_register(skl);
-		if (err < 0)
-			goto out_clk_free;
+	/* create device for dsp clk */
+	err = skl_clock_device_register(skl);
+	if (err < 0)
+		goto out_clk_free;
 
-		err = skl_find_machine(skl, (void *)pci_id->driver_data);
-		if (err < 0)
-			goto out_nhlt_free;
+	err = skl_find_machine(skl, (void *)pci_id->driver_data);
+	if (err < 0)
+		goto out_nhlt_free;
 
-		err = skl_init_dsp(skl);
-		if (err < 0) {
-			dev_dbg(bus->dev, "error failed to register dsp\n");
-			goto out_nhlt_free;
-		}
-		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
-		skl->skl_sst->clock_power_gating = skl_clock_power_gating;
+	err = skl_init_dsp(skl);
+	if (err < 0) {
+		dev_dbg(bus->dev, "error failed to register dsp\n");
+		goto out_nhlt_free;
 	}
+	skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
+	skl->skl_sst->clock_power_gating = skl_clock_power_gating;
+
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
-- 
2.17.1
