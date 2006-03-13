From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001478]: No sound after volume adjustment during playback
Date: Mon, 13 Mar 2006 17:35:30 +0100
Message-ID: <4d7978acef28e653e5c69bbbd899c283@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAB8B1B6
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 17:35:30 +0100 (MET)
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


The issue 0001841 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1478> 
======================================================================
Reported By:                dzi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1478
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2.6.13-r4
Kernel Version:             2.6.13
======================================================================
Date Submitted:             10-17-2005 00:57 CEST
Last Modified:              03-13-2006 17:35 CET
======================================================================
Summary:                    No sound after volume adjustment during playback
Description: 
If I adjust volume during playback, there is no sound anymore. After
reinserting alsa modules sound is ok. I can adjust sound when playback is
stopped and then I can play sound again. But if I adjust volume during
playback, it disappears till reinserting of alsa modules.
I use alsa kernel modules.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001531 PCM output is muted most of the time
has duplicate       0001841 Mixer not working  / fujitsu laptop V20...
======================================================================

----------------------------------------------------------------------
 dzi - 10-17-05 00:59 
----------------------------------------------------------------------
I forgot to mention, that my sound card is AD1986A on my notebook.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-17-05 00:57 dzi            New Issue                                    
10-17-05 00:57 dzi            Distribution              => Gentoo 2.6.13-r4
10-17-05 00:57 dzi            Kernel Version            => 2.6.13          
10-17-05 00:59 dzi            Note Added: 0006485                          
10-18-05 00:54 dzi            Issue Monitored: dzi                         
11-01-05 22:09 dzi            Note Added: 0006600                          
12-01-05 09:18 juliancola     Issue Monitored: juliancola                    
01-01-06 19:37 dzi            Note Deleted: 0006600                        
02-08-06 13:19 simonckenyon   Issue Monitored: simonckenyon                    
03-13-06 17:35 rlrevell       Relationship added       has duplicate 0001531
03-13-06 17:35 rlrevell       Relationship added       has duplicate 0001841
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
