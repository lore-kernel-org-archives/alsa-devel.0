From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001589]: broken support for a SB450 Azalia since (including) 1.0.9b
Date: Tue, 22 Nov 2005 18:36:09 +0100
Message-ID: <130fce5e27bb744bc1287d161a4aa09d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4136E19E
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2005 18:36:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1589> 
======================================================================
Reported By:                tvignaud
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1589
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandriva Linux
Kernel Version:             2.6.12
======================================================================
Date Submitted:             11-22-2005 18:17 CET
Last Modified:              11-22-2005 18:36 CET
======================================================================
Summary:                    broken support for a SB450 Azalia since (including)
1.0.9b
Description: 
First, not that "product version" isn't availlable in the bug form.

Marcin Zalicki <marcin.zalicki@mandriva.pl> reported that his ATI "SB450
Azalia HD audio" sound card, managed by snd-hda-intel (PCI ids: vendor:
0x1002 device: 0x4376 subv: 0x1462 subd: 0x7191) do not work anymore with
kernel-2.6.12 since alsa-drivers-1.0.9.

His motherboard is a "MSI-7191" v1.1, RS482M4
On Mandriva kernel 2.6.12-12mdk, he reported that:
- alsa-drivers-1.0.9 + alsa-utils-1.0.9: NO ERROR (but NO SOUND too)
- alsa-drivers-1.0.9b (mandriva kernel) + alsa-utils-1.0.9: NOT WORKING
- alsa-drivers-1.0.10 + alsa-utils-1.0.9: NOT WORKING

Since alsa-drivers-1.0.9b, he gots the following errors:

[root@localhost log]# alsactl store
alsactl: get_control:149: Cannot read control info '2,0,0,Front Playback
Volume,0': Invalid argument

#alsamixer
alsamixer: function snd_mixer_load failed: Invalid argument


Thus it's impossible to set appropriate sound settings. He told me that
with alsa-drivers-1.0.9, it was impssible to get sound with any mixer
configuration (maybe no support for ALC880 codec?)
======================================================================

----------------------------------------------------------------------
 tvignaud - 11-22-05 18:27 
----------------------------------------------------------------------
i've doblechecked, Marcin made a mistake: of course, the device id is
0x437b

----------------------------------------------------------------------
 tvignaud - 11-22-05 18:36 
----------------------------------------------------------------------
this bug might be similar to
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1563

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-05 18:17 tvignaud       New Issue                                    
11-22-05 18:17 tvignaud       Distribution              => Mandriva Linux  
11-22-05 18:17 tvignaud       Kernel Version            => 2.6.12          
11-22-05 18:20 tvignaud       Note Added: 0006790                          
11-22-05 18:27 tvignaud       Note Added: 0006791                          
11-22-05 18:36 tvignaud       Note Added: 0006792                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
