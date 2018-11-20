From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 3/6] ASoC: Intel: Skylake: remove useless
	tests on DSP presence
Date: Tue, 20 Nov 2018 15:36:41 -0600
Message-ID: <20181120213644.19103-4-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 257CB2678E4
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 22:37:00 +0100 (CET)
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

bus->ppcap is now tested upfront, there is no need to re-check if the
DSP is present. Remove tests and remove indentation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 40 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1d7146773d19..0bdb1f7fdd4a 100644
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
@@ -1019,25 +1017,23 @@ static int skl_probe(struct pci_dev *pci,
 
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
