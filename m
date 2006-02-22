From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001868]: Audigy4 lacks line-in
Date: Wed, 22 Feb 2006 20:26:36 +0100
Message-ID: <8326230afb8e8ad762406318830d9746@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEDD61BD
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2006 20:26:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1868> 
======================================================================
Reported By:                wwp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1868
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.5
======================================================================
Date Submitted:             02-22-2006 19:12 CET
Last Modified:              02-22-2006 20:26 CET
======================================================================
Summary:                    Audigy4 lacks line-in
Description: 
I'm not able to get line-in support (un-mute is OK), but PCM out is fine.
Is that because the emu10k1 sources don't include the card IDs for my
model?
Don't know if this would be enough or even right, but here's a patch
proposal for this card's chip detail (attached to this report)
======================================================================

----------------------------------------------------------------------
 wwp - 02-22-06 20:26 
----------------------------------------------------------------------
Ahum, sorry it's kernel 2.6.15.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-06 19:12 wwp            New Issue                                    
02-22-06 19:12 wwp            File Added:
alsa-driver-1.0.11rc3-audigy4-sb0400.diff                    
02-22-06 19:12 wwp            Distribution              => Debian unstable 
02-22-06 19:12 wwp            Kernel Version            => 2.6.5           
02-22-06 19:21 wwp            Issue Monitored: wwp                         
02-22-06 20:26 wwp            Note Added: 0008162                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
