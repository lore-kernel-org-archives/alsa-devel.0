From: p z oooo <pzad@pobox.sk>
Subject: Re: Need to know SBLive Chip difference
Date: Thu, 1 Apr 2004 11:02:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404010902.i3192K16003743@www6.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guanyim@hotmail.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

on this chip is philips logo ??? I think yes.
A1334

this is Philips UDA1334 2 channel DAC user for rear channel. On 2003=20
this is missing,=20
then rear channels must go out throught other chip (I think through=20
AC97).

Last try,

Change this in alsa-driver/alsa-kernel/pci/emu10k1/emufx.c

if (emu->fx8010.extout_mask & ((1<<EXTOUT_REAR_L)|
(1<<EXTOUT_REAR_R)))

=09for (z =3D 0; z < 2; z++)
=09=09OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);

to

if (emu->fx8010.extout_mask & ((1<<EXTOUT_REAR_L)|
(1<<EXTOUT_REAR_R)))
=09for (z =3D 0; z < 2; z++) {
=09=09OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_REAR_L + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0xd + z), GPR(playback=20
+ SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0xf + z), GPR(playback=20
+ SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000, C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x13 + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x15 + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x17 + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x19 + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x1b + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09=09OP(icode, &ptr, iACC3, EXTOUT(0x1d + z), GPR
(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 2 + z), C_00000000,=20
C_00000000);
=09}

and

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Warning, I don't know if this will harm the hardware or not, try at=20
your own risk.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

There is one register, where center/lfe is enabled for AC97 and SB=20
Live for 5.1 SB Live.
in alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c

is

/* 5.1: Enable the additional AC97 Slots. If the emu10k1 version
   does not support this, it shouldn't do any harm */
   snd_emu10k1_ptr_write(emu, AC97SLOT, 0,=20
AC97SLOT_CNTR|AC97SLOT_LFE);=20

try play with bits in this register for example

snd_emu10k1_ptr_write(emu, AC97SLOT, 0,=20
AC97SLOT_CNTR|AC97SLOT_LFE|0x48);

sets bit 4 and 7.
try other bits too.

I send question to creative oss/free emu10k1 driver devel mail list=20
with description of this problem, no response so far.
More I can't do for you, sorry.

Peter Zubaj



=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
