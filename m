From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002326]: SB Audigy LS - Only Hear
	Static
Date: Wed, 2 Aug 2006 15:56:55 +0200
Message-ID: <ea20b5ef76124998c75250ae5d8029ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4BEB4177
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 15:56:56 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2326> 
======================================================================
Reported By:                derekwisong
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2326
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15-1-486
======================================================================
Date Submitted:             08-02-2006 15:56 CEST
Last Modified:              08-02-2006 15:56 CEST
======================================================================
Summary:                    SB Audigy LS - Only Hear Static
Description: 
I only hear static when trying to play sounds with my SB Audigy LS. Here is
my lspci and lsmod.

-------------------- lspci ----------------------

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1            )
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev
c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev
c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev
c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev
c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev
c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev             a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX
4000 AGP             8x] (rev c1)
01:09.0 Multimedia audio controller: Creative Labs SB Audigy LS
01:0a.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge
(non-transparent mode            ) (rev 11)
02:08.0 Multimedia video controller: Internext Compression Inc iTVC16
(CX23416)             MPEG-2 Encoder (rev 01)
02:09.0 Multimedia video controller: Internext Compression Inc iTVC16
(CX23416)             MPEG-2 Encoder (rev 01) 

------------------ lsmod --------------------

Module                  Size  Used by
nvidia               4546132  12
ipv6                  222336  10
nfsd                  207236  13
lockd                  55432  2 nfsd
nfs_acl                 3584  1 nfsd
sunrpc                133052  9 nfsd,lockd,nfs_acl
appletalk              32816  20
button                  6672  0
ac                      4868  0
battery                 9732  0
xfs                   492248  1
exportfs                5504  2 nfsd,xfs
dm_mod                 51512  0
tda9887                14224  0
wm8775                  5644  0
cx25840                22160  0
tuner                  21536  0
tveeprom               13356  0
ivtv                  181524  0
firmware_class          9984  2 cx25840,ivtv
i2c_algo_bit            8456  1 ivtv
videodev                9088  1 ivtv
joydev                  9024  0
snd_ca0106             29860  0
snd_ac97_codec         82336  1 snd_ca0106
snd_pcm_oss            45856  0
snd_mixer_oss          16768  1 snd_pcm_oss
evdev                   8960  1
snd_pcm                77576  3 snd_ca0106,snd_ac97_codec,snd_pcm_oss
snd_timer              21636  1 snd_pcm
snd_mpu401              6472  0
snd_mpu401_uart         6784  1 snd_mpu401
snd_rawmidi            22560  2 snd_ca0106,snd_mpu401_uart
snd_seq_device          8204  1 snd_rawmidi
snd                    48612  10
snd_ca0106,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401,snd_mpu401_uart...
mousedev               10784  1
psmouse                32516  0
rtc                    11700  0
serio_raw               6660  0
floppy                 54980  0
parport_pc             32324  0
parport                31944  1 parport_pc
snd_ac97_bus            2304  1 snd_ac97_codec
soundcore               9184  1 snd
snd_page_alloc         10120  2 snd_ca0106,snd_pcm
analog                 10528  0
gameport               14216  1 analog
pcspkr                  1924  0
shpchp                 40000  0
pci_hotplug            25012  1 shpchp
i2c_nforce2             6528  0
nvidia_agp              7452  1
agpgart                31560  2 nvidia,nvidia_agp
i2c_core               19600  9
nvidia,tda9887,wm8775,cx25840,tuner,tveeprom,ivtv,i2c_algo_bit,i2c_nforce2
ext3                  117768  1
jbd                    48404  1 ext3
ide_cd                 36612  0
cdrom                  33568  1 ide_cd
ide_disk               16128  5
ide_generic             1408  0 [permanent]
sata_nv                 8964  0
libata                 50956  1 sata_nv
scsi_mod              125928  1 libata
generic                 4484  0 [permanent]
amd74xx                13084  0 [permanent]
ide_core              112544  5
ide_cd,ide_disk,ide_generic,generic,amd74xx
forcedeth              20228  0
ehci_hcd               29192  0
ohci_hcd               18052  0
usbcore               113540  3 ehci_hcd,ohci_hcd
thermal                13576  0
processor              23104  1 thermal
fan                     4868  0 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-06 15:56 derekwisong    New Issue                                    
08-02-06 15:56 derekwisong    Distribution              => Debian          
08-02-06 15:56 derekwisong    Kernel Version            => 2.6.15-1-486    
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
