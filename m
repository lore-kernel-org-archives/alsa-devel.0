From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Acquire irq after RIRB
	allocation" to the asoc tree
Date: Tue, 14 Aug 2018 16:21:29 +0100 (BST)
Message-ID: <20180814152129.D83071124449@debutante.sirena.org.uk>
References: <1534202114-29164-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA5522677A8
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 17:21:33 +0200 (CEST)
In-Reply-To: <1534202114-29164-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: wenkai.du@intel.com, alsa-devel@alsa-project.org, harshapriya.n@intel.com, yang.jie@linux.intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, michal.wasko@intel.com, naveen.m@intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Acquire irq after RIRB allocation

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

>From 12eeeb4f4733bbc4481d01df35933fc15beb8b19 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Mon, 13 Aug 2018 18:15:14 -0500
Subject: [PATCH] ASoC: Intel: Skylake: Acquire irq after RIRB allocation

Cold reboot stress test found that the hda irq could access rirb ring
buffer before its memory gets allocated which resulting in null
pointer dereference inside snd_hdac_bus_update_rirb().

Fix it by moving the skl_acquire_irq after ring buffer allocation.
While here, also change err return from -EBUSY to actual error code.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dce649485649..cf09721ca13e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -838,11 +838,7 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-	if (skl_acquire_irq(bus, 0) < 0)
-		return -EBUSY;
-
 	pci_set_master(pci);
-	synchronize_irq(bus->irq);
 
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
@@ -875,6 +871,12 @@ static int skl_first_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
+	err = skl_acquire_irq(bus, 0);
+	if (err < 0)
+		return err;
+
+	synchronize_irq(bus->irq);
+
 	/* initialize chip */
 	skl_init_pci(skl);
 
-- 
2.18.0
