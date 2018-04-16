From: David Wang <davidwang@zhaoxin.com>
Subject: [PATCH] ALSA: hda - New VIA controller suppor no-snoop path
Date: Mon, 16 Apr 2018 17:48:09 +0800
Message-ID: <1523872089-6381-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, vinod.koul@intel.com, Vijendar.Mukunda@amd.com, subhransu.s.prusty@intel.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com, David Wang <davidwang@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

This patch is used to tell kernel that new VIA HDAC controller also
support no-snoop path.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 96143df..439e8e9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1640,7 +1640,7 @@ static void azx_check_snoop_available(struct azx *chip)
 		 */
 		u8 val;
 		pci_read_config_byte(chip->pci, 0x42, &val);
-		if (!(val & 0x80) && chip->pci->revision == 0x30)
+		if (!(val & 0x80) && (chip->pci->revision == 0x30 || chip->pci->revision == 0x20))
 			snoop = false;
 	}
 
-- 
1.9.1
