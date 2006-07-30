From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000691]: M-Audio USB Midisport 4x4
	MIDI interfaces are not visible
Date: Mon, 31 Jul 2006 01:47:29 +0200
Message-ID: <181c2ecd43a1d16c8b49372243709808@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B08D16C
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 01:47:30 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               SuSE Linux 9.1
Kernel Version:             2.6.5-7.111-smp #2 SMP
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             11-29-2004 14:00 CET
Last Modified:              07-31-2006 01:47 CEST
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

----------------------------------------------------------------------
 Clemens Ladisch - 11-29-04 18:48 
----------------------------------------------------------------------
kaconnect showing the ports means that the kernel/drivers are compiled
correctly.

However, your lsmod output shows that the snd-usb-audio module isn't
loaded anymore.

Apparently, your machine is configured for "automatic module unloading",
i.e., modules that aren't currently used are unloaded.  There should be a
cron job that calls "rmmod --all" once per minute or so; deactivte/delete
it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 14:00 comp           New Issue                                    
11-29-04 14:00 comp           Distribution              => SuSE Linux 9.1  
11-29-04 14:00 comp           Kernel Version            => 2.6.5-7.111-smp #2
SMP
11-29-04 17:55 Clemens LadischAssigned To               => Clemens Ladisch 
11-29-04 17:55 Clemens LadischStatus                   new => assigned     
11-29-04 17:55 Clemens LadischCategory                 GENERIC - serialmidi =>
USB - usb-audio
11-29-04 18:03 Clemens LadischNote Added: 0002656                          
11-29-04 18:33 comp           File Added: config.gz                        
11-29-04 18:36 comp           Note Added: 0002657                          
11-29-04 18:48 Clemens LadischNote Added: 0002658                          
07-31-06 01:47 Adrian Bunk    Status                   assigned => closed  
07-31-06 01:47 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
