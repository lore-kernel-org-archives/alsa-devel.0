From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000691]: M-Audio USB Midisport 4x4 MIDI interfaces are not visible
Date: Mon, 29 Nov 2004 18:36:05 +0100
Message-ID: <ae29737998cdbf4054d05e44ea9febc6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6DD0E2BE
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 18:36:05 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=691> 
======================================================================
Reported By:                comp
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   691
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 9.1
Kernel Version:             2.6.5-7.111-smp
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
======================================================================
Date Submitted:             11-29-2004 14:00 CET
Last Modified:              11-29-2004 18:36 CET
======================================================================
Summary:                    M-Audio USB Midisport 4x4 MIDI interfaces are not
visible
Description: 
I don't know how to reproduce, but the first time the kaconnect utility
shows the all midisport midi interfaces normally. After running any
application that use midi (muse or whatever), the midi ports lost. I
trying to unplug/plug the midisport and restart alsa with rcalsasound
restart command, but the ports are invisible.
When i create virtual raw midi ports, these midi interfaces always
visible.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-29-04 18:03 
----------------------------------------------------------------------
Please show the output of "lsmod", "amidi -l", and "aplaymidi -l", and the
contents of /proc/asound/cards when the MIDI ports are lost.

----------------------------------------------------------------------
 comp - 11-29-04 18:36 
----------------------------------------------------------------------
The output of lsmod is:

Module                  Size  Used by
snd_seq                65296  0
snd_timer              32132  1 snd_seq
snd_seq_device         12808  1 snd_seq
snd                    70884  3 snd_seq,snd_timer,snd_seq_device
ntfs                   94224  4
nls_utf8                6272  9
nls_cp437               9984  5
vfat                   19456  5
fat                    49824  1 vfat
fglrx                 232924  9
edd                    13720  0
joydev                 14400  0
sg                     41632  0
st                     44956  0
sr_mod                 21028  0
nvram                  13448  0
parport_pc             41024  0
lp                     16136  0
parport                44232  2 parport_pc,lp
lirc_atiusb            14468  0
lirc_dev               16520  2 lirc_atiusb
pl2303                 21380  0
usbserial              35952  1 pl2303
ipv6                  275580  15
thermal                16648  0
processor              21184  1 thermal
fan                     8196  0
button                 10384  0
battery                12804  0
ac                      8964  0
snd_page_alloc         16136  0
soundcore              13536  1 snd
intel_mch_agp          14224  1
agpgart                36012  1 intel_mch_agp
ohci1394               36484  0
ieee1394              109752  1 ohci1394
ehci_hcd               33412  0
uhci_hcd               35600  0
evdev                  13952  0
af_packet              26376  2
ne2k_pci               13408  0
8390                   14592  1 ne2k_pci
usbcore               116572  7
lirc_atiusb,pl2303,usbserial,ehci_hcd,uhci_hcd
binfmt_misc            14856  1
subfs                  12160  2
dm_mod                 57344  0
ide_cd                 42628  0
cdrom                  42780  2 sr_mod,ide_cd
ext3                  121384  4
jbd                    75172  1 ext3
sata_promise           18308  3
ata_piix               11780  11
libata                 43648  2 sata_promise,ata_piix,[permanent]
sd_mod                 24960  18
scsi_mod              118340  6 sg,st,sr_mod,sata_promise,libata,sd_mod

The /proc/asound/cards reports no soundcards, amidi -l reports no
soundcard found, aplaymidi -l reports nothing also. Maybe i use wrong
options in kernel compiling? (I updated the original suse kernel to a new
suse kernel via automatic online update). 

I attached the kernel config file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 14:00 comp           New Issue                                    
11-29-04 14:00 comp           Distribution              => SuSE Linux 9.1  
11-29-04 14:00 comp           Kernel Version            => 2.6.5-7.111-smp
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 SMP
11-29-04 17:55 Clemens LadischAssigned To               => Clemens Ladisch 
11-29-04 17:55 Clemens LadischStatus                   new => assigned     
11-29-04 17:55 Clemens LadischCategory                 GENERIC - serialmidi =>
USB - usb-audio
11-29-04 18:03 Clemens LadischNote Added: 0002656                          
11-29-04 18:33 comp           File Added: config.gz                        
11-29-04 18:36 comp           Note Added: 0002657                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
