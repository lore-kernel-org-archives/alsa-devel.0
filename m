From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: HDSPM: Wrong samplerate on PCI cards
Date: Wed, 18 Apr 2012 16:59:13 +0200
Message-ID: <20120418165913.1986107a@desk27.iosono.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 273032414A
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 17:04:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Andreas Graefe <andreas.graefe@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org


Hi,

we're having issues obtaining the correct system sample rate from PCI
cards, while it works correctly for PCIe cards.
I tested with stock ALSA-driver 1.0.{24,25} as well as latest
Repo-Version via alsa-compile.sh on 64b-Kernel 3.0.9-RT25.

I added some printks, the culprit seems to be:

hdspm.c:1988:   period = hdspm_read(hdspm, HDSPM_RD_PLL_FREQ);


Output for PCIe card:

kernel: ALSA sound/pci/rme9652/hdspm.c:1379 HDSPM:
hdspm_calc_dds_value: freq_const=110069313433624, period=2293110696,
freq_const/period=48000


Output for PCI card:

kernel: ALSA sound/pci/rme9652/hdspm.c:1379 HDSPM:
hdspm_calc_dds_value: freq_const=110069313433624, period=41943044,
freq_const/period=2624256


I tested with 3 different PCI cards (latest firmware) and the same
card(s) works as expected on 32b-Kernel 2.6.24.7 with ALSA 1.0.16.
The card's registers look exactly the same when applying the same card
settings via amixer.

Starting JACKd works on both cards and audio output is fine.

Within the driver, I don't see a different code path for PCI and
PCIe, so this seems weird. I took a look at the Mac driver as well, it
defines	RD_PLL_FREQ as 4*128, so this should be ok?

Can anybody confirm this? And any ideas, what's going on here?

I noticed a mismatch between "struct hdspm" (int system_sample_rate)
and "struct hdspm_config" (unsigned int system_sample_rate), but this
doesn't seem to be an issue?
And the proc-output for the samplerate is wrong/misleading as it isn't
read directly from the card as opposed to the RayDat-Code. Is there any
reason for this?

Detailed output below (card 0 is PCIe, card 1 is PCI).
Note: amixer is 64b as well, so the 32b compat stuff shouldn't matter.


Cheers,
  Andre


# cat /proc/asound/cards 
 0 [HDSPMx1c9359   ]: HDSPM - RME MADI_1c9359
                      RME MADI S/N 0x1c9359 at 0xfe900000, irq 17
 1 [Default        ]: HDSPM - RME MADI_ffffff
                      RME MADI S/N 0xffffff at 0xfeb00000, irq 17


# amixer -c0 cget numid=6
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=48000


# amixer -c1 cget numid=6
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=2624256


# cat /proc/asound/card0/hdspm 
RME MADI (Card #1) Rev.d2 Status2first3bits: 1
HW Serial: 0x0000011c9359
IRQ: 17 Registers bus: 0xfe900000 VM: 0xffffc900114e0000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x80, In2=0x80 
MIDIoverMADI FIFO: In=0x0, Out=0x0 
Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x4, status2=0xc0020701
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on 
ClearTrackMarker = off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Input not valid, Freq=0 (MADI = 0, Word = 0)
Input: Coax, Mode=56 channels


# cat /proc/asound/card1/hdspm 
RME MADI (Card #2) Rev.cf Status2first3bits: 1
HW Serial: 0xffffffffffff
IRQ: 17 Registers bus: 0xfeb00000 VM: 0xffffc90011420000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x0, In2=0x0 
MIDIoverMADI FIFO: In=0x0, Out=0x0 
Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x1000004,
status2=0xffff0701 No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on 
ClearTrackMarker = off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Input not valid, Freq=0 (MADI = 4, Word = 0)
Input: Coax, Mode=56 channels


# cat /proc/asound/card0/debug
0x00000000: 00000004 00000004 00000004 00000004
0x00000010: 00000004 00000004 00000004 00000004
0x00000020: 00000004 00000004 00000004 00000004
0x00000030: 00000004 00000004 00000004 00000004
0x00000040: 00000004 00000004 00000004 00000004
0x00000050: 00000004 00000004 00000004 00000004
0x00000060: 00000004 00000004 00000004 00000004
0x00000070: 00000004 00000004 00000004 00000004
0x00000080: 00000004 00000004 00000004 00000004
0x00000090: 00000004 00000004 00000004 00000004
0x000000A0: 00000004 00000004 00000004 00000004
0x000000B0: 00000004 00000004 00000004 00000004
0x000000C0: C0020701 C0020701 C0020701 C0020701
0x000000D0: C0020701 C0020701 C0020701 C0020701
0x000000E0: C0020701 C0020701 C0020701 C0020701
0x000000F0: C0020701 C0020701 C0020701 C0020701


# cat /proc/asound/card1/debug
0x00000000: 02800004 02800004 02800004 02800004
0x00000010: 02800004 02800004 02800004 02800004
0x00000020: 02800004 02800004 02800004 02800004
0x00000030: 02800004 02800004 02800004 02800004
0x00000040: 02800004 02800004 02800004 02800004
0x00000050: 02800004 02800004 02800004 02800004
0x00000060: 02800004 02800004 02800004 02800004
0x00000070: 02800004 02800004 02800004 02800004
0x00000080: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
0x00000090: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
0x000000A0: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
0x000000B0: FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF
0x000000C0: FFFF0701 FFFF0701 FFFF0701 FFFF0701
0x000000D0: FFFF0701 FFFF0701 FFFF0701 FFFF0701
0x000000E0: FFFF0701 FFFF0701 FFFF0701 FFFF0701
0x000000F0: FFFF0701 FFFF0701 FFFF0701 FFFF0701
