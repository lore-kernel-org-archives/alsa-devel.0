From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix MPU-401 port names
Date: Mon, 23 Feb 2004 10:06:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231005480.20713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


remove unneeded technical information from port names


Index: alsa-kernel/drivers/mpu401/mpu401_uart.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/mpu401/mpu401_uart.c,v
retrieving revision 1.29
diff -u -r1.29 mpu401_uart.c
--- alsa-kernel/drivers/mpu401/mpu401_uart.c	13 Jan 2004 17:11:25 -0000	1.29
+++ alsa-kernel/drivers/mpu401/mpu401_uart.c	23 Feb 2004 08:27:41 -0000
@@ -528,9 +528,9 @@
 	mpu->irq = irq;
 	mpu->irq_flags = irq_flags;
 	if (card->shortname[0])
-		snprintf(rmidi->name, sizeof(rmidi->name), "%s MPU-401", card->shortname);
+		snprintf(rmidi->name, sizeof(rmidi->name), "%s MIDI", card->shortname);
 	else
-		sprintf(rmidi->name, "MPU-401 (UART) %d-%d", card->number, device);
+		sprintf(rmidi->name, "MPU-401 MIDI %d-%d", card->number, device);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_mpu401_uart_output);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_mpu401_uart_input);
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
