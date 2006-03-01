From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000530]: Please add an option that restores "defaults"
Date: Wed, 1 Mar 2006 01:05:21 +0100
Message-ID: <62c161de73b3a5619eb78ce0214791ad@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 49E41BD
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:05:21 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=530> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   530
Category:                   amixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2004 06:19 CEST
Last Modified:              03-01-2006 01:05 CET
======================================================================
Summary:                    Please add an option that restores "defaults"
Description: 
I notice /usr/sbin/alsaconf has a "set default mixer volumes"
section.  Maybe amixer should have a

    $ amixer defaults

to get one's sound working in a jiffy.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:57 
----------------------------------------------------------------------
ALSA defaults to everything muted.  If a distributor wants the sound to be
unmuted OOTB, they can just supply their own asound.state.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 06:19 jdthood        New Issue                                    
12-30-05 03:57 rlrevell       Note Added: 0007193                          
03-01-06 01:05 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
