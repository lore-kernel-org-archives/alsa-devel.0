From: noreply@alsa-project.org
Subject: [ALSA - driver 0000264]: Can not set recording source & twick line in volume
Date: Tue, 22 Jun 2004 14:51:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <05263b969495f1dc47827b8ded21abb0@bugtrack.alsa-project.org>
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
0264
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                teras
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     264
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Debian unstable
Kernel Version:             2.6.2
Resolution:                 not a bug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-08-2004 21:28 CEST
Last Modified:              06-22-2004 14:50 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Can not set recording source & twick line in =
volume
Description:=20
This problem is strange, because it does not appear in stock kernel 2.6.2
but it started to appear in later kernels, 2.6.3 up to 2.6.5 (and also in
alsa driver 1.0.4).

I am using both my PCI SB Audigy card and my on-board Intel AC'97
controller, with the modules snd-emu10k1 and snd-intel8x0. The onboard
card is wired to the line in of the SB card. WIth kernel 2.6.2 everything
works fine. I can hear the sound of the intel card through the SB card an=
d
also increase/decrease the line in volume of the SB card.

On later kernels, as well as alsa 1.0.4 I can not longer see the selectio=
n
of the "record source" for the SB, in ANY mixer. Moreover the default
input is the microphone (which is something I don't want to. The selectio=
n
of the "recording source" for the intel card does appear.

Also the volume slider for the microphone does not work. No matter what I
do, the volume remain constant. Of course I can controll it with other
means, but this is not the point.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 teras - 06-13-2004 13:11 CEST=20
----------------------------------------------------------------------
Just for reference, this is the lspci for this card:

0000:02:04.0 Multimedia audio controller: Creative Labs SB Audigy (rev
03)

or (in -n mode)
0000:02:04.0 Class 0401: 1102:0004 (rev 03)

----------------------------------------------------------------------
 pzad - 06-14-2004 08:38 CEST=20
----------------------------------------------------------------------
And for what you need to set capture source ????
You only need to set capture volume.

If you want capture from analog sources (Line In, CD, Aux) set Analog Mix
Capture Volume
If you dont want hear Line In while capture set Analog Mix Playback Volum=
e
to 0

There are 2 Mic controls
Mic Playback Volume - controls playback volume
Mic Capture Volume - controls capture volume

----------------------------------------------------------------------
 teras - 06-18-2004 11:52 CEST=20
----------------------------------------------------------------------
OK, now it works, the way you told me. Still it's strange that these
controls are not marked as "input" or something like that.

So, let's say it's not a bug, but a feature :P

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-08-04 21:28 teras          New Bug                                    =
 =20
05-08-04 21:28 teras          Distribution              =3D> Debian unsta=
ble=20
05-08-04 21:28 teras          Kernel Version            =3D> 2.6.2       =
   =20
05-09-04 12:40 teras          Bug Monitored: teras                       =
 =20
06-13-04 13:11 teras          Bugnote Added: 0001304                     =
 =20
06-14-04 08:38 pzad           Bugnote Added: 0001307                     =
 =20
06-18-04 11:52 teras          Bugnote Added: 0001318                     =
 =20
06-22-04 14:50 tiwai          Assigned To               =3D> tiwai       =
   =20
06-22-04 14:50 tiwai          Resolution               open =3D> not a bu=
g  =20
06-22-04 14:50 tiwai          Status                   new =3D> resolved =
   =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
