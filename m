From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 7/8] ASoC: Intel: Skylake: Add DSP support
	and enable it
Date: Wed, 23 Sep 2015 20:33:23 +0530
Message-ID: <1443020604-22282-8-git-send-email-vinod.koul@intel.com>
References: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 06315264FF9
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 17:01:39 +0200 (CEST)
In-Reply-To: <1443020604-22282-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If processing pipe capability is supported, add DSP support.
Adds initialization/free/suspend/resume DSP functionality.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 348d094e81d6..2f1890e703c6 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -166,11 +166,16 @@ static int skl_runtime_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct skl *skl = ebus_to_skl(ebus);
+	int ret;
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
 	/* enable controller wake up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
+	ret = skl_suspend_dsp(skl);
+	if (ret < 0)
+		return ret;
 
 	snd_hdac_bus_stop_chip(bus);
 	snd_hdac_bus_enter_link_reset(bus);
@@ -183,7 +188,7 @@ static int skl_runtime_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *hda = ebus_to_skl(ebus);
+	struct skl *skl = ebus_to_skl(ebus);
 	int status;
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
@@ -191,12 +196,12 @@ static int skl_runtime_resume(struct device *dev)
 	/* Read STATESTS before controller reset */
 	status = snd_hdac_chip_readw(bus, STATESTS);
 
-	skl_init_pci(hda);
+	skl_init_pci(skl);
 	snd_hdac_bus_init_chip(bus, true);
 	/* disable controller Wake Up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
 
-	return 0;
+	return skl_resume_dsp(skl);
 }
 #endif /* CONFIG_PM */
 
@@ -457,17 +462,19 @@ static int skl_probe(struct pci_dev *pci,
 
 	/* check if dsp is there */
 	if (ebus->ppcap) {
-		/* TODO register with dsp IPC */
-		dev_dbg(bus->dev, "Register dsp\n");
+		err = skl_init_dsp(skl);
+		if (err < 0) {
+			dev_dbg(bus->dev, "error failed to register dsp\n");
+			goto out_free;
+		}
 	}
-
 	if (ebus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(ebus);
 
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
 	if (err < 0)
-		goto out_free;
+		goto out_dsp_free;
 
 	/* register platform dai and controls */
 	err = skl_platform_register(bus->dev);
@@ -491,6 +498,8 @@ out_unregister:
 	skl_platform_unregister(bus->dev);
 out_dmic_free:
 	skl_dmic_device_unregister(skl);
+out_dsp_free:
+	skl_free_dsp(skl);
 out_free:
 	skl->init_failed = 1;
 	skl_free(ebus);
@@ -507,6 +516,7 @@ static void skl_remove(struct pci_dev *pci)
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
 	skl_platform_unregister(&pci->dev);
+	skl_free_dsp(skl);
 	skl_dmic_device_unregister(skl);
 	skl_free(ebus);
 	dev_set_drvdata(&pci->dev, NULL);
-- 
1.9.1
