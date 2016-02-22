From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply clock gate workaround to
	Skylake, too
Date: Mon, 22 Feb 2016 17:15:43 +0100
Message-ID: <1456157743-21247-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C32C4260673
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 17:15:45 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2522CAB9B
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 16:15:45 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Some Skylake machines show the codec probe errors in certain
situations, e.g. HP Z240 desktop fails to probe the onboard Realtek
codec at reloading the snd-hda-intel module like:
  snd_hda_intel 0000:00:1f.3: spurious response 0x200:0x2, last cmd=0x000000
  snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to polling mode: lastcmd=0x000f0000
  snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x000f0000
  snd_hda_intel 0000:00:1f.3: Codec #0 probe error; disabling it...
  hdaudio hdaudioC0D2: no AFG or MFG node found
  snd_hda_intel 0000:00:1f.3: no codecs initialized

Also, HP G470 G3 suffers from the similar problem, as reported in
bugzilla below.  On this machine, the codec probe error appears even
at a fresh boot.

As Libin suggested, the same workaround used for Broxton in the commit
[6639484ddaf6: ALSA: hda - disable dynamic clock gating on Broxton
 before reset] can be applied for Skylake in order to fix this problem.
The Intel HW team also confirmed that this is needed for SKL.

This patch makes the workaround applied to both SKL and BXT
platforms.  The referred macros are moved and one superfluous macro
(IS_BROXTON()) is another one (IS_BXT()) as well.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=112731
Suggested-by: Libin Yang <libin.yang@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ce6b97f31390..e5240cb3749f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -363,7 +363,10 @@ enum {
 					((pci)->device == 0x0d0c) || \
 					((pci)->device == 0x160c))
 
-#define IS_BROXTON(pci)	((pci)->device == 0x5a98)
+#define IS_SKL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa170)
+#define IS_SKL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d70)
+#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci))
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -540,13 +543,13 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		snd_hdac_set_codec_wakeup(bus, true);
-	if (IS_BROXTON(pci)) {
+	if (IS_SKL_PLUS(pci)) {
 		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
 		val = val & ~INTEL_HDA_CGCTL_MISCBDCGE;
 		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
 	}
 	azx_init_chip(chip, full_reset);
-	if (IS_BROXTON(pci)) {
+	if (IS_SKL_PLUS(pci)) {
 		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
 		val = val | INTEL_HDA_CGCTL_MISCBDCGE;
 		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
@@ -555,7 +558,7 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 		snd_hdac_set_codec_wakeup(bus, false);
 
 	/* reduce dma latency to avoid noise */
-	if (IS_BROXTON(pci))
+	if (IS_BXT(pci))
 		bxt_reduce_dma_latency(chip);
 }
 
@@ -977,11 +980,6 @@ static int azx_resume(struct device *dev)
 /* put codec down to D3 at hibernation for Intel SKL+;
  * otherwise BIOS may still access the codec and screw up the driver
  */
-#define IS_SKL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa170)
-#define IS_SKL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d70)
-#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
-#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci))
-
 static int azx_freeze_noirq(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
-- 
2.7.1
