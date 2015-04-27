From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emu10k1: Fix card shortname string
	buffer overflow
Date: Mon, 27 Apr 2015 14:34:39 +0200
Message-ID: <1430138079-7793-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D3E26522E
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 14:34:40 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9E44BAB22
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 12:34:40 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Some models provide too long string for the shortname that has 32bytes
including the terminator, and it results in a non-terminated string
exposed to the user-space.  This isn't too critical, though, as the
string is stopped at the succeeding longname string.

This patch fixes such entries by dropping "SB" prefix (it's enough to
fit within 32 bytes, so far).  Meanwhile, it also changes strcpy()
with strlcpy() to make sure that this kind of problem won't happen in
future, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emu10k1.c      | 6 ++++--
 sound/pci/emu10k1/emu10k1_main.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 37d0220a094c..db7a2e5e4a14 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -183,8 +183,10 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 	}
 #endif
  
-	strcpy(card->driver, emu->card_capabilities->driver);
-	strcpy(card->shortname, emu->card_capabilities->name);
+	strlcpy(card->driver, emu->card_capabilities->driver,
+		sizeof(card->driver));
+	strlcpy(card->shortname, emu->card_capabilities->name,
+		sizeof(card->shortname));
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s (rev.%d, serial:0x%x) at 0x%lx, irq %i",
 		 card->shortname, emu->revision, emu->serial, emu->port, emu->irq);
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 54079f5d5673..4f8cf5e7e45f 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1446,7 +1446,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 *
 	 */
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x20011102,
-	 .driver = "Audigy2", .name = "SB Audigy 2 ZS Notebook [SB0530]",
+	 .driver = "Audigy2", .name = "Audigy 2 ZS Notebook [SB0530]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
@@ -1596,7 +1596,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	 .adc_1361t = 1,  /* 24 bit capture instead of 16bit */
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
-	 .driver = "Audigy2", .name = "SB Audigy 2 Platinum EX [SB0280]",
+	 .driver = "Audigy2", .name = "Audigy 2 Platinum EX [SB0280]",
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
-- 
2.3.5
