From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 10/19] ALSA: hda - move alloc_cmd_io to
	hda_shared.
Date: Thu, 27 Feb 2014 22:35:53 -0800
Message-ID: <1393569362-27285-11-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f73.google.com (mail-pb0-f73.google.com
 [209.85.160.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 041462650BC
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pb0-f73.google.com with SMTP id rp16so34667pbb.0
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
removes an extra interface between hda_intel and hda_shared.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 4 ----
 sound/pci/hda/hda_shared.c | 7 ++++++-
 sound/pci/hda/hda_shared.h | 1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b00e88..ab3c015 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1777,10 +1777,6 @@ static int azx_first_init(struct azx *chip)
 	err = azx_alloc_stream_pages(chip);
 	if (err < 0)
 		return err;
-	/* allocate CORB/RIRB */
-	err = azx_alloc_cmd_io(chip);
-	if (err < 0)
-		return err;
 
 	/* initialize streams */
 	azx_init_stream(chip);
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index 0b2115e..1f307a8 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -1120,7 +1120,7 @@ int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 /*
  * CORB / RIRB interface
  */
-int azx_alloc_cmd_io(struct azx *chip)
+static int azx_alloc_cmd_io(struct azx *chip)
 {
 	int err;
 
@@ -1622,6 +1622,11 @@ int azx_alloc_stream_pages(struct azx *chip)
 		return -ENOMEM;
 	}
 	mark_pages_wc(chip, &chip->posbuf, true);
+
+	/* allocate CORB/RIRB */
+	err = azx_alloc_cmd_io(chip);
+	if (err < 0)
+		return err;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(azx_alloc_stream_pages);
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index e0f8e3d..8fed6ea 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -54,6 +54,5 @@ unsigned int azx_get_response(struct hda_bus *bus,
 void azx_init_cmd_io(struct azx *chip);
 void azx_free_cmd_io(struct azx *chip);
 void azx_update_rirb(struct azx *chip);
-int azx_alloc_cmd_io(struct azx *chip);
 
 #endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
