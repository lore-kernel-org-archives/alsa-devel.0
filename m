From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001494]: Intel HDA audio "scratchy" on Fujitsu S7020D unless position_fix=1 used
Date: Wed, 1 Mar 2006 10:48:25 +0100
Message-ID: <ed5f6f100376ff577527a8049da4b927@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43AD2186
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 10:48:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1494> 
======================================================================
Reported By:                Paul Walmsley
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1494
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Red Hat Fedora Core 4
Kernel Version:             2.6.13-1.1532_FC4 with ALSA drivers from CVS head
13-Oct-2005
======================================================================
Date Submitted:             10-22-2005 19:03 CEST
Last Modified:              03-01-2006 10:48 CET
======================================================================
Summary:                    Intel HDA audio "scratchy" on Fujitsu S7020D unless
position_fix=1 used
Description: 
Audio on a Fujitsu Lifebook S7020D (snd-hda-intel with a Realtek ALC260) is
distorted and choppy unless position_fix=1 is used as a module parameter. 
This should be the default for this particular configuration.

By the way, Jonathan Woithe's mixer changes in patch-realtek.c CVS rev
1.26 work well on this platform for playback.  (I have not yet tested
recording.) 




======================================================================

----------------------------------------------------------------------
 rlrevell - 03-01-06 01:44 
----------------------------------------------------------------------
Is this fixed in later releases?

----------------------------------------------------------------------
 Paul Walmsley - 03-01-06 10:48 
----------------------------------------------------------------------
Just tested 1.0.11rc3; it works fine without an explicit position_fix
parameter
on this hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-22-05 19:03 Paul Walmsley  New Issue                                    
10-22-05 19:03 Paul Walmsley  Distribution              => Red Hat Fedora Core 4
10-22-05 19:03 Paul Walmsley  Kernel Version            => 2.6.13-1.1532_FC4
with ALSA drivers from CVS head 13-Oct-2005
10-22-05 19:04 Paul Walmsley  Issue Monitored: Paul Walmsley                    
03-01-06 01:44 rlrevell       Note Added: 0008262                          
03-01-06 10:05 cartman        Issue Monitored: cartman                     
03-01-06 10:48 Paul Walmsley  Note Added: 0008279                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
