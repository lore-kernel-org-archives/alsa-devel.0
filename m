From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] move EXPORT_SYMBOL's away from sound/pci/emu10k1/emu10k1_main.c
Date: Fri, 7 Apr 2006 02:31:05 +0200
Message-ID: <20060407003105.GG7118@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 4A52114F
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 02:31:06 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch moves the EXPORT_SYMBOL's from 
sound/pci/emu10k1/emu10k1_main.c to the files with the actual functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/emu10k1/emu10k1_main.c |   12 ------------
 sound/pci/emu10k1/io.c           |    2 ++
 sound/pci/emu10k1/memory.c       |    6 ++++++
 sound/pci/emu10k1/voice.c        |    3 +++
 4 files changed, 11 insertions(+), 12 deletions(-)

--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/emu10k1_main.c.old	2006-04-07 01:08:22.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/emu10k1_main.c	2006-04-07 01:08:32.000000000 +0200
@@ -1419,15 +1419,3 @@
 }
 #endif
 
-/* memory.c */
-EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
-EXPORT_SYMBOL(snd_emu10k1_synth_free);
-EXPORT_SYMBOL(snd_emu10k1_synth_bzero);
-EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
-EXPORT_SYMBOL(snd_emu10k1_memblk_map);
-/* voice.c */
-EXPORT_SYMBOL(snd_emu10k1_voice_alloc);
-EXPORT_SYMBOL(snd_emu10k1_voice_free);
-/* io.c */
-EXPORT_SYMBOL(snd_emu10k1_ptr_read);
-EXPORT_SYMBOL(snd_emu10k1_ptr_write);
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/memory.c.old	2006-04-07 01:09:12.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/memory.c	2006-04-07 01:10:01.000000000 +0200
@@ -286,6 +286,7 @@
 	spin_unlock_irqrestore(&emu->memblk_lock, flags);
 	return err;
 }
+EXPORT_SYMBOL(snd_emu10k1_memblk_map);
 
 /*
  * page allocation for DMA
@@ -386,6 +387,7 @@
 	mutex_unlock(&hdr->block_mutex);
 	return (struct snd_util_memblk *)blk;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
 
 
 /*
@@ -408,6 +410,7 @@
 	mutex_unlock(&hdr->block_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_free);
 
 
 /* check new allocation range */
@@ -539,6 +542,7 @@
 	} while (offset < end_offset);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_bzero);
 
 /*
  * copy_from_user(blk + offset, data, size)
@@ -568,3 +572,5 @@
 	} while (offset < end_offset);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
+
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/voice.c.old	2006-04-07 01:10:14.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/voice.c	2006-04-07 01:10:35.000000000 +0200
@@ -138,6 +138,7 @@
 
 	return result;
 }
+EXPORT_SYMBOL(snd_emu10k1_voice_alloc);
 
 int snd_emu10k1_voice_free(struct snd_emu10k1 *emu,
 			   struct snd_emu10k1_voice *pvoice)
@@ -153,3 +154,5 @@
 	spin_unlock_irqrestore(&emu->voice_lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_voice_free);
+
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/io.c.old	2006-04-07 01:10:46.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/io.c	2006-04-07 02:19:43.000000000 +0200
@@ -61,6 +61,7 @@
 		return val;
 	}
 }
+EXPORT_SYMBOL(snd_emu10k1_ptr_read);
 
 void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned int chn, unsigned int data)
 {
@@ -91,6 +92,7 @@
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
 	}
 }
+EXPORT_SYMBOL(snd_emu10k1_ptr_write);
 
 unsigned int snd_emu10k1_ptr20_read(struct snd_emu10k1 * emu, 
 					  unsigned int reg, 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
