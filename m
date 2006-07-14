From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000311]: error messages: boot process,
	application start
Date: Fri, 14 Jul 2006 21:00:13 +0200
Message-ID: <ddbd44ea26b3f314e926893bc0e8c614@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FFF2197
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 21:00:13 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D311> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                phil
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   311
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian sid
Kernel Version:             vanilla 2.6.5
Resolution:                 fixed
Fixed in Version:           =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-27-2004 15:00 CEST
Last Modified:              07-14-2006 21:00 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    error messages: boot process, application start
Description: =

Everytime I boot my machine I get the following error code:

PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
ALSA sound/pci/ac97/ac97_codec.c:1868: MC'97 1 converters and GPIO not
ready (0xff00)
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
intel8x0_measure_ac97_clock: measured 49475 usecs
intel8x0: clocking to 48000



And the following one after starting frozen-bubble:

ALSA sound/core/seq/oss/seq_oss_init.c:213: no device found
ALSA sound/pci/intel8x0.c:596: codec_semaphore: semaphore is not ready
[0x1][0x700300]
ALSA sound/pci/intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x2c


That's the only thing. Sound works fine - it's only the message I'm
concernd about...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 nshmyrev - 01-13-05 23:35 =

----------------------------------------------------------------------
Still have the same problems with kernel 2.6.10 when I load snd_intel8x0
and snd_intel8x0m. For me that message doesn't brake anything, but it's
still not so pleasure to see warnings in syslog.

codec_semaphore: semaphore is not ready [0x1][0x701300]
codec_write 1: semaphore is not ready for register 0x54


Moreower, David G=F3mez <dabisu@gmail.com> reported that such messages
brakes sound working:

It's broken, at least in 2.6.10. In my case, if i loaded the modem
driver, the sound one stopped working (with a lot of semaphore
errors...) My solution is not using the modem driver by now :(. I
think that Takashi said that there was a problem in common
initialization in both drivers, so i hope it gets fixed soon ;)

So, hope this problem will be fixed somehow ;)

----------------------------------------------------------------------
 phil - 11-24-05 10:06 =

----------------------------------------------------------------------
At the moment I'm using a Debian 2.6.14 kernel and Alsa 1.0.9b -  and the
messages are gone.

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-27-04 15:00 phil           New Issue                                    =

05-27-04 15:00 phil           Distribution              =3D> Debian sid    =
  =

05-27-04 15:00 phil           Kernel Version            =3D> vanilla 2.6.5 =
  =

05-28-04 17:03 tiwai          Note Added: 0001266                          =

06-21-04 10:15 phil           Note Added: 0001326                          =

06-30-04 16:35 tiwai          Note Added: 0001357                          =

01-13-05 23:35 nshmyrev       Note Added: 0003205                          =

01-13-05 23:39 nshmyrev       Issue Monitored: nshmyrev                    =

11-24-05 10:06 phil           Note Added: 0006839                          =

07-14-06 21:00 Adrian Bunk    Status                   new =3D> resolved   =
  =

07-14-06 21:00 Adrian Bunk    Resolution               open =3D> fixed     =
  =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
