From: noreply@alsa-project.org
Subject: [ALSA - driver 0000312]: MasterVolume & Headphone volume switched...
Date: Sat, 10 Jul 2004 04:39:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <e635cc69f512733d4dfd9a8770aaff9f@bugtrack.alsa-project.org>
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


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0312
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                subdude
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     312
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware Current
Kernel Version:             2.4.26
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-29-2004 11:11 CEST
Last Modified:              07-10-2004 04:39 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    MasterVolume & Headphone volume switched...
Description:=20
The onboard sound chip is called a VIA 8233/8235.

I am running dxs_support=3D4

I have tried:

ac97_quirks=3D-1 thru 3 =3D no effect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 subdude - 06-01-2004 07:19 CEST=20
----------------------------------------------------------------------
The motherboard is an ECS L7VMM2 uATX with onboard VIA VT8375 Northbridge
and VT8235 Southbridge chipset.

The CPU is an AMD XP2400+ with 512 MByte 266 DDRAM.

The AGP X4 socket has a nVidia 64 MByte MX-440 gpu.

The sound chip is identified as a VIA 8233/8235.

Sound is excellent at dxs_support=3D4.

The ONLY problem is the Headphone Volume is really the Master Volume.

How do I fix????

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:40 CEST=20
----------------------------------------------------------------------
Please show the output of lspci -nv (for the entry of VIA823x only).

About the HP output - I guess you mistyped:
it's ac97_quirk (without 's').
Try ac97_quirk=3D1 or ac97_quirk=3D2.

----------------------------------------------------------------------
 subdude - 07-10-2004 04:39 CEST=20
----------------------------------------------------------------------
Here is the output of 'lspci -nv' for 00:11.5 Multimedia audio controller=
:
VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50).

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1019:0a85
        Flags: medium devsel, IRQ 12
        I/O ports at e000 [size=3D256]
        Capabilities: [c0] Power Management version 2

What I meant by 'ac97_quirks=3D-1 thru 3' was I have tried the various
different combinations of 'ac97_quirk=3D-1' through to 'ac97_quirk=3D3', =
all
to no avail.

Here is my /etc/modules.conf for Slackware 10.0 custom kernel and alsa
driver 1.0.5a:

/ect/modules.conf
alias char-major-116 snd
alias snd-card-0 snd-via82xx

options snd-via82xx index=3D0 dxs_support=3D4
#options ac97_quirk=3D1
options ac97_quirk=3D2

alias char-major-14 soundcore
alias sound-slot-0 snd-card-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias char-major-195 nvidia
#

I look forward to hearing from you.

Best regards,

Brian

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-29-04 11:11 subdude        New Bug                                    =
 =20
05-29-04 11:11 subdude        Distribution              =3D> Slackware Cu=
rrent
05-29-04 11:11 subdude        Kernel Version            =3D> 2.4.26      =
   =20
05-29-04 11:12 subdude        Bug Monitored: subdude                     =
 =20
06-01-04 07:19 subdude        Bugnote Added: 0001288                     =
 =20
06-30-04 16:40 tiwai          Bugnote Added: 0001359                     =
 =20
07-10-04 04:39 subdude        Bugnote Added: 0001397                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
