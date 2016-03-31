From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: hda - Bind with i915 only when Intel
	graphics is present
Date: Thu, 31 Mar 2016 16:31:33 +0200
Message-ID: <1459434693-1633-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E03E266895
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 16:31:36 +0200 (CEST)
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Skylake and onwards, the HD-audio controller driver needs to bind
with i915 for having the control of power well audio domain before
actually probing the codec.  This leads to the load of i915 driver
from the audio driver side.  But, there are systems that have no Intel
graphics but Nvidia or AMD GPU, although they still use HD-audio bus
for the onboard audio codecs.  On these, loading the i915 driver is
nothing but a useless memory and CPU consumption.

A simple way to avoid it is just to look for the Intel graphics PCI
entry beforehand, and try to bind with i915 only when such an entry is
found.  Currently, it assumes the PCI display class.  If another class
appears, this needs to be extended (although it's very unlikely).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Check also PCI vendor id to match only with Intel
Now get out of a series, as this should be applied to 4.6, too.

 sound/hda/hdac_i915.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index d0da2508823e..6800e0c5a38f 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -287,6 +287,18 @@ int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_register_notifier);
 
+/* check whether intel graphics is present */
+static bool i915_gfx_present(void)
+{
+	static struct pci_device_id ids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
+		  .class = PCI_BASE_CLASS_DISPLAY << 16,
+		  .class_mask = 0xff << 16 },
+		{}
+	};
+	return pci_dev_present(ids);
+}
+
 /**
  * snd_hdac_i915_init - Initialize i915 audio component
  * @bus: HDA core bus
@@ -309,6 +321,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
 	if (WARN_ON(hdac_acomp))
 		return -EBUSY;
 
+	if (!i915_gfx_present())
+		return -ENODEV;
+
 	acomp = kzalloc(sizeof(*acomp), GFP_KERNEL);
 	if (!acomp)
 		return -ENOMEM;
-- 
2.7.4
