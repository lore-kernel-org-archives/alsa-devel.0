From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: HDSPM - Problems with SyncIn
Date: Sat, 25 Jun 2011 15:56:32 +0200
Message-ID: <20110625155632.4876f6e6@revell.mafea.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AFFD2436D
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Jun 2011 15:56:37 +0200 (CEST)
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Robert Steffens <robert.steffens@iosono-sound.com>, Andreas Graefe <andreas.graefe@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org


Hello,

I did some tests with the SyncIn-Feature of the HDSPe cards.


[root@localhost ~]# lspci |grep Mult
01:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP MADI (rev d2)
02:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP MADI (rev d2)


The SyncOut of card 2:00 was plugged to the SyncIn of 1:00 and 1:00 was
put to AutoSync-mode automatically upon boot. Problem is that the amixer
output seems to be inconsistent and differs from the proc output as
well, so I'm not sure which one to trust.


[root@localhost ~]# amixer -c0 contents
numid=5,iface=MIXER,name='AutoSync Reference'
  ; type=ENUMERATED,access=r-------,values=1,items=5
  ; Item #0 'Word Clock'
  ; Item #1 'MADI'
  ; Item #2 'TCO'
  ; Item #3 'Sync In'
  ; Item #4 'None'
  : values=3
numid=2,iface=MIXER,name='Internal Clock'
  ; type=ENUMERATED,access=rw------,values=1,items=9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=2
numid=4,iface=MIXER,name='Preferred Sync Reference'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Word Clock'
  ; Item #1 'MADI'
  ; Item #2 'Sync In'
  : values=2
numid=10,iface=MIXER,name='SYNC IN SyncCheck'
  ; type=ENUMERATED,access=r-------,values=1,items=4
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  ; Item #3 'N/A'
  : values=0
numid=3,iface=MIXER,name='System Clock Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=1
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=47999



'Preferred Sync Reference' is SyncIn, 'SYNC IN SyncCheck' says 'No
Lock', meaning no signal at all, but the 'System Sample Rate' coming
from the master card is detected with 1Hz offset. When putting the
master to 32000Hz, 31999Hz are shown and so on.


[root@localhost ~]# cat /proc/asound/card0/hdspm
RME MADI (Card #1) Rev.d2 Status2first3bits: 1
HW Serial: 0x0000019196d4
IRQ: 16 Registers bus: 0xfe9f0000 VM: 0xf8920000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x0, In2=0x0
MIDIoverMADI FIFO: In=0x0, Out=0x0
Register: ctrl1=0x10344ca, ctrl2=0x0, status1=0xc30004,
status2=0xc0020361
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on
ClearTrackMarker = off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: AutoSync
Preferred Sync Reference: TCO
System Clock Frequency: 48000
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Sync In, Freq=0 (MADI = 3, Word = 3)
Input: Coax, Mode=56 channels


Now the proc-output reports 'No TCO module detected', which is correct,
as no expansion modules where plugged to the cards. But it also says 
'Preferred Sync Reference: TCO' and 'Freq=0', where amixer said SyncIn
and 47999? Output of the master card is below.


Regards,
   Andre


[root@localhost ~]# amixer -c1 contents
numid=5,iface=MIXER,name='AutoSync Reference'
  ; type=ENUMERATED,access=r-------,values=1,items=5
  ; Item #0 'Word Clock'
  ; Item #1 'MADI'
  ; Item #2 'TCO'
  ; Item #3 'Sync In'
  ; Item #4 'None'
  : values=4
numid=15,iface=MIXER,name='Input Select'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'optical'
  ; Item #1 'coaxial'
  : values=0
numid=2,iface=MIXER,name='Internal Clock'
  ; type=ENUMERATED,access=rw------,values=1,items=9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=2
numid=4,iface=MIXER,name='Preferred Sync Reference'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Word Clock'
  ; Item #1 'MADI'
  ; Item #2 'Sync In'
  : values=0
numid=10,iface=MIXER,name='SYNC IN SyncCheck'
  ; type=ENUMERATED,access=r-------,values=1,items=4
  ; Item #0 'No Lock'
  ; Item #1 'Lock'
  ; Item #2 'Sync'
  ; Item #3 'N/A'
  : values=0
numid=3,iface=MIXER,name='System Clock Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=0
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=48000




[root@localhost ~]# cat /proc/asound/card1/hdspm
RME MADI (Card #2) Rev.d2 Status2first3bits: 1
HW Serial: 0x000001b1c606
IRQ: 17 Registers bus: 0xfeaf0000 VM: 0xf9280000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x0, In2=0x0
MIDIoverMADI FIFO: In=0x0, Out=0x0
Register: ctrl1=0x10004da, ctrl2=0x0, status1=0x2800000,
status2=0xc0020701
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
AutoSync: Reference= Input not valid, Freq=0 (MADI = 10, Word = 0)
Input: Optical, Mode=56 channels
