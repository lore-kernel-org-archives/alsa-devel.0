From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Tue, 17 Jan 2006 00:05:23 -0600
Message-ID: <2c746f620601162205x4bfbfefcl493cdb330dc4b5fd@mail.gmail.com>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
	 <Pine.HPX.4.33n.0510181124030.2094-100000@studcom.urz.uni-halle.de>
	 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
	 <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
	 <1129746748.5203.1.camel@mindpipe>
	 <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
	 <2c746f620601102330s337d7744r7b98dad75dbbf374@mail.gmail.com>
	 <1136964861.27255.17.camel@mindpipe>
	 <1137055672.43c617b8297f6@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1137055672.43c617b8297f6@webmail.uni-halle.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 1/12/06, Clemens Ladisch <clemens@ladisch.de> wrote:
> Lee Revell wrote:
> > On Wed, 2006-01-11 at 01:30 -0600, Eric Shattow wrote:
> > > arecord: xrun:1077: read/write error, state =3D PREPARED
>
> There may be a message in the system log.
>
> > Assuming this worked with previous versions, the problem may be that US=
B
> > audio has been broken since kernel 2.6.14 (ALSA 1.0.10rcsomething).
> >
> > Try the patch attached to this bug report.
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1585
>
> Now fixed in CVS.
>
> I've added another patch to the above bug report, or wait for the next AL=
SA
> release.
>
>
> HTH
> Clemens
>

I applied the patch, and behavior is still broken for my device.

dmesg shows the following output after plugging in the HPCDJ Console:
+usb 3-1.6: new full speed USB device using ehci_hcd and address 5
+snd-usb-audio: probe of 3-1.6:1.0 failed with error -5
+input: Hercules Hercules DJ Console as /class/input/input4
+input: USB HID v1.10 Joystick [Hercules Hercules DJ Console] on
usb-0000:00:02.2-1.6
+input: Hercules Hercules DJ Console as /class/input/input5
+input: USB HID v1.10 Mouse [Hercules Hercules DJ Console] on
usb-0000:00:02.2-1.6
+input: Hercules Hercules DJ Console as /class/input/input6
+input: USB HID v1.10 Keyboard [Hercules Hercules DJ Console] on
usb-0000:00:02.2-1.6
+snd-usb-audio: probe of 3-1.6:1.5 failed with error -5
+usbcore: registered new driver yealink
+drivers/usb/input/yealink.c: Yealink phone driver:yld-20050816

...and trying to play a sound with alsaplayer to the device:

+ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
datapipe for urb 0, err =3D -38
+ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
datapipe for urb 0, err =3D -38
+ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
datapipe for urb 0, err =3D -38
+ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
datapipe for urb 0, err =3D -38

help?

 Eric


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
