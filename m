From: Frank Lauterwald <frank_lauterwald@web.de>
Subject: Bug in via82xx (or rather in the hardware)
Date: Fri, 20 Jun 2003 19:55:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306201955.11358.frank_lauterwald@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

there seem to be quite some buggy via8233-chipsets around (they are handl=
ed by=20
the via82xx-driver). I'd propse a workaround in the drivers.


Problem description:
=09The sound in most applications is so noisy that you can hardly hear th=
e=20
music.=09This problem applies to all alsa versions I have tested (some ha=
ve=20
noise on one channel only). The only distribution on which I got sound=20
working was SuSE 8.1 (with a  2.4.19-Kernel patched by them). However I h=
ave=20
not looked at what changes they made to the alsa code. The noise seems to=
 be=20
played about every time the soundcard's buffer is refreshed (more exactly=
:=20
playing noise seems to be tied to the chip's interrupts (one snippet of w=
hite=20
noise or one click or whatever is played every time the interrupt handler=
 is=20
called)). This is however just an impression and may be wrong.

Possible cause:
=09As far as I can tell, the 8233-chip (at least the one in my notebook) =
or some=20
other chip involved does not properly support sample-rates other than 480=
00.=20
While most sample rates do work, some don't (e.g. 44.1 kHz which most app=
s=20
try to use)
Some other people suggest things like forcing apps to use 48kHz (see e.g.=
=20
http://www.alsa-project.org/alsa-doc/doc-php/template.php3?company=3DVIA&=
card=3D&chip=3Dvia8235&module=3Dvia82xx)=20
too. This actually works and leaves the impression that the card should b=
e=20
forced to 48k whenever possible.
Another theory suggests to look at the pcm buffer stuff (because noise se=
ems=20
to be tied to hardware interrupts). Maybe the interrupt to change buffers=
 is=20
triggered at the wrong moment. Have not investigated this and does not se=
em=20
too probable to me.

Suggestion:
=09The problem can be solved by forcing the chip to always play at 48 kHz=
=2E I'm=20
not familiar with the code so I do not know where the best place to chang=
e it=20
would be, One possibility, however, is to add the following line to=20
sound/pci/via82xx.c in method snd_via82xx_mixer_new around line 1485 (for=
 the=20
alsa version shipped with linux kernel 2.5.69):

=09if (chip->chip_type !=3D TYPE_VIA686) {
=09=09/* use slot 10/11 */
=09=09snd_ac97_update_bits(chip->ac97, AC97_EXTENDED_STATUS, 0x03 << 4, 0=
x03 <<4);
=09        // BEGIN OF ADDED CODE
=09=09// clear the bit that allows sampling rates other than 48000
=09=09if (chip->chip_type !=3D TYPE_VIA8233) {
=09=09=09snd_ac97_update_bits(chip->ac97, AC97_EXTENDED_STATUS, AC97_EA_V=
RA , 0x00);
=09=09}
=09        // END OF ADDED CODE
=09}

If there are objections or if most 8233-chips work correctly, this could =
be=20
#ifdef'ed with some kind of CONFIG_WORKAROUND_BUGGY8233 option or the lik=
e.

Although this code snippet does not add any regressions for me, it is  cl=
ear=20
that it is just a workaround. I'd of course be happy if someone found a=20
"real" solution.

If there are any questions, I'll be happy to provide more information

Cheers,
=09Frank


---- appendix: output of lspci -nvv for the device in question
00:11.5 Class 0401: 1106:3059 (rev 30)
        Subsystem: 14ff:0403
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 1000 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
