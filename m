From: noreply@alsa-project.org
Subject: [ALSA - driver 0000373]: Sound in Quake 3 does not work
Date: Sun, 11 Jul 2004 00:04:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8e4de366e41d0ce00f927d544426d974@bugtrack.alsa-project.org>
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
0373
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                damage
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     373
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Suse Linux 9.1
Kernel Version:             2.6.5-7.95-default
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-09-2004 21:37 CEST
Last Modified:              07-11-2004 00:04 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Sound in Quake 3 does not work
Description:=20
I already tried several things to get sound working in Quake 3. It doesn'=
t=20
work. Sound in other applications, such as xmms, works without problems.
My System: SUSE Linux 9.1 Pro 64bit, MSI K8T Neo FIS2R, Athlon 64 3200,
1GB=20
RAM, VIA 8237 on board sound

I tried it with the ALSA version that comes with the Default Suse Kernel,
then=20
with version 1.05a and at the moment I've installed a version from CVS tw=
o

days ago. I loaded the alsa module with dxs_support 0 to 4, that didn't=20
resolve the issue.

Without changing anything in the ALSA configuration Quake 3 starts and th=
e

game runs without problems, but there is no sound. The following error=20
message is displayed when Quake 3 starts.
------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less=20
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

Enabling direct access to the OSS playback device and disabling the OSS=20
capture device with=20
echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "quake3.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss
I get sound in the Quake 3 menu, but as soon as I enter a map the game
hangs=20
and the only way to get back to X is to kill the process.

I also tried the user space ALSA OSS wrapper library. With this library I
only=20
get some crackling noises in the menu and in the game.

With xrun_debug 1 I get a few of the following messages (at least with th=
e

actually installed drivers from CVS) in the system log. These messages ar=
e

also there when I run other applications than Quake 3.
Jul  8 19:07:48 mordor kernel: ALSA sound/core/pcm_lib.c:199: Unexpected=20
hw_pointer value [1] (stream =3D 0, delta: -1024, max jitter =3D 8192): w=
rong=20
interrupt acknowledge?
Jul  8 19:07:48 mordor kernel: ALSA sound/pci/via82xx.c:731: invalid=20
via82xx_cur_ptr, using last valid pointer
Jul  8 19:08:00 mordor last message repeated 194 times

I don't know whether that has something to do with the problem.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 damage - 07-09-2004 21:46 CEST=20
----------------------------------------------------------------------
I did some minor corrections to the uploaded file and uploaded it a secon=
d
time, as the comments were wrong.

This bug seems to be related to the following bugs which are filed for
other sound cards:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0254
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0015

----------------------------------------------------------------------
 tokugawa - 07-11-2004 00:04 CEST=20
----------------------------------------------------------------------
"I get sound in the Quake 3 menu, but as soon as I enter a map the game
hangs
and the only way to get back to X is to kill the process."

Hi, the same here...  i'm going on vacation right now, so i can't help
much... but:

1) open the pk3 (like baseq3/pak0.pk3) files (these are zip)
2) move from them music dir to some other (so q3 will not found them)
3) run q3
4) tada!! qukae3 works, music hangs the game, without it game works
5) But there are no 'turn off music' in quake3 (music volume option don't
work... hangs are happen even if you turn down music completly in
options), so I just deleted music dirs from my pk3's. (just run zip -vd
pak0.pk3 'music/*' )

Heh... but you can't play online, because you have a hacked pk3 files...,
so we have to wait for a real fix

I'm hope that will help in bug hunting. If you can, please confirm that
behaviour.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-09-04 21:37 damage         New Bug                                    =
 =20
07-09-04 21:37 damage         File Added: alsa_q3_debug.txt              =
     =20
07-09-04 21:37 damage         Distribution              =3D> Suse Linux 9=
.1 =20
07-09-04 21:37 damage         Kernel Version            =3D> 2.6.5-7.95-d=
efault
07-09-04 21:41 damage         File Added: alsa_q3_debug.txt              =
     =20
07-09-04 21:46 damage         Bugnote Added: 0001396                     =
 =20
07-09-04 21:50 damage         Bug Monitored: damage                      =
 =20
07-11-04 00:04 tokugawa       Bugnote Added: 0001406                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
