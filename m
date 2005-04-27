From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001079]: MIDI OUT port not avaliable
Date: Thu, 28 Apr 2005 00:36:30 +0200
Message-ID: <3dbfb24a91abb52ec93c97242ec99ee1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 71522279
	for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2005 00:36:30 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1079> 
======================================================================
Reported By:                7thatom
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   1079
Category:                   ISA - msnd_pinnacle
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14_FC3 (also older)
======================================================================
Date Submitted:             04-28-2005 00:36 CEST
Last Modified:              04-28-2005 00:36 CEST
======================================================================
Summary:                    MIDI OUT port not avaliable
Description: 
I would like to report you a bug what I do not know how to solve. I have
Turtle Beach card named Fiji. When I install ALSA drivers (core
2.6.11-1.14_FC3) MIDI OUT port is not visible and I cannot use it. MIDI IN
port works fine. I initialise my card by following commands (Non PnP
mode):

modprobe snd-msnd-pinnacle cfg=0x250 io=0x100 irq=5 mem=0xc8000 
mpu_io=0x200 mpu_irq=7
modprobe snd-pcm-oss
modprobe snd-mixer-oss
modprobe snd-seq-oss


result of command amidi -l 
[seventhatom@Vigor10 ~]$ amidi -l
Device    Name
hw:0,0    MSND MIDI

result of command aconnect -i
[seventhatom@Vigor10 ~]$ aconnect -i
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
client 64: 'MSND MIDI' [type=kernel]
    0 'MSND MIDI       '

result of aconnect -o (nothing)
[seventhatom@Vigor10 ~]$ aconnect -o

dmesg command shows following:
snd_msnd_pinnacle: Turtle Beach MultiSound (Pinnacle/Fiji) Linux Driver
Version 0.1.3.0, Copyright (C) 2002 Karsten Wiese 1998 Andrew Veliath
snd_msnd_pinnacle: Non-PnP mode: configuring at port 0x250
snd_msnd_pinnacle: Configuring MPU to I/O 0x200 IRQ 7
snd_msnd_pinnacle: Pinnacle/Fiji revision A-B (Fiji) or A-E (Pinnacle),
Xilinx version <= 1.15, I/O 0x100-0x107, IRQ 5, memory mapped to
0xC8000-0xCFFFF
snd_msnd_pinnacle: DSP reset
snd_msnd_pinnacle: DSP firmware uploaded

lsmod shows following:
[root@Vigor10 sbin]# ./lsmod
Module                  Size  Used by
snd_seq_midi            9248  0
mga                    58561  1
snd_seq_oss            39808  0
snd_seq_midi_event      9600  2 snd_seq_midi,snd_seq_oss
snd_seq                63376  5
snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_msnd_pinnacle      27572  2
snd_rawmidi            30496  2 snd_seq_midi,snd_msnd_pinnacle
snd_seq_device          9356  4
snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi
snd_pcm_oss            52640  0
snd_mixer_oss          19200  2 snd_pcm_oss
snd_pcm               101000  2 snd_msnd_pinnacle,snd_pcm_oss
snd_timer              33540  2 snd_seq,snd_pcm
snd                    57828  11
snd_seq_oss,snd_seq,snd_msnd_pinnacle,snd_rawmidi,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10244  1 snd_pcm
soundcore              10785  3 snd_msnd_pinnacle,snd
lp                     12489  0
autofs4                26181  0
sunrpc                164485  1
video                  15813  0
button                  6609  0
battery                 9285  0
ac                      4805  0
md5                     4161  1
ipv6                  259201  10
uhci_hcd               33497  0
parport_pc             28421  0
parport                40201  2 lp,parport_pc
via686a                18009  0
i2c_sensor              3521  1 via686a
i2c_core               21953  2 via686a,i2c_sensor
8139too                29505  0
mii                     4929  1 8139too
floppy                 64753  0
dm_snapshot            17669  0
dm_zero                 2497  0
dm_mirror              25773  0
ext3                  131145  2
jbd                    82777  1 ext3
dm_mod                 59221  6 dm_snapshot,dm_zero,dm_mirror


Thank you for support. 









======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-05 00:36 7thatom        New Issue                                    
04-28-05 00:36 7thatom        Distribution              => Fedora Core 3   
04-28-05 00:36 7thatom        Kernel Version            => 2.6.11-1.14_FC3 (also
older)
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
