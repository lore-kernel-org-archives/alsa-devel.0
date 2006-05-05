From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: au88x0_mpu401 init / fail first open
Date: Fri, 5 May 2006 11:39:34 +0100
Message-ID: <200605051139.34432.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mtyWEF8nuY7h9ze"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_mtyWEF8nuY7h9ze
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've noticed that au88x0 has an error on the first use of the midi port only.  
With 1.0.11 midi play continues OK anyway; with the later 'fix-hang' patch it 
results in failled I/O.

Sprinkling with printks has enabled me to trace it.  It seems that when the 
port is sent 'ENTER_UART' ACK (0xfe) can be read, but the following command 
does not result in ACK, even though on it's own it would.  In its init, 
au88x0_mpu401 sends 'RESET' then 'ENTER_UART'.  Subsequently, when playng 
midi, mpu401_uart attempts output_open and also sends 'RESET' and expects ACK 
-but 0xf9 is read instead.  A second attempt to play is successful.  During 
normal use, when the output is closed, 'RESET' is sent again, but not tested 
for ACK (which would fail) and the next output_open is sucessful.

Any comments??  A hacked diff is attached which shows the affected bits of 
code, and additional writes and reads in au88x0_mpu401 which demonstrate the 
behaviour.  Result is: Temp1 0xfe, Temp2 0xfe, Temp3 0xf9, Temp4 0xfe, Temp5 
0xf9.

To fix (though not necessarily the solution) either omit the 'ENTER_UART' in 
au88x0_mpu401, or add an extra 'RESET' afterwards.

Regards    Alan

--Boundary-00=_mtyWEF8nuY7h9ze
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mpu401changes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpu401changes.diff"

diff -ru /usr/share/alsa1.0.11/alsa-driver-1.0.11-orig/alsa-kernel/drivers/mpu401/mpu401_uart.c alsa-kernel/drivers/mpu401/mpu401_uart.c
--- /usr/share/alsa1.0.11/alsa-driver-1.0.11-orig/alsa-kernel/drivers/mpu401/mpu401_uart.c	2005-11-18 18:52:14.000000000 +0000
+++ alsa-kernel/drivers/mpu401/mpu401_uart.c	2006-05-04 22:41:23.000000000 +0100
@@ -204,23 +205,29 @@
 	}
 	mpu->write(mpu, cmd, MPU401C(mpu));
 	if (ack) {
+		printk("ACK\n");
 		ok = 0;
 		timeout = 10000;
 		while (!ok && timeout-- > 0) {
-			if (snd_mpu401_input_avail(mpu)) {
+			if (timeout == 5000)  printk("%i",timeout);
+//			if (snd_mpu401_input_avail(mpu)) {
+//				printk("InAv\n");
 				if (mpu->read(mpu, MPU401D(mpu)) == MPU401_ACK)
 					ok = 1;
-			}
+//			}
 		}
 		if (!ok && mpu->read(mpu, MPU401D(mpu)) == MPU401_ACK)
 			ok = 1;
 	} else {
 		ok = 1;
 	}
+	printk("OK %i \n", ok);
 	spin_unlock_irqrestore(&mpu->input_lock, flags);
-	if (! ok)
+	if (!ok) {
 		snd_printk("cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)\n", cmd, mpu->port, mpu->read(mpu, MPU401C(mpu)), mpu->read(mpu, MPU401D(mpu)));
+		return 1;
+	}
+	return 0;
 }
 
 /*
@@ -252,39 +266,53 @@
 	if (mpu->open_output && (err = mpu->open_output(mpu)) < 0)
 		return err;
 	if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode)) {
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1);
-		snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1);
+//		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		if (snd_mpu401_uart_cmd(mpu, MPU401_RESET, 1))
+			goto error_out;
+		if (snd_mpu401_uart_cmd(mpu, MPU401_ENTER_UART, 1))
+			goto error_out;
 	}
 	mpu->substream_output = substream;
 	set_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode);
 	return 0;
+
+error_out:
+	if (mpu->open_output && mpu->close_output)
+		mpu->close_output(mpu);
+	return -EIO;
 }
 

 static int snd_mpu401_uart_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_mpu401 *mpu;
+	int err = 0;
 
 	mpu = substream->rmidi->private_data;
 	clear_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode);
 	mpu->substream_output = NULL;
 	if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode))
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
 	if (mpu->close_output)
 		mpu->close_output(mpu);
+	if (err)
+		return -EIO;
 	return 0;
 }
 
diff -ru /usr/share/alsa1.0.11/alsa-driver-1.0.11-orig/alsa-kernel/pci/au88x0/au88x0_mpu401.c alsa-kernel/pci/au88x0/au88x0_mpu401.c
--- /usr/share/alsa1.0.11/alsa-driver-1.0.11-orig/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-05-04 21:45:50.000000000 +0100
@@ -65,24 +65,45 @@
 	hwwrite(vortex->mmio, VORTEX_CTRL, temp);
 #endif
 	/* Mpu401UartInit() */
+	printk("401 init");
 	mode = 1;
 	temp = hwread(vortex->mmio, VORTEX_CTRL2) & 0xffff00cf;
 	temp |= (MIDI_CLOCK_DIV << 8) | ((mode >> 24) & 0xff) << 4;
 	hwwrite(vortex->mmio, VORTEX_CTRL2, temp);
 	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
+
+	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
+	printk("Temp1 0x%x\n", temp);
+
 	/* Set some kind of mode */
 	if (mode)
 		hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_ENTER_UART);
 
 	/* Check if anything is OK. */
 	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
+	printk("Temp2 0x%x\n", temp);
 	if (temp != MPU401_ACK /*0xfe */ ) {
 		printk(KERN_ERR "midi port doesn't acknowledge!\n");
 		return -ENODEV;
 	}
+
+	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
+	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
+	printk("Temp3 0x%x\n", temp);
+
+	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_ENTER_UART);
+	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
+	printk("Temp4 0x%x\n", temp);
+
+	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
+	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);
+	printk("Temp5 0x%x\n", temp);
+
+
 	/* Enable MPU401 interrupts. */
 	hwwrite(vortex->mmio, VORTEX_IRQ_CTRL,
 		hwread(vortex->mmio, VORTEX_IRQ_CTRL) | IRQ_MIDI);
+//	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
 
 	/* Create MPU401 instance. */
 #ifdef VORTEX_MPU401_LEGACY

--Boundary-00=_mtyWEF8nuY7h9ze--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
