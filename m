From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000715]: pc speaker always routed through laptop speakers
Date: Wed, 8 Dec 2004 06:02:05 +0100
Message-ID: <d88f7846c8fd2e23da46eacf8b40a1e0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9B6D33BD
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 06:02:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=715> 
======================================================================
Reported By:                rafi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   715
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.9 (from source)
======================================================================
Date Submitted:             12-08-2004 06:02 CET
Last Modified:              12-08-2004 06:02 CET
======================================================================
Summary:                    pc speaker always routed through laptop speakers
Description: 
When the pc speaker driver is loaded, it always beeps through the laptop's
speakers, even when something is plugged into the headphone jack, or the
headphone jack on the docking station.

Also, if audio is being played through the other devices, it also switches
to the sspeakers for the duration of the beep.  And the beep is not
affected by any of the volume controlls.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-04 06:02 rafi           New Issue                                    
12-08-04 06:02 rafi           Distribution              => debian          
12-08-04 06:02 rafi           Kernel Version            => 2.6.9 (from source)
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
