From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000271]: Alsa no longer loads at boot - sound card not found
Date: Sat, 19 Mar 2005 15:07:45 +0100
Message-ID: <b7443c4b561a086358848b774a71b65d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 16CF71D8
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 15:07:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=271> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   271
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.6_rc1
======================================================================
Date Submitted:             05-12-2004 19:17 CEST
Last Modified:              03-19-2005 15:07 CET
======================================================================
Summary:                    Alsa no longer loads at boot - sound card not found
Description: 
Alsa has been working very well on this machine for at least a month.
Starting this last weekend it stopped loading at boot time. Interestingly
it will load if I modprobe if by hand.

I have tried rebuilding the kernel, rebuilding all associated part of Alsa
but the problem continues.

<From dmesg>
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30
08:19:30 2
004 UTC).
ALSA device list:
  No soundcards found.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 300 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/proje
cts/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 1004020k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
flash root # 

flash root # lsmod
Module                  Size  Used by
flash root # modprobe snd-atiixp
flash root # lsmod
Module                  Size  Used by
snd_atiixp             16420  0 
snd_ac97_codec         61956  1 snd_atiixp
flash root # 
======================================================================

----------------------------------------------------------------------
 tiwai - 05-12-04 19:21 
----------------------------------------------------------------------
the first ALSA message shows that you have no kernel built-in ALSA
driver.  since you built atiixp driver as a module, it cannot work so.

also, /etc/modules.conf is obsolete for 2.6 kernels.
it's now /etc/modprobe.conf.

----------------------------------------------------------------------
 jdthood - 03-19-05 15:07 
----------------------------------------------------------------------
This is a local configuration problem.
I think that the report can be closed,

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-04 19:17 Mark Knecht    New Issue                                    
05-12-04 19:17 Mark Knecht    File Added: modules.conf                     
05-12-04 19:17 Mark Knecht    Distribution              => Gentoo          
05-12-04 19:17 Mark Knecht    Kernel Version            => 2.6.6_rc1       
05-12-04 19:21 tiwai          Note Added: 0001098                          
03-19-05 15:07 jdthood        Note Added: 0004049                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
