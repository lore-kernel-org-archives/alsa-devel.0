From: noreply@alsa-project.org
Subject: [ALSA - driver 0000130]: Realtek ALC202 rev 0: hanging playback on plughw:0,4
Date: Thu, 1 Jul 2004 17:00:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ab2d4799148ccf91eac913dca9c20b00@bugtrack.alsa-project.org>
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
0130
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Csan
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     130
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux sid
Kernel Version:             2.6.3-1-686
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             03-13-2004 07:32 CET
Last Modified:              07-01-2004 17:00 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    Realtek ALC202 rev 0: hanging playback on plu=
ghw:0,4
Description:=20
while 'aplay -D plughw:0,0 test.wav' works, when I try to use the other
playback device playback hangs

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Csan - 03-13-2004 07:43 CET=20
----------------------------------------------------------------------
from lspci -vvv:

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio
Controller (rev 02)
	Subsystem: COMPAL Electronics Inc: Unknown device 0017
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 1c00 [size=3D256]
	Region 1: I/O ports at 18c0 [size=3D64]
	Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=3D512]
	Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

# cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 at 0xd0000c00, irq 17

----------------------------------------------------------------------
 Csan - 03-13-2004 07:48 CET=20
----------------------------------------------------------------------
I tried ac97_quirk with both 0 and 1 values but with no improvement.

----------------------------------------------------------------------
 perex - 03-13-2004 17:49 CET=20
----------------------------------------------------------------------
It's request for the feature rather a bug report (changed now).

Unfortunately, ICH4 and AC97 codec is not properly initialized, so the
S/PDIF
PCM does not work. I just added s/pdif definitions to driver, but code is
missing (initialization/locking of SPSA bits in AC97 and initialization o=
f
ICH4 to use proper AC97 slots).

----------------------------------------------------------------------
 Csan - 05-18-2004 16:47 CEST=20
----------------------------------------------------------------------
Hi

Any chances for this feature to be implemented?
(For the driver to be properly initialized?)

I'm still very sad that I can't have it working on this laptop... :(

What pieces of information are needed for an ALSA developer to implement
it? I'm here and ready to give them.

Thanks a lot. :)

----------------------------------------------------------------------
 tiwai - 05-25-2004 15:09 CEST=20
----------------------------------------------------------------------
doesn't "aplay -Dspdif foo.wav" work?
anyway try the latest ALSA 1.0.5 (don't forget to update both driver
and library).

----------------------------------------------------------------------
 Csan - 07-01-2004 17:00 CEST=20
----------------------------------------------------------------------
Yes it does work:

# aplay -Dspdif foo.wav
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

as also does:

# aplay -D plughw:0,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo

but plughw:0,4 hangs (also in xmms - xmms doesn't list 'spdif'):

# aplay -D plughw:0,4 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
Aborted by signal Interrupt...

# cat /proc/asound/version=20
Advanced Linux Sound Architecture Driver Version 1.0.5a.
Compiled on Jun 22 2004 for kernel 2.6.6-2-686.
csanote:~# alsactl --version
alsactl version 1.0.5

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
03-13-04 07:32 Csan           New Bug                                    =
 =20
03-13-04 07:32 Csan           Distribution              =3D> Debian GNU/L=
inux sid
03-13-04 07:32 Csan           Kernel Version            =3D> 2.6.3-1-686 =
   =20
03-13-04 07:43 Csan           Bugnote Added: 0000590                     =
 =20
03-13-04 07:48 Csan           Bugnote Added: 0000591                     =
 =20
03-13-04 17:47 perex          Severity                 major =3D> feature=
   =20
03-13-04 17:49 perex          Bugnote Added: 0000595                     =
 =20
05-18-04 16:47 Csan           Bugnote Added: 0001142                     =
 =20
05-25-04 15:09 tiwai          Bugnote Added: 0001214                     =
 =20
07-01-04 17:00 Csan           Bugnote Added: 0001372                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
