From: Gert Vervoort <gert.vervoort@hccnet.nl>
Subject: rear L/R and center/LFE switched with GA-K8VT800 motherboard
Date: Sun, 30 May 2004 19:17:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40BA171B.9060305@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Anybody anny experience with GA-K8VT800 AMD64 motherboard and 5.1 output?

When running the speaker test program on Gigabyte GA-K8VT800, the rear 
L/R and center/LFE channels are switched. The rear L/R and center/LFE 
connectors are connected on a seperate bracket (Gigabyte Surround-Kit) 
and thus not on the mic/line in connectors. According to the surround 
test tool in Windows XP, the speakers are connected correctly.

I'm using the ALSA version included in Linux kernel 2.6.6

It uses a VIA VT8237 south bridge:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Giga-byte Technology GA-7VAX Onboard Audio (Realtek ALC650)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at bc00
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


And a ALC658 AC97 codec:

[root@apollo codec97#0]# more /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC658 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
[root@apollo codec97#0]#


Gert


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
