From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001731]: Fixed chip configuration for 5.1 in ALC850 code
Date: Thu, 12 Jan 2006 01:22:22 +0100
Message-ID: <520d8a9547067b7a62691c3ed7302189@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A890B15D
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 01:22:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1731> 
======================================================================
Reported By:                C-MoH
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1731
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-11-2006 01:17 CET
Last Modified:              01-12-2006 01:22 CET
======================================================================
Summary:                    Fixed chip configuration for 5.1 in ALC850 code
Description: 
Frustrated by the fact that the 5.1 DVD I just bought had no voices (since
they were on the center channel) I started to dig into it. The details are
in the "steps to reproduce".

Attached is a (very) small patch that fixed it completely on my system
(both the mixer and the channel mix-up). My guess is that the chip was
misconfigured by lack of a bit in the MX76 register. (2 instead of 5 for
bits 6:4)
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-11-06 18:38 
----------------------------------------------------------------------
Ah, OK, I missed the part where you said the patch was based on the ALC850
datasheet.

Maintainers, this patch should be applied for the 1.0.11 release.

----------------------------------------------------------------------
 C-MoH - 01-12-06 01:22 
----------------------------------------------------------------------
Nice! Do mention my name/nick somewhere inthere :) I'll monitor this
bugtracker issue for a while.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 01:17 C-MoH          New Issue                                    
01-11-06 01:17 C-MoH          File Added: cipi.patch                       
01-11-06 01:21 C-MoH          Issue Monitored: C-MoH                       
01-11-06 01:22 C-MoH          Note Added: 0007553                          
01-11-06 01:33 rlrevell       Note Added: 0007554                          
01-11-06 01:37 C-MoH          Note Added: 0007555                          
01-11-06 01:40 rlrevell       Note Added: 0007556                          
01-11-06 11:54 C-MoH          Note Added: 0007562                          
01-11-06 11:58 C-MoH          Note Edited: 0007562                         
01-11-06 18:38 rlrevell       Note Added: 0007565                          
01-12-06 01:22 C-MoH          Note Added: 0007578                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
