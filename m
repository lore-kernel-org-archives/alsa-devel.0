From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Fix to turn OFF
	codec power when entering S3
Date: Fri,  1 Apr 2016 13:36:27 +0530
Message-ID: <1459497987-28979-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D6A3D2651C9
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 10:07:08 +0200 (CEST)
In-Reply-To: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 07d9bc1..3982f55 100644
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
1.9.1
