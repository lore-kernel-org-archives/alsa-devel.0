From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000717]: MIDI input does not generate interrupts
Date: Thu, 16 Dec 2004 18:40:22 +0100
Message-ID: <7c23ec856adfc48b7d0e6a27619a8014@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DF171249
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:40:22 +0100 (MET)
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
Last Modified:              12-16-2004 18:40 CET
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
 pelzi - 12-10-04 15:16 
----------------------------------------------------------------------
I appended a patch that works for me. As you can see, I activated 2 of 3
code regions that were commented out before. Unfortunately, no reason was
given why the code was commented out, so I don't know if it had any
undesirable side effects.

----------------------------------------------------------------------
 tiwai - 12-16-04 18:40 
----------------------------------------------------------------------
IIRC, got some lock-up when they were enabled.  But the test was quite ago.
 So, maybe it'd be safer to add a module option to enable/disable the MIDI
support.

BTW, don't forget to add signed-off-by line and summary/description of the
patch (as described in News).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-09-04 14:52 pelzi          New Issue                                    
12-09-04 14:52 pelzi          Distribution              => Debian Sarge    
12-09-04 14:52 pelzi          Kernel Version            => 2.4.27          
12-09-04 15:27 tiwai          Note Added: 0002802                          
12-10-04 13:22 pelzi          Note Added: 0002804                          
12-10-04 14:38 Clemens LadischNote Added: 0002805                          
12-10-04 15:14 pelzi          File Added: es1938_c_MIDI_Patches.diff            
       
12-10-04 15:16 pelzi          Note Added: 0002806                          
12-16-04 18:40 tiwai          Note Added: 0002837                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
