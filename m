From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000708]: Fix CVS envy24control crash on midi 00 control
Date: Wed, 1 Mar 2006 01:05:09 +0100
Message-ID: <7438002c8e2bdba02224fd910fde7abc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AAA8E1C7
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:05:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=708> 
======================================================================
Reported By:                shadow
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   708
Category:                   envy24control
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-05-2004 12:36 CET
Last Modified:              03-01-2006 01:05 CET
======================================================================
Summary:                    Fix CVS envy24control crash on midi 00 control
Description: 
envy24control adds midi support, but if it receives data from a controller
with ID '0' it will crash.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:58 
----------------------------------------------------------------------
Is this still broken?

----------------------------------------------------------------------
 shadow - 01-11-06 08:24 
----------------------------------------------------------------------
I havent used midi function of envy24control in many months. I cannot say
if this issue exists or has been resolved. Please close this report and I
will file a new one if there are problems.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 12:36 shadow         New Issue                                    
12-05-04 12:36 shadow         File Added:
cvs_alsa_20041205-envy24control.midi00crash.patch                    
12-05-04 13:58 shadow         Note Added: 0002721                          
12-05-04 15:02 shadow         Note Added: 0002722                          
12-05-04 15:02 shadow         File Added:
cvs_alsa_20041205-envy24control.midi00crash.patch                    
12-30-05 03:58 rlrevell       Note Added: 0007194                          
12-30-05 04:28 shadow         Note Added: 0007209                          
01-11-06 08:24 shadow         Note Edited: 0007209                         
03-01-06 01:05 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
