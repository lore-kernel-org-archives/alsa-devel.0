From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Fix 96000 SPDIF out from Audigy 2 P16V.
Date: Sat, 19 Mar 2005 16:02:13 +0000
Message-ID: <423C4D05.9030009@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090401070501090100020607"
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 17B171DC
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 17:02:15 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1DCgP0-0005xB-7a
	for alsa-devel@alsa-project.org; Sat, 19 Mar 2005 16:02:14 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090401070501090100020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This allows one to output at 96000 to the SPDIF using the P16V chip.
Note: The sample phase is wrong when using the P16V chip, but at least 
no resampling is done.

Signoff: James Courtier-Dutton

--------------090401070501090100020607
Content-Type: text/plain;
 name="audigy2-fix-spdif-rates.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy2-fix-spdif-rates.diff.txt"

Index: alsa-driver/alsa-kernel/pci/emu10k1/p16v.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/p16v.c,v
retrieving revision 1.1
diff -u -r1.1 p16v.c
--- alsa-driver/alsa-kernel/pci/emu10k1/p16v.c	13 Mar 2005 12:17:10 -0000	1.1
+++ alsa-driver/alsa-kernel/pci/emu10k1/p16v.c	19 Mar 2005 15:57:46 -0000
@@ -229,22 +229,24 @@
 	u32 *table_base = (u32 *)(emu->p16v_buffer.area+(8*16*channel));
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	int i;
+	u32 tmp;
 	
         //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
         //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
 	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->p16v_buffer.addr, emu->p16v_buffer.area, emu->p16v_buffer.bytes);
+	tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, channel);
         switch (runtime->rate) {
 	case 44100:
-	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, 0x8000); /* FIXME: This will change the capture rate as well! */
+	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, (tmp & ~0xe000) | 0x8000); /* FIXME: This will change the capture rate as well! */
 	  break;
 	case 48000:
-	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, 0x1000); /* FIXME: This will change the capture rate as well! */
+	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, (tmp & ~0xe000) | 0x0000); /* FIXME: This will change the capture rate as well! */
 	  break;
 	case 96000:
-	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, 0x4000); /* FIXME: This will change the capture rate as well! */
+	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, (tmp & ~0xe000) | 0x4000); /* FIXME: This will change the capture rate as well! */
 	  break;
 	case 192000:
-	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, 0x2000); /* FIXME: This will change the capture rate as well! */
+	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, (tmp & ~0xe000) | 0x2000); /* FIXME: This will change the capture rate as well! */
 	  break;
 	default:
 	  snd_emu10k1_ptr_write(emu, A_SPDIF_SAMPLERATE, channel, 0x0000); /* FIXME: This will change the capture rate as well! */

--------------090401070501090100020607--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
