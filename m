From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 14:23:15 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724212315.GK1681@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3F0710.1060307@cucumelo.org>; from gorm@cucumelo.org on Wed, Jul 24, 2002 at 12:59:12 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2002.07.24 12:59 Benny Sjostrand wrote:
> The "IEC958" controll is probably there course my incorrect changes in 
> ac97_codec.c that should not
> be there. The "ICE 958 output" control is the one from cs46xx_lib.c.
> Then how does the /proc/asound/card0/dsp_sample looks like when you
> playing a .WAV file ?
> 
> If your IEC958 is optical and you see a red light it's a good sign.

    The IEC958 control is supposed to be there because of the CS4297A 
codec.
Your changes only involved the CS4297.
    My IEC958 is coaxial, and I'm using a set of Cambridge SoundWorks
DTT2500 Digital speakers. I don't know of any other way to check if the
card is sending a signal or not.
    I've attached a few files that may help. I just noticed some module
errors that may be the cause of my problems.

messages.txt:  /var/log/messages after insmodding my module


-- Peter Heatwole
"Murphy was just a well known pessimist."


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dsp_parameter


nullSCB:
0000 00000000 00000000 00000000 00000000 
0004 00000000 00000000 00000000 00000000 
0008 00000000 00000000 00000169 00000000 
000C FE980000 00000000 00000000 00000000 

TimingMasterSCBInst:
0010 00000000 00000000 00000000 00000000 
0014 00000000 00000000 00000000 00000000 
0018 00000000 00200000 00008010 00000000 
001C 00090001 80000001 00000001 00060000 

CodecOutSCB:
0020 00000000 00000000 00000000 00000000 
0024 00000000 00000000 00000000 00000000 
0028 00000000 00900080 00000179 00000000 
002C 00000000 00000010 00800000 00900000 

PCMreaderSCB:
0030 F2C0400F 00000200 07B84900 00010600 
0034 00000000 00000000 00000000 00000000 
0038 00000000 00000000 00000169 330300C2 
003C 06200000 00000000 80008000 80008000 

WriteBackSCB:
0040 3FC0000F 00000301 00010400 00000000 
0044 00000000 00000000 00000000 00000000 
0048 00000000 00B00000 00D0806D 330480C3 
004C 04800000 00000003 00800003 0000FFFF 
0050 00000000 00000000 00000000 00000000 
0054 00000000 00000000 00000000 00000000 
0058 00000000 00000000 00000000 00000000 
005C 00000000 00000000 00000000 00000000 
0060 00000000 00000000 00000000 00000000 
0064 00000000 00000000 00000000 00000000 
0068 00000000 00000000 00000000 00000000 
006C 00000000 00000000 00000000 00000000 

SPOSCB:
0070 066A0BA0 06350070 00000BAD 0BAD0BAD 
0074 00000000 0000DEAD 00000600 00000000 
0078 0000DEAD 00000000 00010000 DEADDEAD 
007C 0BAD0BAD 0BAD0BAD 0BAD0BAD 00000000 

CodecInSCB:
0080 00000000 00000000 00000000 00000000 
0084 00000000 00000000 00000000 00000000 
0088 00000000 00000130 0000804F 000000C3 
008C 05780000 00A00010 00000000 80008000 

MasterMixSCB:
0090 00000000 00000000 00001478 00000000 
0094 00000000 00000000 00000000 00000000 
0098 00000080 00A00000 0000809A 000000C3 
009C 14F80000 00000000 80008000 80007FFF 

SRCtaskSCBInst:
00A0 0029001B 00015555 000000C0 000107B8 
00A4 00C80028 000000C2 06A00000 01FFFFCC 
00A8 06840080 00300000 000080BB 000000C9 
00AC 07B80000 03ACCCCC 80008000 80007FFF 

VariDecimateSCB:
00B0 00C80028 00005555 00000000 00000780 
00B4 00C80028 000000C5 FFEAAAAB 00000000 
00B8 02400080 00C00000 00008197 000000C9 
00BC 07800000 18000000 80008000 FFFFFFFF 

PCMserialInSCB:
00C0 00000000 00000000 00000000 00000000 
00C4 00000000 00000000 00000000 00000000 
00C8 00000000 00000000 0000805E 000000C1 
00CC 00000000 00800000 80008000 80008000 
00D0 00005555 0000FFFF 00000000 00000000 
00D4 00000000 00000000 00000000 00000000 
00D8 00000000 00000000 00000000 00000000 
00DC 00000000 00000000 00000000 00000000 

AsynchFGTxSCBInst:
00E0 07FFF800 01100610 0BC00000 00000000 
00E4 00000000 2AAB0000 00000000 00000000 
00E8 00000000 00A00000 00E4022B 000000C6 
00EC 18140000 18000000 80008000 80008000 

AsynchFGRxSCBInst:
00F0 00FFFF00 03800380 0BB00000 00000000 
00F4 00000000 00000000 00000000 00000000 
00F8 00000000 00000000 00F00252 000000C3 
00FC 0E000000 00000000 80008000 FFFFFFFF 
0100 00000000 00000000 00000000 00000000 
0104 00000000 00000000 00000000 00000000 
0108 00000000 00000000 00000000 00000000 
010C 00000000 00000000 00000000 00000000 

OutputSnoopSCB:
0110 00000000 00000000 00000000 00000000 
0114 00000000 00000000 00000000 00000000 
0118 00000000 00000000 0000026F 000000C3 
011C 12000000 00000000 00000000 00200000 
0120 00000000 00000000 00000000 00000000 
0124 00000000 00000000 00000000 00000000 
0128 00000000 00000000 00000000 00000000 
012C 00000000 00000000 00000000 00000000 

SPIOWriteSCB:
0130 804D804D 00000000 00000000 00000000 
0134 00000000 00000000 00000000 00000000 
0138 00000000 00000000 00000194 00000000 
013C 00000000 00000000 00000000 00000000 
0140 00000000 00000000 00000000 00000000 
0144 00000000 00000000 00000000 00000000 
0148 00000000 00000000 00000000 00000000 
014C 00000000 00000000 00000000 00000000 
0150 00000000 00000000 00000000 00000000 
0154 00000000 00000000 00000000 00000000 
0158 00000000 00000000 00000000 00000000 
015C 00000000 00000000 00000000 00000000 
0160 00000000 00000000 00000000 00000000 
0164 00000000 00000000 00000000 00000000 
0168 00000000 00000000 00000000 00000000 
016C 00000000 00000000 00000000 
--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dsp_sample

PCMREADER:
0600 ED42F99C EE6EF940 EFB0F8EF F0F6F8A9 
0610 F236F86E F372F83F F4AAF818 F5DDF7F5 
0620 F70DF7D1 F83AF7A6 F969F778 FAA3F742 
MIX_SAMPLE_BUF1:
1400 FF0BF666 FE8DF5C0 FE00F526 FD60F499 
1410 FCBFF421 FC1CF3BF FB76F36F FAD7F334 
1420 FA45F314 F9C4F30B F94FF319 F8EAF33E 

1780 00000000 00000000 00000000 00000000 
1790 00000000 00000000 00000000 00000000 
17A0 00000000 00000000 00000000 00000000 
17B0 00000000 00000000 00000000 00000000 
17C0 00000000 00000000 00000000 00000000 
17D0 00000000 00000000 00000000 00000000 
17E0 00000000 00000000 00000000 00000000 
17F0 00000000 00000000 00000000 00000000 
SPDIFO_BUFFER:
1800 00000000 00000000 00000000 00000000 
1810 00000000 00000000 00000000 00000000 
1820 00000000 00000000 00000000 00000000 
1830 00000000 00000000 00000000 00000000 
...
18D0 00000000 00000000 00000000 00000000 
18E0 00000000 00000000 00000000 00000000 
18F0 00000000 00000000 00000000 00000000 
1900 00000000 00000000 00000000 00000000 
OUTPUT_SNOOP:
1200 00000000 00000000 00000000 00000000 
1210 00000000 00000000 00000000 00000000 
1220 00000000 00000000 00000000 00000000 
1230 00000000 00000000 00000000 00000000 
...
12D0 00000000 00000000 00000000 00000000 
12E0 00000000 00000000 00000000 00000000 
12F0 00000000 00000000 00000000 00000000 
1300 00000000 00000000 00000000 00000000 

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dsp_scb

SCB's:

0000 nullSCB:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000000 00000169 00000000 
fe980000 00000000 00000000 00000000 
0010 TimingMasterSCBInst:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00200000 00008010 00000000 
00070001 80000001 00000001 00060000 
0020 CodecOutSCB:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00900080 00000179 00000000 
00000000 00000010 00800000 00900000 
0030 PCMreaderSCB:
f2c0400f 00000200 07b84980 00010600 
00000000 00000000 00000000 00000000 
00000000 00000000 00000169 330300c2 
06480000 00000000 80008000 80008000 
0040 WriteBackSCB:
3fc0000f 00000301 00010400 00000000 
00000000 00000000 00000000 00000000 
00000000 00b00000 00d0806d 330480c3 
04800000 00000003 00800003 0000ffff 
0080 CodecInSCB:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000130 0000804f 000000c3 
05000000 00a00010 00000000 80008000 
0090 MasterMixSCB:
00000000 00000000 00001400 00000000 
00000000 00000000 00000000 00000000 
00000080 00a00000 0000809a 000000c3 
14800000 00000000 80008000 80007fff 
00a0 SRCtaskSCBInst:
00210020 00025555 000000c0 000107a0 
00c80028 000000c2 06b80000 01ccccac 
06a00080 00300000 000080bb 000000c9 
07b80000 03accccc 80008000 80007fff 
00b0 VariDecimateSCB:
00c80028 00005555 00000000 00000780 
00c80028 000000c5 ffeaaaab 00000000 
02400080 00c00000 00008197 000000c9 
07800000 18000000 80008000 ffffffff 
00c0 PCMserialInSCB:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000000 0000805e 000000c1 
00000000 00800000 80008000 80008000 
00e0 AsynchFGTxSCBInst:
07fff800 01100610 0bc00000 00000000 
00000000 2aab0000 00000000 00000000 
00000000 00a00000 00e4022b 000000c6 
18140000 18000000 80008000 80008000 
00f0 AsynchFGRxSCBInst:
00ffff00 03800380 0bb00000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000000 00f00252 000000c3 
0e000000 00000000 80008000 ffffffff 
0110 OutputSnoopSCB:
00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000000 0000026f 000000c3 
12000000 00000000 00000000 00200000 
0130 SPIOWriteSCB:
804d804d 00000000 00000000 00000000 
00000000 00000000 00000000 00000000 
00000000 00000000 00000194 00000000 
00000000 00000000 00000000 00000000 
0bc0 SPDIFOSCB:
00000000 000000b0 00000000 00000000 
00000000 00000086 1820fffc 00000000 
00000000 00000600 0bcd020f 00000040 
000020ff 0000804c 00010108 deadc0ed 
0bb0 SPDIFISCB:
deadc0ed 00000000 00000000 0fa00001 
deadc0ed dead000c deadc0ed 0baddead 
deadc0ed 00000bc0 0bbd01d7 00000086 
0e00fffc 00008048 000101f0 00000008 
0ba0 AsynCodecInputSCB:
deadc0ed 00000000 00000000 0fa00001 
00010118 00000086 0a00fffc 00030000 
deadc0ed 00000bb0 0bad01a1 00000086 
0a000000 00008042 00010100 00000000 

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="messages.txt"


Jul 24 13:23:08 porky kernel: PCI: Found IRQ 11 for device 00:09.0
Jul 24 13:23:08 porky kernel: vendorID 00005053 subsystemID 00003357
Jul 24 13:23:08 porky kernel: hack for Voyetra enabled
Jul 24 13:23:09 porky kernel: dsp_spos: loading module cwc4630 into DSP
Jul 24 13:23:09 porky kernel: dsp_spos: clearing parameter area
Jul 24 13:23:09 porky kernel: snd_cs46xx_clear_BA1 bank 00
Jul 24 13:23:09 porky kernel: dsp_spos: downloading parameter data to chip (00000000-00000200)
Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 00
Jul 24 13:23:09 porky kernel: dsp_spos: clearing sample area
Jul 24 13:23:09 porky kernel: snd_cs46xx_clear_BA1 bank 01
Jul 24 13:23:09 porky kernel: dsp_spos: module got no sample segment
Jul 24 13:23:09 porky kernel: dsp_spos: clearing code area
Jul 24 13:23:09 porky kernel: snd_cs46xx_clear_BA1 bank 02
Jul 24 13:23:09 porky kernel: dsp_spos: downloading code to chip (00020000-00020ca0)
Jul 24 13:23:09 porky kernel: dsp_spos: 0 instructions reallocated
Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 02
Jul 24 13:23:09 porky kernel: dsp_spos: loading module cwcasync into DSP
Jul 24 13:23:09 porky kernel: dsp_spos: module got no parameter segment
Jul 24 13:23:09 porky kernel: dsp_spos: module got no sample segment
Jul 24 13:23:09 porky kernel: dsp_spos: downloading code to chip (00020ca0-00021378)
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:02731 addr 8000
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:02731 addr 8000
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01000:60630 addr 000c
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100d:00630 addr 01a0
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01000:20630 addr 0004
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100c:c0630 addr 0198
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:42730 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:42730 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01000:f0630 addr 001e
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100d:90630 addr 01b2
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01000:e00f2 addr 001c
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100d:800f2 addr 01b0
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01001:e8030 addr 003d
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100e:88030 addr 01d1
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01001:82630 addr 0030
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100e:22630 addr 01c4
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01001:504a0 addr 002a
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100d:f04a0 addr 01be
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01001:e8630 addr 003d
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100e:88630 addr 01d1
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01001:d84a0 addr 003b
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100e:784a0 addr 01cf
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01002:b8630 addr 0057
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100f:58630 addr 01eb
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01002:ac0f2 addr 0055
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 0100f:4c0f2 addr 01e9
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01003:ac030 addr 0075
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01010:4c030 addr 0209
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01003:884a0 addr 0071
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01010:284a0 addr 0205
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01003:706b0 addr 006e
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01010:106b0 addr 0202
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01003:78730 addr 006f
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01010:18730 addr 0203
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01004:8c030 addr 0091
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01011:2c030 addr 0225
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01004:704a0 addr 008e
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01011:104a0 addr 0222
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:02731 addr 8000
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:02731 addr 8000
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01005:64630 addr 00ac
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01012:04630 addr 0240
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01005:746b0 addr 00ae
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01012:146b0 addr 0242
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:40630 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:40630 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01005:d86a0 addr 00bb
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01012:786a0 addr 024f
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:42730 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:42730 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01006:60630 addr 00cc
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01013:00630 addr 0260
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:586b0 addr 800b
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:586b0 addr 800b
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:500b0 addr 800a
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:500b0 addr 800a
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01400:40730 addr 8008
Jul 24 13:23:09 porky kernel: handle_wideop[1]: ROM symbol not reallocated
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01400:40730 addr 8008
Jul 24 13:23:09 porky kernel: dsp_spos: 29 instructions reallocated
Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 02
Jul 24 13:23:09 porky kernel: dsp_spos: loading module cwcsnoop into DSP
Jul 24 13:23:09 porky kernel: dsp_spos: module got no parameter segment
Jul 24 13:23:09 porky kernel: dsp_spos: module got no sample segment
Jul 24 13:23:09 porky kernel: dsp_spos: downloading code to chip (00021378-00021470)
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01028:80630 addr 0510
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01013:f8630 addr 027f
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01028:a83a0 addr 0515
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01014:203a0 addr 0284
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01028:d8730 addr 051b
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01014:50730 addr 028a
Jul 24 13:23:09 porky kernel: dsp_spos: 3 instructions reallocated
Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 02
Jul 24 13:23:09 porky kernel: dsp_spos: loading module cwcbinhack into DSP
Jul 24 13:23:09 porky kernel: dsp_spos: module got no parameter segment
Jul 24 13:23:09 porky kernel: dsp_spos: module got no sample segment
Jul 24 13:23:09 porky kernel: dsp_spos: downloading code to chip (00021470-00021570)
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01016:b8630 addr 02d7
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01014:e8630 addr 029d
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01016:e03a0 addr 02dc
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01015:103a0 addr 02a2
Jul 24 13:23:09 porky kernel: handle_wideop[1]: 01017:10730 addr 02e2
Jul 24 13:23:09 porky kernel: handle_wideop:[2] 01015:40730 addr 02a8
Jul 24 13:23:09 porky kernel: dsp_spos: 3 instructions reallocated
Jul 24 13:23:09 porky kernel: snd_cs46xx_download bank 02
Jul 24 13:23:09 porky kernel: MasterMixSCB

--x+6KMIRAuhnl3hBn--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
