From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000561]: Sound disappear
Date: Tue, 9 Nov 2004 16:45:15 +0100
Message-ID: <486c969a3ae9960e288252a32fd39d4d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3D4071EF
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:45:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=561> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   561
Category:                   PCI - ice1724
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-03-2004 02:22 CEST
Last Modified:              11-09-2004 16:45 CET
======================================================================
Summary:                    Sound disappear
Description: 
Sometimes, at completely random occasions, all sound suddently disappear.
At rare occasions, the sound will appear again shortly after, at first at
very low, but then again at full volume.
It may often go days before the problem occurs, and then sometimes it
happens all the time.

I've attempted to do some researching myself, and I quickly noticed that
by just reinitializing the WM8770 chip with a user-space program, the
sound would reappear, but then again I noticed that the CS8415A chip is
disabled when it happens (apparently this is the only chip besides the
ICE1724 that you may actually read from).
The STAC9744 is apparently also reset as the volume must be changed in the
mixer before any sound can come from there.

The few times the whole thing occour while I am not listening to music,
I've noticed that you actually hear the click from the headphone relay, so
I think that this whole issue is related to some improper handeling of the
GPIO pins. If they are all switched to zero at some point, this would
reset all chips connected to the ICE1724, however, I tried adding debug
info every time a GPIO related function was called, but there never was
any such debug message prior to the fault.

Natually it is extremely difficult to fix such a problem when it is as
random as it is. Actually when using the 4Front OSS drivers, I've
sometimes experienced the same thing, however their drivers aren't
flawless either, I imagine. In fact, when I at first got the card, I
thought it was broken, since the ALSA drivers produced no sound (reversed
volume control etc.) and the OSS only worked for a couple of minutes until
all sound disappeared. At all time, the optical output was fully
functional.

Anyway, I do not expect to see the problem solved just like that, and I
intend to continue attempting to resolve the bug myself. It would however
be nice to know whether I am the only one at all experiencing the problem,
as it may in fact then be a hardware problem or (though most unlikely) a
conflict between existing hardware.

The problem occur on all versions of ALSA starting from 1.0.5 (haven't
tried anyone older than that) and including the latest CVS (synchronize
often and compile daily as I am also working on other issues and lacking
features of the ice1724)
======================================================================

----------------------------------------------------------------------
 ungod - 10-03-04 02:23 
----------------------------------------------------------------------
Oh, completly forgot to mention.

The card is a Terratec Aureon 7.1 Space (PCB rev. 1.4)

And I haven't tried the Windows drivers (no Windows installed) so I can't
say if they're better

----------------------------------------------------------------------
 ungod - 10-08-04 20:38 
----------------------------------------------------------------------
Hmm... Now the relay is permanently dead. And I did some testing in Windows
and some other machines with the same result. Apparently it is my
hardware. When I looked at the card, I DID notice that the 7805 (5V
regulator) IC looked somewhat burned. I imagine that it supplied the
nessesary voltage to drive the relay or something.

So the bug can be closed, as it was not ALSA related.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 02:22 ungod          New Issue                                    
10-03-04 02:23 ungod          Note Added: 0002008                          
10-08-04 20:38 ungod          Note Added: 0002057                          
10-12-04 14:41 tiwai          Status                   new => resolved     
10-12-04 14:41 tiwai          Resolution               open => not an issue
10-12-04 14:41 tiwai          Assigned To               => tiwai           
11-09-04 16:45 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
