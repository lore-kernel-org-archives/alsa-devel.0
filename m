From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000203]: Line-In is not working with ICH - Intel ICH5 Intel8x0
Date: Thu, 10 Mar 2005 15:30:01 +0100
Message-ID: <526af61bd9bc8ae3b6bc38e22e87f2ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9A1DF1D5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 15:30:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=203> 
======================================================================
Reported By:                dkg
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   203
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Crux Linux
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-12-2004 20:16 CEST
Last Modified:              03-10-2005 15:30 CET
======================================================================
Summary:                    Line-In is not working with ICH - Intel ICH5
Intel8x0
Description: 
 Today I upgraded to 2.6.5 because I thought it may help me in solving my
problem with my soundcard. But it doesnt. It still exists. Mic and
Line-Out are ok. But my Line-In is not working. I need it to record sound
which comes from my turntables. Following are some informations about my
card. It would be great if someone could help me.
======================================================================

----------------------------------------------------------------------
 Voluspa - 04-13-04 10:53 
----------------------------------------------------------------------
Card: Intel 82801BA-ICH2
Chip: Realtek ALC200/200P rev 0

Same problem here. In kernel 2.6.4 both channels (left - right) on line-in
were dead. In kernel 2.6.5 only the right channel is dead; if indeed we
can talk about channels. Could as well be mono coming from the left
speaker, don't know.

edited on: 04-13-04 10:53

----------------------------------------------------------------------
 jdthood - 03-10-05 15:30 
----------------------------------------------------------------------
Submitter: Was this problem fixed in more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-04 20:16 dkg            New Issue                                    
04-12-04 20:16 dkg            Distribution              => Crux Linux      
04-12-04 20:16 dkg            Kernel Version            => 2.6.5           
04-13-04 10:51 Voluspa        Note Added: 0000787                          
04-13-04 10:53 Voluspa        Note Edited: 0000787                         
03-10-05 15:30 jdthood        Note Added: 0003865                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
