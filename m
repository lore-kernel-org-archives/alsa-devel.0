From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000717]: MIDI input does not generate interrupts
Date: Thu, 9 Dec 2004 14:52:51 +0100
Message-ID: <a4ddb03ed242e3c376983d8e181eca5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A915222E
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2004 14:52:51 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-09-2004 14:52 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-09-04 14:52 pelzi          New Issue                                    
12-09-04 14:52 pelzi          Distribution              => Debian Sarge    
12-09-04 14:52 pelzi          Kernel Version            => 2.4.27          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
