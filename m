From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000715]: pc speaker always routed through laptop speakers
Date: Tue, 12 Apr 2005 16:48:51 +0200
Message-ID: <d129ca33ab3e2e491651ce2089a72eda@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C5FC27C
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 16:48:52 +0200 (MEST)
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
Status:                     acknowledged
Distribution:               debian
Kernel Version:             2.6.9 (from source)
======================================================================
Date Submitted:             12-08-2004 06:02 CET
Last Modified:              04-12-2005 16:48 CEST
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

----------------------------------------------------------------------
 rafi - 04-09-05 21:03 
----------------------------------------------------------------------
Sorry, I missed the note about the registers earlier.
I've retested with:
drive: 1.0.9rc2
lib: 1.0.8
kernel: 2.6.11.6

twiddled the mixer settings for a while

And I see no change, beeps still coming from the laptop speakers.

Should I have pcspkr loaded or not?

----------------------------------------------------------------------
 tiwai - 04-12-05 16:48 
----------------------------------------------------------------------
Did you try to turn off "Master Mono"?

If the beep volume can't change via "PC Speaker" mixer volume, it means
that the signal is not routed through AC97.  It's not controllable without
an (unknown) initialization.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-04 06:02 rafi           New Issue                                    
12-08-04 06:02 rafi           Distribution              => debian          
12-08-04 06:02 rafi           Kernel Version            => 2.6.9 (from source)
12-08-04 12:12 tiwai          Note Added: 0002778                          
04-09-05 17:21 jdthood        Note Added: 0004421                          
04-09-05 20:58 rafi           Issue Monitored: rafi                        
04-09-05 21:00 rafi           File Added: ac97#0-0                         
04-09-05 21:00 rafi           File Added: ac97#0-0+regs                    
04-09-05 21:01 rafi           File Added: asound.state                     
04-09-05 21:03 rafi           Note Added: 0004429                          
04-09-05 22:03 jdthood        Status                   new => acknowledged 
04-12-05 16:48 tiwai          Note Added: 0004451                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
