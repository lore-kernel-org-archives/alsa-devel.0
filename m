From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000138]: Not sound although device is correctly detected...
Date: Sun, 19 Dec 2004 15:16:35 +0100
Message-ID: <0cf51c3965b1ea17f435778ad851cd50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF11F2D3
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 15:16:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=138> 
======================================================================
Reported By:                Eric Valette
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   138
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian sid
Kernel Version:             2.6.4-mm2
======================================================================
Date Submitted:             03-15-2004 13:57 CET
Last Modified:              12-19-2004 15:16 CET
======================================================================
Summary:                    Not sound although device is correctly detected...
Description: 
On 2.4, I was using the built-in driver and it worked nicely. On 2.6, I'm
forced to use the 2.6 and get no sound. NB : I have started the ALSAMIXER
and set output level to speaker to non zero...
======================================================================

----------------------------------------------------------------------
 Eric Valette - 03-15-04 17:51 
----------------------------------------------------------------------
I managed to make it work in 2.6.4-mm2 today. So apparently it is fixed in
the last bk tree. You can close it.

Side note : The speakers are muted by default which may lead to trouble
when volume are not zero...

BTW I have an Oops in the intel8x0M modem driver due to null ponter
dereference.
I must fill another bug report...

----------------------------------------------------------------------
 Eric Valette - 12-19-04 15:16 
----------------------------------------------------------------------
Please close this bug : it works now

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 13:57 Eric Valette   New Issue                                    
03-15-04 13:57 Eric Valette   Distribution              => debian sid      
03-15-04 13:57 Eric Valette   Kernel Version            => 2.6.4-mm2       
03-15-04 17:41 perex          Note Added: 0000617                          
03-15-04 17:51 Eric Valette   Note Added: 0000619                          
12-19-04 15:16 Eric Valette   Note Added: 0002849                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
