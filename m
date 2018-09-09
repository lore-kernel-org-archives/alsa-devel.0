From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: bebob: use address returned by kmalloc()
	instead of kernel stack for streaming DMA mapping
Date: Sun,  9 Sep 2018 22:25:12 +0900
Message-ID: <20180909132512.2328-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EACC82676ED
 for <alsa-devel@alsa-project.org>; Sun,  9 Sep 2018 15:25:22 +0200 (CEST)
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so9152511pfn.0
 for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2018 06:25:22 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When executing 'fw_run_transaction()' with 'TCODE_WRITE_BLOCK_REQUEST',
an address of 'payload' argument is used for streaming DMA mapping by
'firewire_ohci' module if 'size' argument is larger than 8 byte.
Although in this case the address should not be on kernel stack, current
implementation of ALSA bebob driver uses data in kernel stack for a cue
to boot M-Audio devices. This often brings unexpected result, especially
for a case of CONFIG_VMAP_STACK=y.

This commit fixes the bug.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=201021
Reference: https://forum.manjaro.org/t/firewire-m-audio-410-driver-wont-load-firmware/51165
Fixes: a2b2a7798fb6('ALSA: bebob: Send a cue to load firmware for M-Audio Firewire series')
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index bd55620c6a47..0c5a4cbb99ba 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -96,17 +96,13 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
 	struct fw_device *device = fw_parent_device(unit);
 	int err, rcode;
 	u64 date;
-	__le32 cues[3] = {
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE1),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE2),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE3)
-	};
+	__le32 *cues;
 
 	/* check date of software used to build */
 	err = snd_bebob_read_block(unit, INFO_OFFSET_SW_DATE,
 				   &date, sizeof(u64));
 	if (err < 0)
-		goto end;
+		return err;
 	/*
 	 * firmware version 5058 or later has date later than "20070401", but
 	 * 'date' is not null-terminated.
@@ -114,20 +110,28 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
 	if (date < 0x3230303730343031LL) {
 		dev_err(&unit->device,
 			"Use firmware version 5058 or later\n");
-		err = -ENOSYS;
-		goto end;
+		return -ENXIO;
 	}
 
+	cues = kmalloc_array(3, sizeof(*cues), GFP_KERNEL);
+	if (!cues)
+		return -ENOMEM;
+
+	cues[0] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE1);
+	cues[1] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE2);
+	cues[2] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE3);
+
 	rcode = fw_run_transaction(device->card, TCODE_WRITE_BLOCK_REQUEST,
 				   device->node_id, device->generation,
 				   device->max_speed, BEBOB_ADDR_REG_REQ,
-				   cues, sizeof(cues));
+				   cues, 3 * sizeof(*cues));
+	kfree(cues);
 	if (rcode != RCODE_COMPLETE) {
 		dev_err(&unit->device,
 			"Failed to send a cue to load firmware\n");
 		err = -EIO;
 	}
-end:
+
 	return err;
 }
 
-- 
2.17.1
