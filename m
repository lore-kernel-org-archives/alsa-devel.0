From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000717]: MIDI input does not generate interrupts
Date: Fri, 10 Dec 2004 13:22:26 +0100
Message-ID: <56393064ba2fc96d0b7850c2e874c50a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9DB9B2C0
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 13:22:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=717> 
======================================================================
Reported By:                pelzi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   717
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.4.27
======================================================================
Date Submitted:             12-09-2004 14:52 CET
Last Modified:              12-10-2004 13:22 CET
======================================================================
Summary:                    MIDI input does not generate interrupts
Description: 
No high level midi events are generated, though raw midi events are
received. I.e. amidi -d produces results, but the corresponding
arecordmidi does not.
The possible cause, as suggested on the alsa-user mailing list, is that no
interrupts are generated on incoming midi events. In generel, the
soundcard does generate interrupts tough, e.g. on audio channel events.

======================================================================

----------------------------------------------------------------------
 tiwai - 12-09-04 15:27 
----------------------------------------------------------------------
It's a known problem.  The hardware doesn't behave like it's described in
the datasheet...

----------------------------------------------------------------------
 pelzi - 12-10-04 13:22 
----------------------------------------------------------------------
Any way I could help? Testing something, etc... I've seen some code pieces
in MIDI interrupt context commented out in es1938.c. I put them in again,
but it doesn't seem to make a difference.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-09-04 14:52 pelzi          New Issue                                    
12-09-04 14:52 pelzi          Distribution              => Debian Sarge    
12-09-04 14:52 pelzi          Kernel Version            => 2.4.27          
12-09-04 15:27 tiwai          Note Added: 0002802                          
12-10-04 13:22 pelzi          Note Added: 0002804                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
