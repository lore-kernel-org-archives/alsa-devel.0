From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000476]: ALSA driver does not work with VIA VT8233 [AC97 Audio Controller]
Date: Wed,  1 Sep 2004 02:15:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040901001542.F23573F018@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 406392A5
	for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2004 02:15:43 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000476
======================================================================
Reported By:                babayaga
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     476
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-31-2004 01:01 CEST
Last Modified:              09-01-2004 02:15 CEST
======================================================================
Summary:                    ALSA driver does not work with VIA VT8233 [AC97 Audio Controller]
Description: 
Please, see the full report at
http://qa.mandrakesoft.com/show_bug.cgi?id=10859
======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-2004 12:27 CEST 
----------------------------------------------------------------------
Above all, try the latest ALSA driver.
If still not work, try dxs_support=2 module option for snd-via82xx.
Also, ac97_quirk=1 module option might help in such a case.

Make sure that the volume is unmuted and adjusted.  Attach
/etc/asound.state for debugging if the above doesn't work.
Also, don't load via82cxx_audio module at the same time.
You set it as sound-slot-0 in /etc/modprobe.conf, which might
cause conflicts.

----------------------------------------------------------------------
 babayaga - 08-31-2004 20:16 CEST 
----------------------------------------------------------------------
Tried that all - in vain. Attaching new conf-files, maybe, I am missing
smth?
Version of snd-via82xx is as supplied with kernel 2.6.8 (2.6.8.1-2mdk more
exactly) I do not know how to get the version otherwise...
What else can I do?
Thanks!

----------------------------------------------------------------------
 babayaga - 09-01-2004 02:15 CEST 
----------------------------------------------------------------------
When the parameters were added to /etc/modprobe.conf also after restarting
sound I have got the following message:
Loading mixer settings /usr/sbin/alsactl: set_control:805: warning: name
mismatch (Input Source Select/IEC958 Output Switch) for control https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000045
/usr/sbin/alsactl: set_control:807: warning: index mismatch (1/0) for
control https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000045
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-31-04 01:01 babayaga       New Bug                                      
08-31-04 12:27 tiwai          Bugnote Added: 0001670                       
08-31-04 20:10 babayaga       File Added: asound.state                     
08-31-04 20:11 babayaga       File Added: modprobe.conf                    
08-31-04 20:11 babayaga       File Added: modules.conf                     
08-31-04 20:16 babayaga       Bugnote Added: 0001674                       
09-01-04 02:15 babayaga       Bugnote Added: 0001676                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
