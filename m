From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: emu10k1: shift wrapping bug in snd_emu10k1_ptr_read()
Date: Thu, 24 Nov 2016 14:23:33 +0300
Message-ID: <20161124112333.GL17225@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Static analysis says "size" is a number 0-63.  So we really want to be
doing the shift as a u64 and not a int type.  Presumably "size" is never
actually more than 31 otherwise the shift wrap would have been detected
in testing.  The "mask" is a u32 so we only care about the bottom 32
bits which also implies that "size" is less than 32.

This code pre-dates git.  I haven't tested this change, it's to fix a
static analysis warning.  I can't think that shift wrapping is the
correct behavior so presumably this change is harmless but it definitely
changes how the code works when size is larger than 32.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 706b4f0..fd204f3 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -46,7 +46,7 @@ unsigned int snd_emu10k1_ptr_read(struct snd_emu10k1 * emu, unsigned int reg, un
 		
 		size = (reg >> 24) & 0x3f;
 		offset = (reg >> 16) & 0x1f;
-		mask = ((1 << size) - 1) << offset;
+		mask = ((1ULL << size) - 1) << offset;
 		
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		outl(regptr, emu->port + PTR);
@@ -81,7 +81,7 @@ void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned i
 
 		size = (reg >> 24) & 0x3f;
 		offset = (reg >> 16) & 0x1f;
-		mask = ((1 << size) - 1) << offset;
+		mask = ((1ULL << size) - 1) << offset;
 		data = (data << offset) & mask;
 
 		spin_lock_irqsave(&emu->emu_lock, flags);
