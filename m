From: noreply@alsa-project.org
Subject: [ALSA - driver 0000363]: USB webcam microphone recognized but not working
Date: Wed, 7 Jul 2004 17:37:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <eb471145821d6a58626e59ef7fb0ef95@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0363
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                sehh
Assigned To:                Clemens Ladisch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     363
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.1
Resolution:                 fixed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-03-2004 18:44 CEST
Last Modified:              07-07-2004 17:37 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    USB webcam microphone recognized but not work=
ing
Description:=20
Logitech QuickCam 3000 Pro (USB)

This USB webcam has an internal microphone which is
properly recognized by the USB stack as well as
ALSA which loads the snd-usb-audio driver properly.

Unfortunately the microphone doesn't seem to work though
and there is no way to access it. The AlsaMixer only
shows the microphone of the onboard sound card and has
the option to change from Mic1 to Mic2, which has no
effect.

No ALSA compatible application can find the new microphone.

The following are some messages produced in /var/log/messages:

Jul  3 00:20:15 system kernel: pwc Philips PCA645/646 + PCVC675/680/690 +
PCVC730/740/750 webcam module version 8.12 loaded.
Jul  3 00:20:15 system kernel: pwc Also supports the Askey VC010, various
Logitech QuickCams, Samsung MPC-C10 and MPC-C30,
Jul  3 00:20:16 system kernel: pwc the Creative WebCam 5, SOTEC Afina Eye
and Visionite VCS-UC300 and VCS-UM100.
Jul  3 00:20:16 system kernel: pwc Logitech QuickCam Pro 3000 USB webcam
detected.
Jul  3 00:20:16 system kernel: pwc Registered as /dev/video0.
Jul  3 00:20:16 system kernel: usbcore: registered new driver Philips
webcam
Jul  3 00:20:16 system kernel: usbaudio: device 2 audiocontrol interface =
1
has 1 input and 0 output AudioStreaming interfaces
Jul  3 00:20:16 system kernel: usbaudio: device 2 interface 2 altsetting =
0
FORMAT_TYPE descriptor not found
Jul  3 00:20:16 system kernel: usbaudio: valid input sample rate 44100
Jul  3 00:20:16 system kernel: usbaudio: device 2 interface 2 altsetting
1: format 0x00000010 sratelo 44100 sratehi 44100 attributes 0x00Jul  3
00:20:16 system kernel: usbaudio: valid input sample rate 22050
Jul  3 00:20:16 system kernel: usbaudio: device 2 interface 2 altsetting
2: format 0x00000010 sratelo 22050 sratehi 22050 attributes 0x00Jul  3
00:20:16 system kernel: usbaudio: valid input sample rate 11025
Jul  3 00:20:16 system kernel: usbaudio: device 2 interface 2 altsetting
3: format 0x00000010 sratelo 11025 sratehi 11025 attributes 0x00Jul  3
00:20:16 system kernel: usbaudio: valid input sample rate 8000
Jul  3 00:20:16 system kernel: usbaudio: device 2 interface 2 altsetting
4: format 0x00000010 sratelo 8000 sratehi 8000 attributes 0x00
Jul  3 00:20:16 system kernel: usbaudio: registered dsp 14,19
Jul  3 00:20:16 system kernel: usbaudio: warning: found 1 of 0 logical
channels.
Jul  3 00:20:16 system kernel: usbaudio: assuming the channel found is th=
e
master channel (got a Philips camera?). Should be fine.
Jul  3 00:20:16 system kernel: usbaudio: registered mixer 14,16
Jul  3 00:20:16 system kernel: usbcore: registered new driver audio
Jul  3 00:20:16 system kernel: drivers/usb/class/audio.c: v1.0.0:USB Audi=
o
Class driver
Jul  3 00:20:16 system kernel: usbcore: registered new driver
snd-usb-audio

My /etc/modprobe.conf contains the following:
alias snd-card-0 snd-via82xx
alias snd-card-1 snd-usb-audio

install snd-via82xx /sbin/modprobe --ignore-install snd-via82xx &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd-via82xx { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-via82xx

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Clemens Ladisch - 07-06-2004 18:48 CEST=20
----------------------------------------------------------------------
> kernel: drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver

This is the kernel's OSS driver.  It got loaded automatically before the
ALSA driver.  Complain to the FC2 guys, and put the line

audio

into your /etc/hotplug/blacklist file.

----------------------------------------------------------------------
 sehh - 07-07-2004 13:11 CEST=20
----------------------------------------------------------------------
THANK YOU!!!

that did the trick!!

----------------------------------------------------------------------
 sehh - 07-07-2004 13:12 CEST=20
----------------------------------------------------------------------
(we may close this bug now, though i can't find a way to do it)

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-03-04 18:44 sehh           New Bug                                    =
 =20
07-03-04 18:44 sehh           Distribution              =3D> Fedora Core =
2  =20
07-03-04 18:44 sehh           Kernel Version            =3D> 2.6.6-1.435.=
2.1=20
07-06-04 18:48 Clemens LadischBugnote Added: 0001386                     =
 =20
07-07-04 13:11 sehh           Bugnote Added: 0001391                     =
 =20
07-07-04 13:12 sehh           Bugnote Added: 0001392                     =
 =20
07-07-04 17:37 Clemens LadischResolution               open =3D> fixed   =
   =20
07-07-04 17:37 Clemens LadischStatus                   assigned =3D> reso=
lved
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
