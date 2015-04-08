From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: bebob: fix to processing in big-endian
	machine for sending cue
Date: Thu,  9 Apr 2015 01:15:03 +0900
Message-ID: <1428509703-28938-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B112606C2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:15:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Takayuki Shiroma <t.shiroma.oki@gmail.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some M-Audio devices require to receive bootup command just after
powering on, while codes in BeBoB driver doesn't work properly in
big-endian machine because the command should be aligned by
little-endian.

This commit fixes this bug. This fix should go to stable kernel.

Cc: Takayuki Shiroma <t.shiroma.oki@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index a422aaa..9ee25a6 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -96,10 +96,10 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
 	struct fw_device *device = fw_parent_device(unit);
 	int err, rcode;
 	u64 date;
-	__be32 cues[3] = {
-		MAUDIO_BOOTLOADER_CUE1,
-		MAUDIO_BOOTLOADER_CUE2,
-		MAUDIO_BOOTLOADER_CUE3
+	__le32 cues[3] = {
+		cpu_to_le32(MAUDIO_BOOTLOADER_CUE1),
+		cpu_to_le32(MAUDIO_BOOTLOADER_CUE2),
+		cpu_to_le32(MAUDIO_BOOTLOADER_CUE3)
 	};
 
 	/* check date of software used to build */
-- 
2.1.0
