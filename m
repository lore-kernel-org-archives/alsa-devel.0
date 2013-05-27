From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/4] ALSA: hda - Move azx_first_init() into
	azx_probe_continue()
Date: Mon, 27 May 2013 17:15:14 +0800
Message-ID: <1369646116-11942-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

This is a preliminary work for the upcoming Haswell HDMI audio fixes.

azx_first_init() function can be safely called after the f/w loader,
since the f/w loader doesn't require the sound hardware initialization
beforehand.  Moving it into azx_probe_continue() cleans up the code
flow a bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cf3d36c..49cc942 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2977,7 +2977,6 @@ static void azx_notifier_unregister(struct azx *chip)
 		unregister_reboot_notifier(&chip->reboot_notifier);
 }
 
-static int azx_first_init(struct azx *chip);
 static int azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
@@ -3004,8 +3003,7 @@ static void azx_vs_set_state(struct pci_dev *pci,
 			snd_printk(KERN_INFO SFX
 				   "%s: Start delayed initialization\n",
 				   pci_name(chip->pci));
-			if (azx_first_init(chip) < 0 ||
-			    azx_probe_continue(chip) < 0) {
+			if (azx_probe_continue(chip) < 0) {
 				snd_printk(KERN_ERR SFX
 					   "%s: initialization error\n",
 					   pci_name(chip->pci));
@@ -3706,11 +3704,6 @@ static int azx_probe(struct pci_dev *pci,
 	}
 
 	probe_now = !chip->disabled;
-	if (probe_now) {
-		err = azx_first_init(chip);
-		if (err < 0)
-			goto out_free;
-	}
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	if (patch[dev] && *patch[dev]) {
@@ -3747,6 +3740,10 @@ static int azx_probe_continue(struct azx *chip)
 	int dev = chip->dev_index;
 	int err;
 
+	err = azx_first_init(chip);
+	if (err < 0)
+		goto out_free;
+
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 	chip->beep_mode = beep_mode[dev];
 #endif
-- 
1.7.9.5
