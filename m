From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000735]: Big noise sound at resume (back from suspend)
Date: Sun, 26 Dec 2004 04:09:14 +0100
Message-ID: <eca6fb6eadb1449cefcba36905e05f6d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A47D3171
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 04:09:14 +0100 (MET)
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
Last Modified:              12-26-2004 04:09 CET
======================================================================
Summary:                    Big noise sound at resume (back from suspend)
Description: 
Sometimes when putting my ibook G4 to suspend, I have a big noise sound at
resume.
About 2 seconds of noise (very near of cat /boot/vmlinuz > /dev/dsp).

======================================================================

----------------------------------------------------------------------
 tiwai - 12-23-04 16:11 
----------------------------------------------------------------------
Does it happen when you mute volumes before suspend/resume, too?

----------------------------------------------------------------------
 djdeath - 12-26-04 04:09 
----------------------------------------------------------------------
Yes, it does

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-04 01:19 djdeath        New Issue                                    
12-20-04 01:19 djdeath        Distribution              => Debian          
12-20-04 01:19 djdeath        Kernel Version            => 2.6.9           
12-20-04 01:21 djdeath        Note Added: 0002864                          
12-23-04 16:11 tiwai          Note Added: 0002924                          
12-26-04 04:09 djdeath        Note Added: 0002934                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
