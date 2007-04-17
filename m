From: bainonline@gmail.com
Subject: [PATCH] [ALSA] Add first generation macbook subsystem ID
Date: Tue, 17 Apr 2007 10:01:47 +0530
Message-ID: <46244dbb.7672bd23.37b9.00c5@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031082AbXDQEb6@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Abhijit Bhopatkar <bainonline@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Abhijit Bhopatkar <bainonline@gmail.com>

First generation MacBooks were getting ignored by sigmatel drivers
and wrongly being identified as MACMINI. This patch makes them
identify as MACBOOK.

Signed-off-by: Abhijit Bhopatkar <bainonline@gmail.com>
---
 sound/pci/hda/patch_sigmatel.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index c94291b..cb99df5 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1905,6 +1905,9 @@ static int patch_stac922x(struct hda_codec *codec)
 		 */
 		printk(KERN_INFO "hda_codec: STAC922x, Apple subsys_id=%x\n", codec->subsystem_id);
 		switch (codec->subsystem_id) {
+		case 0x106b0a00: /* MacBook First generatoin */
+			spec->board_config = STAC_MACBOOK;
+			break;
 		case 0x106b0200: /* MacBook Pro first generation */
 			spec->board_config = STAC_MACBOOK_PRO_V1;
 			break;
-- 
1.4.4.2
