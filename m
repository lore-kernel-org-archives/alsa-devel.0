From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Increase buffer sizes for the CA0106 driver.
Date: Sat, 19 Mar 2005 18:26:17 +0000
Message-ID: <423C6EC9.5070701@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010806060900060302050900"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010806060900060302050900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch increases the buffer size for the ca0106 driver, so this 
might help prevent over/underruns.

Sign off: James Courtier-Dutton

--------------010806060900060302050900
Content-Type: text/plain;
 name="ca0106-increase-buffer-sizes.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ca0106-increase-buffer-sizes.diff.txt"

Index: alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ca0106/ca0106_main.c,v
retrieving revision 1.4
diff -u -r1.4 ca0106_main.c
--- alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c	14 Feb 2005 13:46:49 -0000	1.4
+++ alsa-driver/alsa-kernel/pci/ca0106/ca0106_main.c	19 Mar 2005 18:23:18 -0000
@@ -187,9 +187,9 @@
 	.rate_max =		192000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
-	.buffer_bytes_max =	(32*1024),
+	.buffer_bytes_max =	((65536 - 64) * 8),
 	.period_bytes_min =	64,
-	.period_bytes_max =	(16*1024),
+	.period_bytes_max =	(65536 - 64),
 	.periods_min =		2,
 	.periods_max =		8,
 	.fifo_size =		0,
@@ -206,9 +206,9 @@
 	.rate_max =		48000,
 	.channels_min =		2,
 	.channels_max =		2,
-	.buffer_bytes_max =	(32*1024),
+	.buffer_bytes_max =	((65536 - 64) * 8),
 	.period_bytes_min =	64,
-	.period_bytes_max =	(16*1024),
+	.period_bytes_max =	(65536 - 64),
 	.periods_min =		2,
 	.periods_max =		2,
 	.fifo_size =		0,
@@ -513,6 +513,8 @@
 	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_PTR, channel, 0);
 	snd_ca0106_ptr_write(emu, PLAYBACK_DMA_ADDR, channel, runtime->dma_addr);
 	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
+	/* FIXME  test what 0 bytes does. */
+	snd_ca0106_ptr_write(emu, PLAYBACK_PERIOD_SIZE, channel, 0); // buffer size in bytes
 	snd_ca0106_ptr_write(emu, PLAYBACK_POINTER, channel, 0);
 	snd_ca0106_ptr_write(emu, 0x07, channel, 0x0);
 	snd_ca0106_ptr_write(emu, 0x08, channel, 0);

--------------010806060900060302050900--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
