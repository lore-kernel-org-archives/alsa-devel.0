From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to turn OFF codec
	power when entering S3" to the asoc tree
Date: Sat, 02 Apr 2016 09:39:19 -0700
Message-ID: <E1amOZz-0002BV-K9@finisterre>
References: <1459497987-28979-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B73EF2612AF
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 18:39:26 +0200 (CEST)
In-Reply-To: <1459497987-28979-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to turn OFF codec power when entering S3

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

>From af037412629d8549e04039a57cf99a59b6e7a01b Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 1 Apr 2016 13:36:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to turn OFF codec power when
 entering S3

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 07d9bc1cf3cb..3982f5536f2d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -222,6 +222,7 @@ static int skl_suspend(struct device *dev)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	int ret = 0;
 
 	/*
 	 * Do not suspend if streams which are marked ignore suspend are
@@ -232,10 +233,20 @@ static int skl_suspend(struct device *dev)
 		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
 		pci_disable_device(pci);
-		return 0;
 	} else {
-		return _skl_suspend(ebus);
+		ret = _skl_suspend(ebus);
+		if (ret < 0)
+			return ret;
 	}
+
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		ret = snd_hdac_display_power(bus, false);
+		if (ret < 0)
+			dev_err(bus->dev,
+				"Cannot turn OFF display power on i915\n");
+	}
+
+	return ret;
 }
 
 static int skl_resume(struct device *dev)
-- 
2.8.0.rc3
