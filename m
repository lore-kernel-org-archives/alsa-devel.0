From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Disable SRAM Retention
	before D3" to the asoc tree
Date: Tue, 07 Jun 2016 14:27:48 +0100
Message-ID: <E1bAH2q-0001id-Ac@debutante>
References: <1464958783-19344-5-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E18792665D1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:27:52 +0200 (CEST)
In-Reply-To: <1464958783-19344-5-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Disable SRAM Retention before D3

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

>From 51a01b8c2ea632ed9a57f98c234a0cd9dafe181a Mon Sep 17 00:00:00 2001
From: Dharageswari R <dharageswari.r@intel.com>
Date: Fri, 3 Jun 2016 18:29:37 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Disable SRAM Retention before D3

SW needs to set the PGCTL.LSRMD = 1 to disable LPSRAM retention
feature,otherwise it may lead to SRAM ECC Errors.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 3 +++
 sound/soc/intel/skylake/skl.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 55c301bf786b..cb3eb41524ec 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -186,6 +186,7 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 {
 	struct skl *skl = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct pci_dev *pci = to_pci_dev(bus->dev);
 	int ret;
 
 	snd_hdac_ext_bus_link_power_down_all(ebus);
@@ -195,6 +196,8 @@ static int _skl_suspend(struct hdac_ext_bus *ebus)
 		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
+	update_pci_dword(pci, AZX_PCIREG_PGCTL,
+		AZX_PGCTL_LSRMD_MASK, AZX_PGCTL_LSRMD_MASK);
 	skl_enable_miscbdcge(bus->dev, false);
 	snd_hdac_bus_enter_link_reset(bus);
 	skl_enable_miscbdcge(bus->dev, true);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f66be173f86b..25b8d4897ff5 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -48,6 +48,8 @@
 #define AZX_REG_VS_SDXEFIFOS_XBASE	0x1094
 #define AZX_REG_VS_SDXEFIFOS_XINTERVAL	0x20
 
+#define AZX_PCIREG_PGCTL		0x44
+#define AZX_PGCTL_LSRMD_MASK		(1 << 4)
 #define AZX_PCIREG_CGCTL		0x48
 #define AZX_CGCTL_MISCBDCGE_MASK	(1 << 6)
 
-- 
2.8.1
