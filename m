From: noreply@alsa-project.org
Subject: [ALSA - driver 0000337]: "alsactl restore" always fails
Date: Fri, 2 Jul 2004 07:12:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8026c4f0c49eba6c2de3301f982eac31@bugtrack.alsa-project.org>
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
0337
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                kuulasma
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     337
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian sarge
Kernel Version:             Linux 2.6.6-1-686
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             06-16-2004 22:04 CEST
Last Modified:              07-02-2004 07:12 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    "alsactl restore" always fails
Description:=20
Dell Latitude CPt with an NM256ZX fails always to restore previously save=
d
state. Command "alsactl store" succesfully stores current state but
"alsactl restore" always fails to restore previous state. The OSS driver
works fine.

Example:
----------------------------------------------------------
# alsactl restore
alsactl: set_control:966: Cannot write control '2:0:0:CD Playback
Switch:0' : Invalid argument
----------------------------------------------------------
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 tiwai - 06-22-2004 18:51 CEST=20
----------------------------------------------------------------------
Can you toggle CD mute on alsamixer, or like 'amixer set CD mute'?

----------------------------------------------------------------------
 kuulasma - 06-22-2004 21:35 CEST=20
----------------------------------------------------------------------
I tried to toggle CD mute but new setting are not stored. If I try to mut=
e
CD or change volyme, new settings are ignored. alsamixer doesn't save CD
volyme and mute state. Other controls work just like I expect them to
work. Once I open alsamixer CD settings are as follows: volyme 100 and
unmuted.

If I edit /var/lib/alsa/asound.state file manually and remove sections
control.14 and control.15, I can issue command 'alsactl restore'
succesfully (without error message). But once I store settings ('alsactl
store'), illegal control.14 and control.15 are stored in asound.state
file.=20

Just in case you need following information:

# lsmod | grep snd
snd_nm256              69188  1=20
snd_ac97_codec         65188  1 snd_nm256
snd_pcm_oss            54436  0=20
snd_mixer_oss          20096  2 snd_pcm_oss
snd_pcm                98148  2 snd_nm256,snd_pcm_oss
snd_page_alloc         11460  1 snd_pcm
snd_timer              25380  1 snd_pcm
snd                    54692  6
snd_nm256,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10336  2 snd

----------------------------------------------------------------------
 tiwai - 06-30-2004 16:29 CEST=20
----------------------------------------------------------------------
The attached patch will allow the access to the CD mute/volume.
Please give a try.

----------------------------------------------------------------------
 kuulasma - 07-02-2004 07:12 CEST=20
----------------------------------------------------------------------
YES!

I patched the kernel (2.6.6) and compiled. After boot new kernel with
nm256-cd.diff worked. Thank you!

When will the patch land in official kernel source repository?

Regards

Teemu

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
06-16-04 22:04 kuulasma       New Bug                                    =
 =20
06-16-04 22:04 kuulasma       Distribution              =3D> Debian sarge=
   =20
06-16-04 22:04 kuulasma       Kernel Version            =3D> Linux 2.6.6-=
1-686
06-17-04 14:12 kuulasma       Bug Monitored: kuulasma                    =
 =20
06-22-04 18:51 tiwai          Bugnote Added: 0001333                     =
 =20
06-22-04 21:35 kuulasma       Bugnote Added: 0001334                     =
 =20
06-30-04 16:29 tiwai          Bugnote Added: 0001355                     =
 =20
06-30-04 16:30 tiwai          File Added: nm256-cd.dif                   =
 =20
07-02-04 07:12 kuulasma       Bugnote Added: 0001373                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
