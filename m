From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: usb-usx2y: playback fails with Tascam US122 on kernel
	3.14
Date: Thu, 26 Jun 2014 15:51:54 +0100
Message-ID: <4546801.Z4WD7yaEHq@arial>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E45F2669CD
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 16:51:56 +0200 (CEST)
Received: from cas06.campus.gla.ac.uk ([130.209.14.39])
 by plockton.cent.gla.ac.uk with esmtp (Exim 4.72)
 (envelope-from <Nicholas.Bailey@glasgow.ac.uk>) id 1X0B1o-0007Qh-2z
 for alsa-devel@alsa-project.org; Thu, 26 Jun 2014 15:51:56 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am having trouble with the US122 in playback and duplex mode. In capture =

mode, it is working.

This problem occurs on (at least)
Linux arial 3.14-1-686-pae #1 SMP Debian 3.14.7-1 (2014-06-16) i686 GNU/Lin=
ux

I note that my computer uses the much-maligned Intel Corporation 5 Series/3=
400 =

chipset (rev 05), but I have a UK=A312 5.1 out/2.0 in audio adaptor which w=
orks =

in either capture or playback (although not in duplex). Also, booting an ol=
d =

kernel:

Linux arial 3.2.0-4-686-pae #1 SMP Debian 3.2.57-3+deb7u2 i686 GNU/Linux

or

Linux arial 3.10.11 #1 SMP Wed Oct 2 19:26:59 BST 2013 i686 GNU/Linux

both seem to support full duplex operation. This is therefore a regression =

between 3.10.11 and 3.14-1 (at least, something on my system has regressed =
and =

I am suspecting the usx2y module).

dmesg tells me:

[ 2873.134973] usb 2-1.6: new full-speed USB device number 9 using ehci-pci
[ 2873.228117] usb 2-1.6: New USB device found, idVendor=3D1604, idProduct=
=3D8006
[ 2873.228122] usb 2-1.6: New USB device strings: Mfr=3D0, Product=3D0, =

SerialNumber=3D0
[ 2873.447646] usb 2-1.6: USB disconnect, device number 9
[ 2875.183348] usb 2-1.6: new full-speed USB device number 10 using ehci-pci
[ 2875.277235] usb 2-1.6: New USB device found, idVendor=3D1604, idProduct=
=3D8007
[ 2875.277240] usb 2-1.6: New USB device strings: Mfr=3D0, Product=3D0, =

SerialNumber=3D0
[ 2877.844821] cannot submit datapipe for urb 0, err =3D -28
... this message repeated many times ...
[ 2877.912388] cannot submit datapipe for urb 0, err =3D -28
[ 3528.609688] active frame status -18. Most probably some hardware problem.

I used to use these interfaces with jack in duplex mode, but this is no lon=
ger =

possible.

Running up audacity for a test, capture from the US122 works fine, but once=
 the =

US122 is selected for playback, audacity pops up an "Error opening sound =

device". Further attempts to record (even capture-only) result in corrupted=
, =

high-amplitude noise.

Nick/.

Other info which might help (a bit noisy, because I'm not sure exactly what=
's =

wrong) follows.

Using aplay with --dump-hw-parameters:

Under kernel 3.14-1:
HW Params of device "hw:USX2Y":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S24_3LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 24]
FRAME_BITS: [32 48]
CHANNELS: 2
RATE: [44100 48000]
PERIOD_TIME: [1000 185760)
PERIOD_SIZE: [45 8192]
PERIOD_BYTES: [180 49152]
PERIODS: [2 365)
BUFFER_TIME: [1875 371520)
BUFFER_SIZE: [90 16384]
BUFFER_BYTES: [360 65536]
TICK_TIME: ALL
--------------------
aplay: set_params:1297: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (92879 92880)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: 4
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0


Using kernel 3.10.11:

HW Params of device "hw:USX2Y":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S24_3LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 24]
FRAME_BITS: [32 48]
CHANNELS: 2
RATE: [44100 48000]
PERIOD_TIME: [1000 185760)
PERIOD_SIZE: [45 8192]
PERIOD_BYTES: [180 49152]
PERIODS: [2 365)
BUFFER_TIME: [1875 371520)
BUFFER_SIZE: [90 16384]
BUFFER_BYTES: [360 65536]
TICK_TIME: ALL
--------------------
(plays OK)


Error log when running jackd from qjackctl on the 3.14 kernel:

15:22:31.126 Patchbay deactivated.
15:22:31.165 Statistics reset.
15:22:31.295 ALSA connection change.
15:22:33.840 D-BUS: Service is available (org.jackaudio.service aka jackdbu=
s).
Cannot connect to server socket err =3D No such file or directory
Cannot connect to server request channel
jack server is not running or cannot be started
15:22:43.516 D-BUS: JACK server could not be started. Sorry
Cannot connect to server socket err =3D No such file or directory
Cannot connect to server request channel
jack server is not running or cannot be started
Thu Jun 26 15:22:43 2014: Starting jack server...
Thu Jun 26 15:22:43 2014: JACK server starting in non-realtime mode
Thu Jun 26 15:22:43 2014: self-connect-mode is "Don't restrict self connect =

requests"
Thu Jun 26 15:22:43 2014: Acquired audio card Audio1
Thu Jun 26 15:22:43 2014: creating alsa driver ... hw:USX2Y|hw:USX2Y|1024|3|
48000|0|0|nomon|swmeter|-|16bit
Thu Jun 26 15:22:43 2014: configuring for 48000Hz, period =3D 1024 frames (=
21.3 =

ms), buffer =3D 3 periods
Thu Jun 26 15:22:43 2014: ALSA: final selected sample format for capture: 1=
6bit =

little-endian
Thu Jun 26 15:22:43 2014: ALSA: use 3 periods for capture
Thu Jun 26 15:22:43 2014: ALSA: final selected sample format for playback: =

16bit little-endian
Thu Jun 26 15:22:43 2014: ALSA: use 3 periods for playback
Thu Jun 26 15:22:43 2014: ERROR: ALSA: cannot set hardware parameters for =

playback
Thu Jun 26 15:22:43 2014: ERROR: ALSA: cannot configure playback channel
Thu Jun 26 15:22:43 2014: ERROR: Cannot initialize driver
Thu Jun 26 15:22:43 2014: ERROR: JackServer::Open failed with -1
Thu Jun 26 15:22:43 2014: ERROR: Failed to open server
Thu Jun 26 15:22:44 2014: Saving settings to "/home/nick/.config/jack/conf.=
xml" =

...
15:23:00.574 Could not connect to JACK server as client. - Overall operatio=
n =

failed. - Unable to connect to server. Please check the messages window for =

more info.
Cannot connect to server socket err =3D No such file or directory
Cannot connect to server request channel
jack server is not running or cannot be started

nick@arial:~$ cat .jackdrc =

/usr/bin/jackd -r -m -dalsa -dhw:USX2Y -r48000 -p1024 -n3 -S
nick@arial:~$ cat .config/jack/conf.xml =

<?xml version=3D"1.0"?>
<!--
JACK settings, as persisted by D-Bus object.
You probably don't want to edit this because
it will be overwritten next time jackdbus saves.
-->
<!-- Thu Jun 26 15:22:44 2014 -->
<jack>
 <engine>
  <option name=3D"driver">alsa</option>
  <option name=3D"realtime">false</option>
  <option name=3D"verbose">false</option>
  <option name=3D"client-timeout">500</option>
 </engine>
 <drivers>
  <driver name=3D"net">
  </driver>
  <driver name=3D"alsarawmidi">
  </driver>
  <driver name=3D"loopback">
  </driver>
  <driver name=3D"firewire">
   <option name=3D"period">512</option>
   <option name=3D"nperiods">3</option>
   <option name=3D"rate">48000</option>
   <option name=3D"duplex">true</option>
  </driver>
  <driver name=3D"netone">
  </driver>
  <driver name=3D"alsa">
   <option name=3D"device">hw:USX2Y</option>
   <option name=3D"capture">hw:USX2Y</option>
   <option name=3D"playback">hw:USX2Y</option>
   <option name=3D"rate">48000</option>
   <option name=3D"period">1024</option>
   <option name=3D"nperiods">3</option>
   <option name=3D"hwmon">false</option>
   <option name=3D"hwmeter">false</option>
   <option name=3D"duplex">true</option>
   <option name=3D"softmode">false</option>
   <option name=3D"monitor">false</option>
   <option name=3D"dither">n</option>
   <option name=3D"shorts">true</option>
  </driver>
  <driver name=3D"dummy">
  </driver>
 </drivers>
 <internals>
  <internal name=3D"audioadapter">
  </internal>
  <internal name=3D"profiler">
  </internal>
  <internal name=3D"netadapter">
  </internal>
  <internal name=3D"netmanager">
  </internal>
 </internals>
</jack>
