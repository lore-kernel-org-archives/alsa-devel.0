From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Mon, 14 Apr 2003 21:06:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030414190615.GA22184@ulima.unil.ch>
References: <s5h65poq65j.wl@alsa2.suse.de> <20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de> <3E9553C2.3000100@superbug.demon.co.uk> <20030410112657.GA2332@ulima.unil.ch> <3E994CCE.6020105@cucumelo.org> <20030413170501.GA2323@ulima.unil.ch> <3E99AAAB.1070101@cucumelo.org> <20030413183035.GC2323@ulima.unil.ch> <3E99F176.6080503@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E99F176.6080503@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2003 at 01:23:34AM +0200, Benny Sjostrand wrote:

> Could you repeat the tests with the attached patch applied to current=20
> CVS. The only changes are some more debug messages.

Yes, sure!!!

> Just to check, which version of xine ? (I'm using 0.9.18)

0.9.20 with lots of different DVD tested...

> "Lord Of the Rings" DTS and Surround 5.1, and "Star Wars II" Surrund 5.=
1=20
> works fine forme.

So, I'll take Star Wars II for my new test ;-)

I just gives here the commands and the output from dmesg...

Reloading the modules:

ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing nullSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing TimingMasterSCBInst
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing CodecOutSCB_I
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing MasterMixSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing CodecInSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing WriteBackSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing VariDecimateSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing RecordMixerSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing CodecOutSCB_Rear
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing RearMixerSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing CodecOutSCB_CLFE
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing CLFEMixerSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing MagicSnoopSCB_I
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SPIOWriteSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTaskSCB_SPDIFI
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SPDIFOSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SPDIFISCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynCodecInputSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2458: snd_cs46xx: detectin=
g primary codec
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2408: cs46xx: CODOEC1 mode=
 0000
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2482: snd_cs46xx: primary =
codec phase one
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2486: snd_cs46xx: detectin=
g seconadry codec
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2411: cs46xx: CODOEC2 mode=
 0003
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:314: dsp_spos: loading modul=
e cwc4630 into DSP
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:317: dsp_spos: clearing para=
meter area
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:332: dsp_spos: downloading p=
arameter data to chip (00000000-00000200)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:341: dsp_spos: clearing samp=
le area
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:346: dsp_spos: module got no=
 sample segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:366: dsp_spos: clearing code=
 area
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:392: dsp_spos: downloading c=
ode to chip (00020000-00020ca0)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:111: dsp_spos: 0 instruction=
s reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:314: dsp_spos: loading modul=
e cwcasync into DSP
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:322: dsp_spos: module got no=
 parameter segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:346: dsp_spos: module got no=
 sample segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:392: dsp_spos: downloading c=
ode to chip (00020ca0-00021378)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01000:=
60630 addr 000c
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100d=
:00630 addr 01a0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01000:=
20630 addr 0004
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100c=
:c0630 addr 0198
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
42730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:42730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01000:=
f0630 addr 001e
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100d=
:90630 addr 01b2
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01000:=
e00f2 addr 001c
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100d=
:800f2 addr 01b0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01001:=
e8030 addr 003d
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100e=
:88030 addr 01d1
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01001:=
82630 addr 0030
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100e=
:22630 addr 01c4
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01001:=
504a0 addr 002a
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100d=
:f04a0 addr 01be
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01001:=
e8630 addr 003d
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100e=
:88630 addr 01d1
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01001:=
d84a0 addr 003b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100e=
:784a0 addr 01cf
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01002:=
b8630 addr 0057
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100f=
:58630 addr 01eb
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01002:=
ac0f2 addr 0055
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 0100f=
:4c0f2 addr 01e9
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01003:=
ac030 addr 0075
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01010=
:4c030 addr 0209
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01003:=
884a0 addr 0071
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01010=
:284a0 addr 0205
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01003:=
706b0 addr 006e
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01010=
:106b0 addr 0202
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01003:=
78730 addr 006f
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01010=
:18730 addr 0203
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01004:=
8c030 addr 0091
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01011=
:2c030 addr 0225
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01004:=
704a0 addr 008e
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01011=
:104a0 addr 0222
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01005:=
64630 addr 00ac
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01012=
:04630 addr 0240
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01005:=
746b0 addr 00ae
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01012=
:146b0 addr 0242
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
40630 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:40630 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01005:=
d86a0 addr 00bb
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01012=
:786a0 addr 024f
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
42730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:42730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01006:=
60630 addr 00cc
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01013=
:00630 addr 0260
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
586b0 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:586b0 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
500b0 addr 800a
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:500b0 addr 800a
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
40730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:40730 addr 8008
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:111: dsp_spos: 29 instructio=
ns reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:314: dsp_spos: loading modul=
e cwcsnoop into DSP
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:322: dsp_spos: module got no=
 parameter segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:346: dsp_spos: module got no=
 sample segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:392: dsp_spos: downloading c=
ode to chip (00021378-00021470)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01028:=
80630 addr 0510
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01013=
:f8630 addr 027f
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01028:=
a83a0 addr 0515
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01014=
:203a0 addr 0284
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01028:=
d8730 addr 051b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01014=
:50730 addr 028a
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:111: dsp_spos: 3 instruction=
s reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:314: dsp_spos: loading modul=
e cwcbinhack into DSP
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:322: dsp_spos: module got no=
 parameter segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:346: dsp_spos: module got no=
 sample segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:392: dsp_spos: downloading c=
ode to chip (00021470-00021570)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01016:=
b8630 addr 02d7
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01014=
:e8630 addr 029d
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01016:=
e03a0 addr 02dc
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01015=
:103a0 addr 02a2
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01017:=
10730 addr 02e2
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01015=
:40730 addr 02a8
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:111: dsp_spos: 3 instruction=
s reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:314: dsp_spos: loading modul=
e cwcdma into DSP
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:322: dsp_spos: module got no=
 parameter segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:346: dsp_spos: module got no=
 sample segment
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:392: dsp_spos: downloading c=
ode to chip (00021570-00021630)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:02731 addr 8000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
58630 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:58630 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01000:=
902a0 addr 0012
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01016=
:002a0 addr 02c0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:83: handle_wideop[1]: 01400:=
58730 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:88: handle_wideop[1]: ROM sy=
mbol not reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:100: handle_wideop:[2] 01400=
:58730 addr 800b
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:111: dsp_spos: 4 instruction=
s reallocated
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <TimingMasterSCBInst>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <CodecOutSCB_I>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <MasterMixSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <CodecInSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <WriteBackSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <VariDecimateSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <RecordMixerSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <CodecOutSCB_Rear>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <RearMixerSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <CodecOutSCB_CLFE>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <CLFEMixerSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <MagicSnoopSCB_I>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SPIOWriteSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTaskSCB_SPDIFI rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTaskSCB_SPDIFI>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos.c:1654: setting SP_SPDOUT_CSUV=
 register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2124: setting SP_SPDOUT_CS=
UV register (02003000)

ac3dec from_beyond_the_edge_44k_256kbps.ac3 --device=3Diec958:AES0=3D0x2,=
AES1=3D0x82,AES2=3D0x0,AES3=3D0x2
5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
Using PCM device 'iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2'

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (00003087)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), =
periods (32) buffer_size(65536)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003002)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (00003087)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>

Switching to a channel broadcasting ac3 (not always 5.1):

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (00003087)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (1024), =
periods (60) buffer_size(61440)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003002)
ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer value (stre=
am =3D 0, delta: -256, max jitter =3D 7680): wrong interrupt acknowledge?

Running xine (StarWars II) I can't access this DVD really well:
xine hangs on audio menu (I was still on the ac3 channels)

ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer value (stre=
am =3D 0, delta: -256, max jitter =3D 7680): wrong interrupt acknowledge?
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1418: open front channel
ALSA ../alsa-kernel/core/pcm_lib.c:156: Unexpected hw_pointer value (stre=
am =3D 0, delta: -256, max jitter =3D 7680): wrong interrupt acknowledge?
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (00003087)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (00003087)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), =
periods (32) buffer_size(65536)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>

Retry of xine without the ac3 channel on VDR (with bitstreamout plugin) t=
his time
I can choose french language and begin to play the movie (I don't hear an=
ything):

ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1418: open front channel
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1441: open raw iec958 chan=
nel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMSerialInput_II
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1704: setting SP_SPD=
OUT_CSUV register to stream (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1241: IEC958 pass th=
rough
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1306: dsp_spos: crea=
ting SRC "SrcTask_SCB0"
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:597: dsp_spos: setti=
ng SrcTask_SCB0 rate to 48000
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <SrcTask_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1331: dsp_spos: crea=
ting PCM "PCMReader_SCB0" (5)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMReader_SCB0>
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1001: period_size (2048), =
periods (32) buffer_size(65536)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:2179: setting SP_SPDOUT_CS=
UV register (02003006)
ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:1457: close raw iec958 cha=
nnel
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing PCMReader_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing SrcTask_SCB0
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:1721: setting SP_SPD=
OUT_CSUV register to default (02003000)
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:226: cs46xx_dsp_proc=
_free_scb_desc: freeing AsynchFGTxSCB
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <AsynchFGTxSCB>
ALSA ../../alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c:290: dsp_spos: creat=
ing SCB <PCMSerialInput_II>

Should I test some other things?

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
