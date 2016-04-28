From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: add link mangement
Date: Thu, 28 Apr 2016 19:30:59 +0530
Message-ID: <1461852059-20518-3-git-send-email-vinod.koul@intel.com>
References: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 69DDC266D5B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:55:14 +0200 (CEST)
In-Reply-To: <1461852059-20518-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Use shiny new link APIs to manage the links. Also remove old link
configuration logic from driver.

We need to keep link and cmd dma to off during active suspend
to allow system to enter low power state and turn it on if
the link and cmd dma was on before active suspend in active
resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c |  1 -
 sound/soc/intel/skylake/skl.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index c726937321ef..6e71bf34ea2b 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -533,7 +533,6 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	snd_hdac_ext_bus_link_power_up(link);
 	snd_hdac_ext_link_stream_reset(link_dev);
 
 	snd_hdac_ext_link_stream_setup(link_dev, format_val);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3982f5536f2d..71ca098561db 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -229,7 +229,12 @@ static int skl_suspend(struct device *dev)
 	 * running, we need to save the state for these and continue
 	 */
 	if (skl->supend_active) {
+		/* turn off the links and stop the CORB/RIRB DMA if it is On */
 		snd_hdac_ext_bus_link_power_down_all(ebus);
+
+		if (ebus->cmd_io)
+			snd_hdac_bus_stop_cmd_io(&ebus->bus);
+
 		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
 		pci_disable_device(pci);
@@ -255,6 +260,7 @@ static int skl_resume(struct device *dev)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
@@ -276,8 +282,29 @@ static int skl_resume(struct device *dev)
 		ret = pci_enable_device(pci);
 		snd_hdac_ext_bus_link_power_up_all(ebus);
 		disable_irq_wake(bus->irq);
+		/*
+		 * turn On the links which are On before active suspend
+		 * and start the CORB/RIRB DMA if On before
+		 * active suspend.
+		 */
+		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+			if (hlink->ref_count)
+				snd_hdac_ext_bus_link_power_up(hlink);
+		}
+
+		if (ebus->cmd_io)
+			snd_hdac_bus_init_cmd_io(&ebus->bus);
 	} else {
 		ret = _skl_resume(ebus);
+
+		/* turn off the links which are off before suspend */
+		list_for_each_entry(hlink, &ebus->hlink_list, list) {
+			if (!hlink->ref_count)
+				snd_hdac_ext_bus_link_power_down(hlink);
+		}
+
+		if (!ebus->cmd_io)
+			snd_hdac_bus_stop_cmd_io(&ebus->bus);
 	}
 
 	return ret;
@@ -613,6 +640,7 @@ static int skl_probe(struct pci_dev *pci,
 	struct skl *skl;
 	struct hdac_ext_bus *ebus = NULL;
 	struct hdac_bus *bus = NULL;
+	struct hdac_ext_link *hlink = NULL;
 	int err;
 
 	/* we use ext core ops, so provide NULL for ops here */
@@ -679,6 +707,12 @@ static int skl_probe(struct pci_dev *pci,
 		}
 	}
 
+	/*
+	 * we are done probling so decrement link counts
+	 */
+	list_for_each_entry(hlink, &ebus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(ebus, hlink);
+
 	/*configure PM */
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
-- 
1.9.1
