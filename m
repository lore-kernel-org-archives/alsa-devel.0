From: noreply@alsa-project.org
Subject: [ALSA - driver 0000259]: Request additional features for ATIIXP
Date: Sun, 11 Jul 2004 18:40:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <e4f24405d02abbfb0b600bde3dae1ebf@bugtrack.alsa-project.org>
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
0259
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                netstar
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     259
Category:                   PCI - atiixp
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:              =20
Kernel Version:            =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-07-2004 01:48 CEST
Last Modified:              07-11-2004 18:40 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Request additional features for ATIIXP
Description:=20
Would it be possible to create an atiixpm driver similar to the intel mod=
em
driver?  I have an ATI Modem with device id 434d, which i assume is AC97.=
=20
I have spoken with the slmdm modem developer and he suggested I contacted
you.

My system is ATI infected, ATI controllers, sound card, video card and
unsupported modem.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 tiwai - 05-11-2004 18:29 CEST=20
----------------------------------------------------------------------
please try the attached patch.
you'll get a driver snd-atiixp-modem.

note that it's to the latest cvs version.

----------------------------------------------------------------------
 netstar - 05-12-2004 01:19 CEST=20
----------------------------------------------------------------------
Just a few questions here, are you expecting to unleash this in the next
stable release or do you want some test results?  Do you have an atiixp
ac97 modem there?  Is the standard method to use slmdmd's modem daemon in
alsa mode?  Any further information gratefully received, it seems that
someone just unlocked the key to a loada Toshiba laptops :) magic.

----------------------------------------------------------------------
 tiwai - 05-12-2004 11:29 CEST=20
----------------------------------------------------------------------
no, it's untested at all, and i have no ac97 modem.
whether it comes into the main tree depends on your tests.

it should work like intel8x0m, which talks ac97 modem codec.
but remember that the driver is totally untested and
might cause hang up.

----------------------------------------------------------------------
 netstar - 05-12-2004 16:46 CEST=20
----------------------------------------------------------------------
Tiwai, that patch failed on CVS.  Also, alsa would not configure properly
on 2.6 because of failed version.h.  Any ideas?  Perhaps I could modify
1.0.4 source manually?  I will continue to investigate until I hear more
from you.  Sorry about that.

----------------------------------------------------------------------
 tiwai - 05-12-2004 17:01 CEST=20
----------------------------------------------------------------------
no idea why you can't build alsa-driver with 2.6.  here works fine.

the second patch is another version.  it creates a new file instead
of patching the existing atiixp.c.  the patch should be applied to
the latest alsa-driver CVS version.  reverse the last patch.

after applying the patch, run ./cvscompile to regenerate configure
and Makefiles and to compile.

----------------------------------------------------------------------
 netstar - 05-12-2004 18:56 CEST=20
----------------------------------------------------------------------
Tiwai,

Sorted the kernel issue, the new patch worked fine on alsa-driver CVS.=20
Problem however when attempting to load into the kernel.  ALSACONF did no=
t
detect the modem automatically so I loaded the module manually.  Here is
my dmesg:

ATI IXP MC97 controller: probe of 0000:00:14.6 failed with error -13

----------------------------------------------------------------------
 tiwai - 05-12-2004 19:17 CEST=20
----------------------------------------------------------------------
alsaconf probes only for audio chips.  not a bug.

try the third attached patch (additional).
with this patch, you'll likely get another error messages even
if it still fails.

----------------------------------------------------------------------
 netstar - 05-13-2004 00:43 CEST=20
----------------------------------------------------------------------
The second patch was slightly broken but i adjusted it slightly to as
below, i assume that it is ok:

if (chip->codec_not_ready_bits){
/* codec(s) was detected but not available.
 * return the error
 */
 snd_printd("ac97_codec_new %d error %d\n", i,err);
 continue;
}
else { // blah blah

It compiled and the new error message is as follows.

ALSA /home/netstar/alsa/alsa-driver/pci/atiixp_modem.c:1101:=20
ac97_codec_new 0 error -13

----------------------------------------------------------------------
 netstar - 05-17-2004 04:22 CEST=20
----------------------------------------------------------------------
Gone quiet for a while.  The only debugging information  I could give is
that I posted earlier.

----------------------------------------------------------------------
 tiwai - 05-18-2004 21:32 CEST=20
----------------------------------------------------------------------
if you loaded snd-atiixp, don't load it to avoid any possible
conflictions.

then try the attached patch and check the kernel messages.

----------------------------------------------------------------------
 netstar - 05-19-2004 02:01 CEST=20
----------------------------------------------------------------------
Conditions were set as specified, here is the debugging information:

ALSA atiixp_modem.c:1086: codec_not_ready =3D 0x3000
ALSA atiixp_modem.c:1089: checking 0 [bit 400]<7>
ALSA atiixp_modem.c:1089: checking 1 [bit 800]<7>
ALSA atiixp_modem.c:1089: checking 2 [bit 1000]

----------------------------------------------------------------------
 tiwai - 05-19-2004 12:36 CEST=20
----------------------------------------------------------------------
try to comment out the line 1090:

	if (chip->codec_not_ready_bits & codec_skip[i])
		continue;

i guess the driver will be loaded without abort, but unlikely it will
work.  if the driver is loaded well, attach the outputs of
/proc/asound/card0/codec97#*/* files (they may be multiple
matching directories.)

----------------------------------------------------------------------
 netstar - 05-19-2004 16:06 CEST=20
----------------------------------------------------------------------
Module loads but with multiple repeats of these errors:

ALSA atiixp_modem.c:451: atiixp: codec read timeout (reg 1c)
ALSA atiixp_modem.c:451: atiixp: codec read timeout (reg 0)
ALSA atiixp_modem.c:451: atiixp: codec read timeout (reg 3c)

Debugging info in codec-info.tar.gz.

----------------------------------------------------------------------
 tiwai - 05-19-2004 18:41 CEST=20
----------------------------------------------------------------------
the file is empty.  (tar doesn't work well with proc files.)

----------------------------------------------------------------------
 tiwai - 05-25-2004 12:57 CEST=20
----------------------------------------------------------------------
try ALSA 1.0.5-rc1.

----------------------------------------------------------------------
 netstar - 05-25-2004 17:51 CEST=20
----------------------------------------------------------------------
The new module loads fine with no errors, but when I attempt to DIAL I ge=
t

"NO DIALTONE".  I am testing from the UK if that helps at all.

snd_atiixp_modem       16776  0
snd_ac97_codec         67972  1 snd_atiixp_modem
snd_pcm                86528  1 snd_atiixp_modem
snd_page_alloc         10888  2 snd_atiixp_modem,snd_pcm
snd_timer              23680  2 snd_seq,snd_pcm
snd                    51460  6 =20
snd_seq,snd_seq_device,snd_atiixp_modem,snd_ac97_codec,snd_pcm,snd_timer

----------------------------------------------------------------------
 netstar - 05-25-2004 23:56 CEST=20
----------------------------------------------------------------------
Additional info:

It appears the modem INIT strings from the windows driver are as follows:

AT
AT &F S0=3D0 E0 V1 S95=3D0 &D2

Receive an ERROR when attempting to use this and NO DIALTONE with other
init combinations.

----------------------------------------------------------------------
 tiwai - 05-26-2004 14:44 CEST=20
----------------------------------------------------------------------
check /proc/asound/card0/codec97#0/* files whether the modem codec
is chosen by snd-atiixp-modem driver.

i have no big idea about the modem codec.  it'd be better to
ask Sasha Khapyorsky <sashak@smlink.com> about the further
debugging...

----------------------------------------------------------------------
 tiwai - 05-28-2004 16:59 CEST=20
----------------------------------------------------------------------
i fixed a bit.  could you try 1.0.5-final?

----------------------------------------------------------------------
 netstar - 05-28-2004 18:49 CEST=20
----------------------------------------------------------------------
Tried the new release, more modem commands are available but still no
DIALTONE.
I have been in contact with Sasha, as suggested, and sent him some more
debugging information, he informed me that the modem driver still needs
some work.  He will work on it next week with datasheet and possibly some
hardware.  Getting there :)

----------------------------------------------------------------------
 sashak - 07-07-2004 18:28 CEST=20
----------------------------------------------------------------------
There is patch for atiixp_modem.c . The driver is able to setup HOOK OFF/=
ON
(GPIO is changed via ATI_REG_MODEM_OUT_GPIO) and line level.

edited on: 07-07-04 18:28

----------------------------------------------------------------------
 sashak - 07-11-2004 18:40 CEST=20
----------------------------------------------------------------------
There is updated patch atiixp_modem.c.patch2. Min/Max channels is "2" now=
,
this provides possibility to "route" right pcm channel (this consists
valid data) to modem input/output, so this looks like 'convensional' mode=
m
device. .asoundrc example is attahched - asoundrc-atiixp_modem.

Such combination of driver and .asoundrc works (aplay, arecord,
slmodem-2.9.9).

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-07-04 01:48 netstar        New Bug                                    =
 =20
05-11-04 18:29 tiwai          Bugnote Added: 0001087                     =
 =20
05-11-04 18:30 tiwai          File Added: atiixp-modem.dif               =
    =20
05-12-04 01:19 netstar        Bugnote Added: 0001088                     =
 =20
05-12-04 11:29 tiwai          Bugnote Added: 0001090                     =
 =20
05-12-04 16:46 netstar        Bugnote Added: 0001092                     =
 =20
05-12-04 17:01 tiwai          Bugnote Added: 0001093                     =
 =20
05-12-04 17:01 tiwai          File Added: atiixp-modem2.dif              =
     =20
05-12-04 18:56 netstar        Bugnote Added: 0001094                     =
 =20
05-12-04 19:17 tiwai          Bugnote Added: 0001097                     =
 =20
05-12-04 19:17 tiwai          File Added: atiixp-modem-debug.dif         =
      =20
  =20
05-13-04 00:43 netstar        Bugnote Added: 0001100                     =
 =20
05-17-04 04:22 netstar        Bugnote Added: 0001127                     =
 =20
05-18-04 21:32 tiwai          Bugnote Added: 0001148                     =
 =20
05-18-04 21:33 tiwai          File Added: atiixp-modem-debug2.dif        =
      =20
   =20
05-19-04 02:01 netstar        Bugnote Added: 0001149                     =
 =20
05-19-04 12:36 tiwai          Bugnote Added: 0001150                     =
 =20
05-19-04 16:06 netstar        Bugnote Added: 0001153                     =
 =20
05-19-04 16:07 netstar        File Added: codec-info.tar.gz              =
     =20
05-19-04 18:41 tiwai          Bugnote Added: 0001154                     =
 =20
05-19-04 22:13 netstar        File Added: proc_entries.txt               =
    =20
05-25-04 12:57 tiwai          Bugnote Added: 0001207                     =
 =20
05-25-04 17:51 netstar        Bugnote Added: 0001222                     =
 =20
05-25-04 23:56 netstar        Bugnote Added: 0001240                     =
 =20
05-26-04 14:44 tiwai          Bugnote Added: 0001259                     =
 =20
05-28-04 16:59 tiwai          Bugnote Added: 0001265                     =
 =20
05-28-04 18:49 netstar        Bugnote Added: 0001270                     =
 =20
06-15-04 05:25 mrjackbrooks   Bug Monitored: mrjackbrooks                =
   =20
07-07-04 18:06 sashak         Bug Monitored: sashak                      =
 =20
07-07-04 18:09 sashak         File Added: atiixp_modem.c.patch           =
      =20
=20
07-07-04 18:11 sashak         Bugnote Added: 0001393                     =
 =20
07-07-04 18:28 sashak         Bugnote Edited: 0001393                    =
 =20
07-11-04 18:31 sashak         File Added: atiixp_modem.c.patch2          =
      =20
 =20
07-11-04 18:32 sashak         File Added: asoundrc-atiixp_modem          =
      =20
 =20
07-11-04 18:40 sashak         Bugnote Added: 0001408                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
