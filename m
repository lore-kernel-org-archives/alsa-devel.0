From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 3/5] ALSA: hda - Power well request/release for
	hda controller
Date: Mon, 13 May 2013 15:37:26 +0800
Message-ID: <1368430648-2353-4-git-send-email-xingchao.wang@linux.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Display HDA need reqeust power well in case it's shut down by gfx.
Currently "hda" is the only user in audio side, even though the codecs
depends on same power well too, it's safe to share the same power well
with hda controller. If gfx power well could shut down only for codecs,
it can be added as another new user "hdmi-codec".

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_i915.c  |    2 +-
 sound/pci/hda/hda_intel.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 7e8ddaa..00def82 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -25,7 +25,7 @@
 /* Power well has impact on Haswell controller and codecs */
 void hda_display_power(bool enable)
 {
-	snd_printk(KERN_INFO "HDA display power %d \n", enable);
+	snd_printk(KERN_INFO "HDA display power %s \n", enable ? "Enable" : "Disable");
 	if (enable)
 		i915_request_power_well("hda");
 	else
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 418bfc0..8bb6075 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -62,6 +62,7 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
 #include "hda_codec.h"
+#include "hda_i915.h"
 
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
@@ -675,6 +676,10 @@ static char *driver_short_names[] = {
 #define azx_sd_readb(dev,reg) \
 	readb((dev)->sd_addr + ICH6_REG_##reg)
 
+#define IS_HSW(pci)		((pci)->device == 0x0a0c || \
+				 (pci)->device == 0x0c0c || \
+				 (pci)->device == 0x0d0c)
+
 /* for pcm support */
 #define get_azx_dev(substream) (substream->runtime->private_data)
 
@@ -2869,6 +2874,8 @@ static int azx_suspend(struct device *dev)
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	pci_set_power_state(pci, PCI_D3hot);
+	if (IS_HSW(pci))
+		hda_display_power(false);
 	return 0;
 }
 
@@ -2881,6 +2888,8 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled)
 		return 0;
 
+	if (IS_HSW(pci))
+		hda_display_power(true);
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
@@ -2913,6 +2922,8 @@ static int azx_runtime_suspend(struct device *dev)
 
 	azx_stop_chip(chip);
 	azx_clear_irq_pending(chip);
+	if (IS_HSW(to_pci_dev(dev)))
+		hda_display_power(false);
 	return 0;
 }
 
@@ -2921,6 +2932,8 @@ static int azx_runtime_resume(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
+	if (IS_HSW(to_pci_dev(dev)))
+		hda_display_power(true);
 	azx_init_pci(chip);
 	azx_init_chip(chip, 1);
 	return 0;
@@ -3671,6 +3684,9 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
+	if (IS_HSW(pci))
+		hda_display_power(true);
+
 	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "hda-intel: Error creating card!\n");
@@ -3806,6 +3822,8 @@ static void azx_remove(struct pci_dev *pci)
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
+	if (IS_HSW(pci))
+		hda_display_power(false);
 }
 
 /* PCI IDs */
-- 
1.7.9.5
