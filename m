From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000927]: Support for Creative SB Audigy 2 ZS Notebook
Date: Mon, 31 Oct 2005 12:43:01 +0100
Message-ID: <307f1ceba06d14ca2fb7fb507866a1ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 830BF13A
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 12:43:01 +0100 (MET)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=927> 
======================================================================
Reported By:                gflash
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   927
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-20-2005 08:53 CET
Last Modified:              10-31-2005 12:43 CET
======================================================================
Summary:                    Support for Creative SB Audigy 2 ZS Notebook
Description: 
Is this PCMCIA Souncard supported or will it be supported in the next time?
I haven't heard any positive reports yet...

Thank you!
======================================================================

----------------------------------------------------------------------
 jcdutton - 02-20-05 12:32 
----------------------------------------------------------------------
No support yet. I need someone to donate a card to me, so that I can
reverse engineer it.

----------------------------------------------------------------------
 gflash - 02-20-05 14:06 
----------------------------------------------------------------------
Any idea how long it usualy takes until someone donate such a card? I don't
have have enough money for two cards (one for me, one for you :), but if
there would be some more people to share the costs, i would spend about
20-30 Euro. It costs about 110 Euro in Germany.

I'm really interested in this card :)

----------------------------------------------------------------------
 jcdutton - 02-20-05 14:47 
----------------------------------------------------------------------
Get my email address from the source code of the ca0106 driver.
The card cost about 90 (UK pounds) here.
I already have 10 donated.
Any you add would help toward getting this card.



----------------------------------------------------------------------
 dale - 07-25-05 17:43 
----------------------------------------------------------------------
Hi, i was just wondering what the status of this is?
I see from the card matrix:

"Card delivered to developers. Bug found in Linux Kernel PCMCIA code, but
bug fix not found yet."

Are the linux kernel PCMCIA developers aware of this bug?

Thanks,

Dale

----------------------------------------------------------------------
 jcdutton - 10-30-05 21:08 
----------------------------------------------------------------------
Updated Status: alsa CVS 30-10-2005

The Audigy2 ZS Notebook no longer crashes the kernel.
The card is now properly recognised.
TODO: The sound is badly distorted, so more work need to be done to fix
that.

----------------------------------------------------------------------
 buckvitulli - 10-31-05 00:55 
----------------------------------------------------------------------
Outstanding work, I appreciate your efforts.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-20-05 08:53 gflash         New Issue                                    
02-20-05 12:32 jcdutton       Note Added: 0003673                          
02-20-05 14:06 gflash         Note Added: 0003674                          
02-20-05 14:39 jcdutton       Note Added: 0003675                          
02-20-05 14:47 jcdutton       Note Edited: 0003675                         
07-25-05 17:43 dale           Note Added: 0005564                          
07-31-05 03:52 buckvitulli    Issue Monitored: buckvitulli                    
08-01-05 01:03 jpeak          Issue Monitored: jpeak                       
10-30-05 21:08 jcdutton       Note Added: 0006577                          
10-31-05 00:55 buckvitulli    Note Added: 0006578                          
10-31-05 12:43 jcdutton       Status                   new => assigned     
10-31-05 12:43 jcdutton       Assigned To               => jcdutton        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
