From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000476]: ALSA driver does not work with VIA VT8233 [AC97 Audio Controller]
Date: Sat, 9 Apr 2005 04:33:20 +0200
Message-ID: <43edb25e53123a798aa4792b03fb55b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 98B3326C
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 04:33:20 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=476> 
======================================================================
Reported By:                babayaga
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   476
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-31-2004 01:01 CEST
Last Modified:              04-09-2005 04:33 CEST
======================================================================
Summary:                    ALSA driver does not work with VIA VT8233 [AC97
Audio Controller]
Description: 
Please, see the full report at
http://qa.mandrakesoft.com/show_bug.cgi?id=10859
======================================================================

----------------------------------------------------------------------
 babayaga - 09-01-04 02:15 
----------------------------------------------------------------------
When the parameters were added to /etc/modprobe.conf also after restarting
sound I have got the following message:
Loading mixer settings /usr/sbin/alsactl: set_control:805: warning: name
mismatch (Input Source Select/IEC958 Output Switch) for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=45
/usr/sbin/alsactl: set_control:807: warning: index mismatch (1/0) for
control https://bugtrack.alsa-project.org/alsa-bug/view.php?id=45
/usr/sbin/alsactl: set_control:892: bad control.45.value type
                                                                [FAILED]

Could that be a reason?

Hardware:
[root@oka etc]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host
Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:06.0 Multimedia audio controller: Yamaha Corporation: Unknown device
1000
00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
Gigabit Ethernet (rev 03)
00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If
[Radeon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon
9000] (Secondary) (rev 01)

----------------------------------------------------------------------
 jdthood - 04-09-05 04:33 
----------------------------------------------------------------------
Reported fixed in the upstream bug report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-04 01:01 babayaga       New Issue                                    
08-31-04 12:27 tiwai          Note Added: 0001670                          
08-31-04 20:10 babayaga       File Added: asound.state                     
08-31-04 20:11 babayaga       File Added: modprobe.conf                    
08-31-04 20:11 babayaga       File Added: modules.conf                     
08-31-04 20:16 babayaga       Note Added: 0001674                          
09-01-04 02:15 babayaga       Note Added: 0001676                          
09-01-04 23:32 babayaga       Issue Monitored: babayaga                    
04-09-05 04:33 jdthood        Note Added: 0004384                          
04-09-05 04:33 jdthood        Status                   new => resolved     
04-09-05 04:33 jdthood        Resolution               open => fixed       
04-09-05 04:33 jdthood        View Status              @0@ => public       
04-09-05 04:33 jdthood        Description Updated                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
