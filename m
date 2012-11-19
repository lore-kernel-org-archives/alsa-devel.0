From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 348/493] ALSA: hda: remove DELAYED_INIT_MARK
	and DELAYED_INITDATA_MARK macros
Date: Mon, 19 Nov 2012 13:24:57 -0500
Message-ID: <1353349642-3677-348-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.virginia.edu
 [128.143.12.139])
 by alsa0.perex.cz (Postfix) with ESMTP id D92E92625D3
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:28:19 +0100 (CET)
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The DELAYED_INIT_MARK and DELAYED_INITDATA_MARK macros became empty
when __devinit and __devinitdata were removed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: alsa-devel@alsa-project.org 
---
 sound/pci/hda/hda_intel.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2a3b9e4..0aedbe1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -595,15 +595,7 @@ enum {
 #define use_vga_switcheroo(chip)	0
 #endif
 
-#if defined(SUPPORT_VGA_SWITCHEROO) || defined(CONFIG_SND_HDA_PATCH_LOADER)
-#define DELAYED_INIT_MARK
-#define DELAYED_INITDATA_MARK
-#else
-#define DELAYED_INIT_MARK
-#define DELAYED_INITDATA_MARK
-#endif
-
-static char *driver_short_names[] DELAYED_INITDATA_MARK = {
+static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
 	[AZX_DRIVER_PCH] = "HDA Intel PCH",
 	[AZX_DRIVER_SCH] = "HDA Intel MID",
@@ -1616,12 +1608,12 @@ static int get_jackpoll_interval(struct azx *chip)
  */
 
 /* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
-static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] DELAYED_INITDATA_MARK = {
+static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
 	[AZX_DRIVER_NVIDIA] = 8,
 	[AZX_DRIVER_TERA] = 1,
 };
 
-static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *model)
+static int azx_codec_create(struct azx *chip, const char *model)
 {
 	struct hda_bus_template bus_temp;
 	int c, codecs, err;
@@ -2722,8 +2714,8 @@ static void azx_notifier_unregister(struct azx *chip)
 		unregister_reboot_notifier(&chip->reboot_notifier);
 }
 
-static int DELAYED_INIT_MARK azx_first_init(struct azx *chip);
-static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip);
+static int azx_first_init(struct azx *chip);
+static int azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
 static struct pci_dev *get_bound_vga(struct pci_dev *pci);
@@ -3204,7 +3196,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	return 0;
 }
 
-static int DELAYED_INIT_MARK azx_first_init(struct azx *chip)
+static int azx_first_init(struct azx *chip)
 {
 	int dev = chip->dev_index;
 	struct pci_dev *pci = chip->pci;
@@ -3478,7 +3470,7 @@ out_free:
 	return err;
 }
 
-static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
+static int azx_probe_continue(struct azx *chip)
 {
 	int dev = chip->dev_index;
 	int err;
-- 
1.8.0
