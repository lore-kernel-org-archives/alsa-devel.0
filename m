From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000530]: Please add an option that restores "defaults"
Date: Fri, 30 Dec 2005 03:57:21 +0100
Message-ID: <5399abe896e8c902bfea3053c00b2b76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 793091AB
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 03:57:21 +0100 (MET)
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
Status:                     new
======================================================================
Date Submitted:             09-24-2004 06:19 CEST
Last Modified:              12-30-2005 03:57 CET
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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
