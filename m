From: mengdong.lin@intel.com
Subject: [PATCH v3 3/5] ALSA: hda - implement link_power ops
	for i915 display power control
Date: Wed, 29 Apr 2015 17:43:29 +0800
Message-ID: <2a4a27d7d3eb030fe4b37a2598f9383e87cb81c5.1430300071.git.mengdong.lin@intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C9CA92604C5
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:52 +0200 (CEST)
In-Reply-To: <cover.1430300071.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch implements the bus link_power ops to request/release i915 display
power well. It can be used by the display codec which shares this power well
with GPU on Intel platforms.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index e0bb623..120854e 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -775,9 +775,20 @@ static int azx_get_response(struct hdac_bus *bus, unsigned int addr,
 		return azx_rirb_get_response(bus, addr, res);
 }
 
+static int azx_link_power(struct hdac_bus *bus, bool enable)
+{
+	struct azx *chip = bus_to_azx(bus);
+
+	if (chip->ops->link_power)
+		return chip->ops->link_power(chip, enable);
+	else
+		return -EINVAL;
+}
+
 static const struct hdac_bus_ops bus_core_ops = {
 	.command = azx_send_cmd,
 	.get_response = azx_get_response,
+	.link_power = azx_link_power,
 };
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 173bf7c..3d26e61 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -89,6 +89,8 @@ struct hda_controller_ops {
 				 struct vm_area_struct *area);
 	/* Check if current position is acceptable */
 	int (*position_check)(struct azx *chip, struct azx_dev *azx_dev);
+	/* enable/disable the link power */
+	int (*link_power)(struct azx *chip, bool enable);
 };
 
 struct azx_pcm {
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e615556..d70b405 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -543,6 +543,14 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 	return 0;
 }
 
+/* Enable/disable i915 display power for the link */
+static int azx_intel_link_power(struct azx *chip, bool enable)
+{
+	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+
+	return hda_display_power(hda, enable);
+}
+
 /*
  * Check whether the current DMA position is acceptable for updating
  * periods.  Returns non-zero if it's OK.
@@ -1789,6 +1797,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.substream_free_pages = substream_free_pages,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
 	.position_check = azx_position_check,
+	.link_power = azx_intel_link_power,
 };
 
 static int azx_probe(struct pci_dev *pci,
-- 
1.9.1
