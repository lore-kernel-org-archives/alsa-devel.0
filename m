From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001977]: Compilation fails due to bad configuration step
Date: Wed, 29 Mar 2006 18:52:57 +0200
Message-ID: <1f00a5b344e41aa4a084897bc72172da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59AC4132
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:52:58 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1977> 
======================================================================
Reported By:                Faber
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1977
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2006 15:43 CEST
Last Modified:              03-29-2006 18:52 CEST
======================================================================
Summary:                    Compilation fails due to bad configuration step
Description: 
Configure detects Via C3-2 system as "unknown", causing incorrect detection
of vmalloc_to_page, pci_saved_config, new_pci_save_state. This causes
compilation to fail.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 18:52 
----------------------------------------------------------------------
The pactch is applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 15:43 Faber          New Issue                                    
03-29-06 15:43 Faber          File Added: c3_2_configure.patch                  
 
03-29-06 15:53 Faber          Issue Monitored: Faber                       
03-29-06 18:52 tiwai          Status                   assigned => resolved
03-29-06 18:52 tiwai          Resolution               open => fixed       
03-29-06 18:52 tiwai          Note Added: 0009002                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
