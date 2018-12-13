From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove useless tests on
	HDaudio capabilities" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:04 +0000 (GMT)
Message-ID: <20181213181104.CF66411254D1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A05B4267C94
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:11:05 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: remove useless tests on HDaudio capabilities

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

>From 7f981bdcf55fda28a9a70c9e8151dd200771a0a8 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 7 Dec 2018 17:50:06 -0600
Subject: [PATCH] ASoC: Intel: Skylake: remove useless tests on HDaudio
 capabilities

bus->ppcap is now tested upfront, there is no need to re-check if the
hardware is exposed as needed. Remove tests and remove indentation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
