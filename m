From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000735]: Big noise sound at resume (back from suspend)
Date: Sun, 24 Apr 2005 22:29:17 +0200
Message-ID: <5b965c50fe71ce7d1f28fb8542ea6779@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 448FC21F
	for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2005 22:29:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=735> 
======================================================================
Reported By:                djdeath
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   735
Category:                   PPC - powermac
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-20-2004 01:19 CET
Last Modified:              04-24-2005 22:29 CEST
======================================================================
Summary:                    Big noise sound at resume (back from suspend)
Description: 
Sometimes when putting my ibook G4 to suspend, I have a big noise sound at
resume.
About 2 seconds of noise (very near of cat /boot/vmlinuz > /dev/dsp).

======================================================================

----------------------------------------------------------------------
 djdeath - 12-29-04 05:57 
----------------------------------------------------------------------
> No, there is no problem when sound is muted.

Sorry, but after a few new test, it seems it happens when sound is muted
too.



----------------------------------------------------------------------
 djdeath - 04-24-05 22:29 
----------------------------------------------------------------------
fixed since 2.6.12-rc2-mm2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 01:19 djdeath        New Issue                                    
12-20-04 01:19 djdeath        Distribution              => Debian          
12-20-04 01:19 djdeath        Kernel Version            => 2.6.9           
12-20-04 01:21 djdeath        Note Added: 0002864                          
12-23-04 16:11 tiwai          Note Added: 0002924                          
12-26-04 04:09 djdeath        Note Added: 0002934                          
12-26-04 13:30 djdeath        Note Edited: 0002934                         
12-29-04 05:57 djdeath        Note Edited: 0002934                         
04-24-05 22:29 djdeath        Note Added: 0004567                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
