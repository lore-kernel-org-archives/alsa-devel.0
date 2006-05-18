From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: au88x0_mpu401 init / fail first open
Date: Thu, 18 May 2006 10:35:02 +0100
Message-ID: <200605181035.02823.gineera@aspect135.co.uk>
References: <200605051139.34432.gineera@aspect135.co.uk> <s5hhd3q464w.wl%tiwai@suse.de> <200605172244.30000.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G/DbEB5rht2gr90"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200605172244.30000.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_G/DbEB5rht2gr90
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 May 2006 22:44, you wrote:
> On Tuesday 16 May 2006 11:26, Takashi Iwai wrote:
> > At Mon, 15 May 2006 22:50:45 +0100,
> >
> > Alan Horstmann wrote:
> > > On Thursday 11 May 2006 16:01, you wrote:
> > > > At Thu, 11 May 2006 15:52:15 +0100,
> > > >
> > > > Alan Horstmann wrote:
> > > > > On Thursday 11 May 2006 15:09, you wrote:
> > > > > > At Wed, 10 May 2006 16:53:21 +0100,
> > > > > >
> > > > > > Alan Horstmann wrote:
> > > > > > > It seems that the behaviour of ENTER_UART is the same with
> > > > > > > other cards. What is different is that au88x0_mpu401 sends it
> > > > > > > during init, which for example ice1712 doesn't.  The extra
> > > > > > > ENTER_UART then fouls up the first output_open in mpu401_uart. 
> > > > > > > Removing it as per attached diff is successful.  Is this a
> > > > > > > reasonable thing to do?
> > > > > >
> > > > > > Actually, both RESET and ENTER_UART are issued at open in
> > > > > > mpu401_uart.c, so they are basically unnecessary to be called
> > > > > > here...
> > > > >
> > > > > Thanks for the confirmation.  The au88x0 init uses the ACK received
> > > > > to check the port is functioning OK so it seemed best to leave
> > > > > RESET as it caused no problems.
> > > > >
> > > > > In the diff I attached, the lines are just //out so it can be seen
> > > > > what has been taken out in case of breaking something else.  Is it
> > > > > preferable to remove them altogether instead?
> > > >
> > > > Yes but only if the patched code is confirmed to work :)
> > >
> > > It works fine for me; perhaps another au88x0 user could confirm also by
> > > applying the diff (attached again)?
> >
> > What happens if you remove MPU401_RESET there, too?
> > It's anyway issued in mpu401_uart.c later.
>
> Well, if just the MPU401_RESET line is removed, the value subsequently read
> to check if OK is not 0xfe (ACK) and so the check fails and halts loading
> the driver.  However the whole 6 lines of the check can be removed and the
> port seems to continue to function OK, but it is unnecessarily drastic to
> solve the original problem caused by the ENTER_UART, and then there is no
> check at init of the port operating OK.

...So this is my proposal to try to conclude this one -solve the init /fail 
first open problem with the minimum of alterations:

Alan


au88x0_mpu401.c-remove-enter_uart.patch

Summary: Remove ENTER_UART from au88x0 init

Remove an unnecessary ENTER_UART instruction during au88x0 init as it makes 
the first/subsequent midi open to fail.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>


--Boundary-00=_G/DbEB5rht2gr90
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="au88x0_mpu401.c-remove-enter_uart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au88x0_mpu401.c-remove-enter_uart.patch"

--- alsa-driver-1.0.11-orig/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-05-10 16:17:10.000000000 +0100
@@ -70,9 +70,6 @@
 	temp |= (MIDI_CLOCK_DIV << 8) | ((mode >> 24) & 0xff) << 4;
 	hwwrite(vortex->mmio, VORTEX_CTRL2, temp);
 	hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_RESET);
-	/* Set some kind of mode */
-	if (mode)
-		hwwrite(vortex->mmio, VORTEX_MIDI_CMD, MPU401_ENTER_UART);

 	/* Check if anything is OK. */
 	temp = hwread(vortex->mmio, VORTEX_MIDI_DATA);

--Boundary-00=_G/DbEB5rht2gr90--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
