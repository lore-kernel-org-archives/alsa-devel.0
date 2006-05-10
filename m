From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: au88x0_mpu401 init / fail first open
Date: Wed, 10 May 2006 16:53:21 +0100
Message-ID: <200605101653.21574.gineera@aspect135.co.uk>
References: <200605051139.34432.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xxgYEK5LluJYwIp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200605051139.34432.gineera@aspect135.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_xxgYEK5LluJYwIp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 05 May 2006 11:39, I wrote:
> I've noticed that au88x0 has an error on the first use of the midi port
> only. With 1.0.11 midi play continues OK anyway; with the later 'fix-hang'
> patch it results in failled I/O.
>
> Sprinkling with printks has enabled me to trace it.  It seems that when the
> port is sent 'ENTER_UART' ACK (0xfe) can be read, but the following command
> does not result in ACK, even though on it's own it would.  In its init,
> au88x0_mpu401 sends 'RESET' then 'ENTER_UART'.  Subsequently, when playng
> midi, mpu401_uart attempts output_open and also sends 'RESET' and expects
> ACK -but 0xf9 is read instead.  A second attempt to play is successful. 
> During normal use, when the output is closed, 'RESET' is sent again, but
> not tested for ACK (which would fail) and the next output_open is
> sucessful.
>
> Any comments??  A hacked diff is attached which shows the affected bits of
> code, and additional writes and reads in au88x0_mpu401 which demonstrate
> the behaviour.  Result is: Temp1 0xfe, Temp2 0xfe, Temp3 0xf9, Temp4 0xfe,
> Temp5 0xf9.
>
> To fix (though not necessarily the solution) either omit the 'ENTER_UART'
> in au88x0_mpu401, or add an extra 'RESET' afterwards.

Perhaps I didn't explain it very well.  Raymond has confirmed the behaviour.  
I could not find any info on the mpu401 commands; do you have a better idea?

It seems that the behaviour of ENTER_UART is the same with other cards.  What 
is different is that au88x0_mpu401 sends it during init, which for example 
ice1712 doesn't.  The extra ENTER_UART then fouls up the first output_open in 
mpu401_uart.  Removing it as per attached diff is successful.  Is this a 
reasonable thing to do?


Regards    Alan

--Boundary-00=_xxgYEK5LluJYwIp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="au88x0_mpu401.c-remove-enter_uart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au88x0_mpu401.c-remove-enter_uart.diff"

--- alsa-driver-1.0.11-orig/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-05-10 16:17:10.000000000 +0100
@@ -70,9 +70,9 @@
 	temp |= (MIDI_CLOCK_DIV << 8) | ((mode >> 24) & 0xff) << 4;
 	hwwrite(vortex->mmio, VORTEX_CTRL2, temp);
 	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
-	/* Set some kind of mode */
-	if (mode)
-		hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_ENTER_UART);
+//	/* Set some kind of mode */
+//	if (mode)                    Removed as fouls mpu401_uart.c: snd_mpu401_uart_output_open
+//		hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_ENTER_UART);
 
 	/* Check if anything is OK. */
 	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);

--Boundary-00=_xxgYEK5LluJYwIp--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
