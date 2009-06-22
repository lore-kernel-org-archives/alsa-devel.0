From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] sound: remove redundant tests on unsigned
Date: Mon, 22 Jun 2009 17:58:27 +0200
Message-ID: <4A3FAA23.9050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F0CE24477
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 15:57:55 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2592170fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 06:57:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

reg and channel_id are unsigned. When negative they are wrapped and caught by
the other test.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 sound/pci/ca0106/ca0106_proc.c |    2 +-
 sound/pci/emu10k1/emu10k1x.c   |    3 +--
 sound/pci/emu10k1/emuproc.c    |    2 +-
 sound/soc/codecs/tlv320aic23.c |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index c62b7d1..2deac54 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -304,7 +304,7 @@ static void snd_ca0106_proc_reg_write32(struct snd_info_entry *entry,
         while (!snd_info_get_line(buffer, line, sizeof(line))) {
                 if (sscanf(line, "%x %x", &reg, &val) != 2)
                         continue;
-                if ((reg < 0x40) && (reg >=0) && (val <= 0xffffffff) ) {
+		if ((reg < 0x40) && (val <= 0xffffffff)) {
 			spin_lock_irqsave(&emu->emu_lock, flags);
 			outl(val, emu->port + (reg & 0xfffffffc));
 			spin_unlock_irqrestore(&emu->emu_lock, flags);
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 4d3ad79..957b130 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1040,8 +1040,7 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
 			continue;
 
-		if ((reg < 0x49) && (reg >= 0) && (val <= 0xffffffff) 
-		    && (channel_id >= 0) && (channel_id <= 2) )
+		if ((reg < 0x49) && (val <= 0xffffffff) && (channel_id <= 2))
 			snd_emu10k1x_ptr_write(emu, reg, channel_id, val);
 	}
 }
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index 216f974..6ad3825 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -527,7 +527,7 @@ static void snd_emu_proc_ptr_reg_write(struct snd_info_entry *entry,
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
 			continue;
-		if ((reg < 0xa0) && (reg >= 0) && (val <= 0xffffffff) && (channel_id >= 0) && (channel_id <= 3) )
+		if ((reg < 0xa0) && (val <= 0xffffffff) && (channel_id <= 3))
 			snd_ptr_write(emu, iobase, reg, channel_id, val);
 	}
 }
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 0b8dcb5..6f8cd8d 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -85,7 +85,7 @@ static int tlv320aic23_write(struct snd_soc_codec *codec, unsigned int reg,
 	 * of data into val
 	 */
 
-	if ((reg < 0 || reg > 9) && (reg != 15)) {
+	if ((reg > 9) && (reg != 15)) {
 		printk(KERN_WARNING "%s Invalid register R%u\n", __func__, reg);
 		return -1;
 	}
