From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: Re: [alsa-cvslog] CVS: AFTER REVERT  [FAILURE]
  C-Media CMI9761 -A- type, TESTING 01
Date: Thu, 17 Feb 2005 01:06:51 +0100
Message-ID: <4213E01B.8050505@gmx.de>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net> <4213BB44.5060702@gmx.de> <4213C289.7030500@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4213C289.7030500@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

b) now tried head revisions:

results:
-pcm failure. only lines are looped through and regulateable.
-no more master vol slider and no pcm vol slider in kmix.

suggest rollback -1.

i'll give it a try tonight, rollback and adding missing pcm vol slider.

pls verify (more info needed?)(MB asrock K7VT4A+ REV.1.01(?)):

schorpp@tom1:/usr/src/alsa/alsa-kernel/pci/ac97$ cvs status | grep revision
cvs status: Examining .
    Working revision:    1.15
    Repository revision: 1.15 
/cvsroot/alsa/alsa-kernel/pci/ac97/Makefile,v
    Working revision:    1.172
    Repository revision: 1.172 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
    Working revision:    1.10
    Repository revision: 1.10 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_id.h,v
    Working revision:    1.12
    Repository revision: 1.12 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_local.h,v
    Working revision:    1.74
    Repository revision: 1.74 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
    Working revision:    1.19
    Repository revision: 1.19 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
    Working revision:    1.20
    Repository revision: 1.20 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_pcm.c,v
    Working revision:    1.13
    Repository revision: 1.13 
/cvsroot/alsa/alsa-kernel/pci/ac97/ac97_proc.c,v
    Working revision:    1.15
    Repository revision: 1.15 
/cvsroot/alsa/alsa-kernel/pci/ac97/ak4531_codec.c,v
schorpp@tom1:/usr/src/alsa/alsa-kernel/pci/ac97$

tom1:~# cat /proc/asound/card0/codec97#0/*
0-0/0: C-Media Electronics CMI9761

Revision         : 0x01
Compat. Class    : 0x03
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
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
Double rate slots: 10/11
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 DRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF
0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 801e
0:0c = 0000
0:0e = 9f1f
0:10 = 9f1f
0:12 = 1717
0:14 = 0000
0:16 = 1b1b
0:18 = 0808
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0bc2
0:2a = 05f4
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 2a20
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0004
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 3038
0:66 = 0012
0:68 = 0000
0:6a = 0000
0:6c = 0209
0:6e = 0000
0:70 = 0100
0:72 = 0000
0:74 = c000
0:76 = 4e56
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4983
tom1:~#
tom1:~#


0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
         Subsystem: Unknown device 1849:9761
         Flags: medium devsel, IRQ 185
         I/O ports at cc00 [size=256]
         Capabilities: [c0] Power Management version 2


0000:00:11.5 0401: 1106:3059 (rev 50)
         Subsystem: 1849:9761
         Flags: medium devsel, IRQ 185
         I/O ports at cc00 [size=256]
         Capabilities: [c0] Power Management version 2



pci bus 0x0000 cardnum 0x11 function 0x05: vendor 0x1106 device 0x3059
  VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
  CardVendor 0x1849 card 0x9761 (Card unknown)
   STATUS    0x0210  COMMAND 0x0001
   CLASS     0x04 0x01 0x00  REVISION 0x50
   BIST      0x00  HEADER 0x00  LATENCY 0x00  CACHE 0x00
   BASE0     0x0000cc01  addr 0x0000cc00  I/O
   MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x03  INT_LINE 0x09
   BYTE_0    0x01  BYTE_1  0xcd  BYTE_2  0x00  BYTE_3  0x00


tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
