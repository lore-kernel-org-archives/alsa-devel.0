From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA: hda: constify pci_device_id.
Date: Tue, 18 Jul 2017 22:35:06 +0530
Message-ID: <aaef07f5b0d970c82721e2392275a6c2b5c59145.1500397387.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   2610	    304	      8	   2922	    b6a	sound/hda/hdac_i915.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2674	    240	      8	   2922	    b6a	sound/hda/hdac_i915.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/hda/hdac_i915.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 0659bf3..038a180 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -336,7 +336,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_i915_register_notifier);
 /* check whether intel graphics is present */
 static bool i915_gfx_present(void)
 {
-	static struct pci_device_id ids[] = {
+	static const struct pci_device_id ids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
 		  .class = PCI_BASE_CLASS_DISPLAY << 16,
 		  .class_mask = 0xff << 16 },
-- 
2.7.4
