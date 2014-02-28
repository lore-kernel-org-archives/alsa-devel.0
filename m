From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 15/22] ALSA: hda - move alloc_cmd_io to
	hda_controller
Date: Fri, 28 Feb 2014 15:41:26 -0800
Message-ID: <1393630893-29010-16-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f73.google.com (mail-pb0-f73.google.com
 [209.85.160.73])
 by alsa0.perex.cz (Postfix) with ESMTP id B18232659CC
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-pb0-f73.google.com with SMTP id rp16so173934pbb.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Combining the call to alloc_cmd_io with the allocate pages function
removes an extra interface between hda_intel and hda_controller.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_controller.c | 7 ++++++-
 sound/pci/hda/hda_controller.h | 1 -
 sound/pci/hda/hda_intel.c      | 4 ----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ed76f81..a7c5a5d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1026,7 +1026,7 @@ EXPORT_SYMBOL_GPL(azx_attach_pcm_stream);
 /*
  * CORB / RIRB interface
  */
-int azx_alloc_cmd_io(struct azx *chip)
+static int azx_alloc_cmd_io(struct azx *chip)
 {
 	int err;
 
@@ -1549,6 +1549,11 @@ int azx_alloc_stream_pages(struct azx *chip)
 		dev_err(card->dev, "cannot allocate posbuf\n");
 		return -ENOMEM;
 	}
+
+	/* allocate CORB/RIRB */
+	err = azx_alloc_cmd_io(chip);
+	if (err < 0)
+		return err;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(azx_alloc_stream_pages);
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index fb0cddd..3a3d78e 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,7 +50,6 @@ void azx_free_stream_pages(struct azx *chip);
 /*
  * CORB / RIRB interface
  */
-int azx_alloc_cmd_io(struct azx *chip);
 void azx_init_cmd_io(struct azx *chip);
 void azx_free_cmd_io(struct azx *chip);
 void azx_update_rirb(struct azx *chip);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a8af3d4..3d6ccb8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1809,10 +1809,6 @@ static int azx_first_init(struct azx *chip)
 	err = azx_alloc_stream_pages(chip);
 	if (err < 0)
 		return err;
-	/* allocate CORB/RIRB */
-	err = azx_alloc_cmd_io(chip);
-	if (err < 0)
-		return err;
 
 	/* initialize streams */
 	azx_init_stream(chip);
-- 
1.8.1.3.605.g02339dd
