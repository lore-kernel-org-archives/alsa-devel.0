From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ALSA: hda - Make full_reset boolean
Date: Wed,  9 Apr 2014 12:30:57 +0200
Message-ID: <1397039457-9461-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 35702261693
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 12:31:51 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id na10so2182644bkb.4
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 03:31:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Thierry Reding <treding@nvidia.com>

The full_reset argument to azx_init_chip() carries boolean rather than
numerical information, so update the type to reflect that.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- update prototype in hda_controller.h

 sound/pci/hda/hda_controller.c | 8 ++++----
 sound/pci/hda/hda_controller.h | 2 +-
 sound/pci/hda/hda_intel.c      | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 97993e17f46a..98d31d153703 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1604,7 +1604,7 @@ static void azx_exit_link_reset(struct azx *chip)
 }
 
 /* reset codec link */
-static int azx_reset(struct azx *chip, int full_reset)
+static int azx_reset(struct azx *chip, bool full_reset)
 {
 	if (!full_reset)
 		goto __skip;
@@ -1701,7 +1701,7 @@ static void azx_int_clear(struct azx *chip)
 /*
  * reset and start the controller registers
  */
-void azx_init_chip(struct azx *chip, int full_reset)
+void azx_init_chip(struct azx *chip, bool full_reset)
 {
 	if (chip->initialized)
 		return;
@@ -1841,7 +1841,7 @@ static void azx_bus_reset(struct hda_bus *bus)
 
 	bus->in_reset = 1;
 	azx_stop_chip(chip);
-	azx_init_chip(chip, 1);
+	azx_init_chip(chip, true);
 #ifdef CONFIG_PM
 	if (chip->initialized) {
 		struct azx_pcm *p;
@@ -1948,7 +1948,7 @@ int azx_codec_create(struct azx *chip, const char *model,
 				 * get back to the sanity state.
 				 */
 				azx_stop_chip(chip);
-				azx_init_chip(chip, 1);
+				azx_init_chip(chip, true);
 			}
 		}
 	}
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 1d2e3be2bae6..baf0e77330af 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -37,7 +37,7 @@ int azx_alloc_stream_pages(struct azx *chip);
 void azx_free_stream_pages(struct azx *chip);
 
 /* Low level azx interface */
-void azx_init_chip(struct azx *chip, int full_reset);
+void azx_init_chip(struct azx *chip, bool full_reset);
 void azx_stop_chip(struct azx *chip);
 void azx_enter_link_reset(struct azx *chip);
 irqreturn_t azx_interrupt(int irq, void *dev_id);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 77ca894f8284..d6bca62ef387 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -636,7 +636,7 @@ static int azx_resume(struct device *dev)
 		return -EIO;
 	azx_init_pci(chip);
 
-	azx_init_chip(chip, 1);
+	azx_init_chip(chip, true);
 
 	snd_hda_resume(chip->bus);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
@@ -689,7 +689,7 @@ static int azx_runtime_resume(struct device *dev)
 	status = azx_readw(chip, STATESTS);
 
 	azx_init_pci(chip);
-	azx_init_chip(chip, 1);
+	azx_init_chip(chip, true);
 
 	bus = chip->bus;
 	if (status && bus) {
-- 
1.9.1
