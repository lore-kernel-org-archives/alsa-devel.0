From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000464]: Right Channel always +6dB Louder than Left Channel while recording in Stereo
Date: Wed, 22 Mar 2006 03:40:24 +0100
Message-ID: <fe3ca9263923d39eb364350823ea0a8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C4EC1A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:40:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=464> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   464
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Mandrake Linux
Kernel Version:             2.4.19-16mdk
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-26-2004 07:48 CEST
Last Modified:              03-22-2006 03:40 CET
======================================================================
Summary:                    Right Channel always +6dB Louder than Left Channel
while recording in Stereo
Description: 
The sound card is Turtle Beach Santa Cruz (CS4630). When trying to record
from any stereo source (Line In, Aux, CDROM, Mix) the right channel is
always +6dB louder than left channel. This happens with arecord, mencoder,
audacity, or any program that can record audio. Recording in mono works
perfectly.


======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 15:34 
----------------------------------------------------------------------
Submitter: That is pretty strange behavior.  Do you still see the problem
with the latest ALSA release?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:40 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 07:48 Electro        New Issue                                    
08-26-04 07:48 Electro        Distribution              => Mandrake Linux  
08-26-04 07:48 Electro        Kernel Version            => 2.4.19-16mdk    
10-31-04 04:06 Electro        Note Added: 0002291                          
03-19-05 15:34 jdthood        Note Added: 0004053                          
03-22-06 03:40 rlrevell       Status                   new => closed       
03-22-06 03:40 rlrevell       Note Added: 0008830                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
