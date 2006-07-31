From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002299]: no manual volume control for
	Delta 1010 device (using ice1712)
Date: Mon, 31 Jul 2006 10:31:10 +0200
Message-ID: <6818c0fd5e85ab236b25b5cf0f28289a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BE74517E
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 10:31:10 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2299> 
======================================================================
Reported By:                Jarad
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2299
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-1.1369_FC
======================================================================
Date Submitted:             07-24-2006 07:02 CEST
Last Modified:              07-31-2006 10:31 CEST
======================================================================
Summary:                    no manual volume control for Delta 1010 device
(using ice1712)
Description: 
Using an M-audio delta 1010 device under Fedora Core 4 I am unable to
manually control the volume levels (individually or as a whole).
======================================================================

----------------------------------------------------------------------
 Jarad - 07-31-06 02:57 
----------------------------------------------------------------------
Sorry, I meant to get back to you all earlier...

Tried the envy24control program, with only limited success. The best
result I could achieve with it: I could only get the first two ports to
adjust manually  and the rest seemed to be some average volume of the
first two. This was achieved when setting the output controls to route to
the digital (main) mixer instead of the individual PCM Out#. This is an
improvement but still isn't adequate, I really need them all to work.

Looked at the website, that was quite good actually and will be useful
later as I will actually need mulitple Deltas (providing I can get one to
work).

Also looked at the manual for hardware info, and yeah, there's no direct
hardware volume control capabilities. Which I'm thinking would imply it
has to be controlled in software before the stream reaches the Delta 1010
hardware. 

I knew about alsactl but for all my fiddeling I couldn't result any
changes to the problem. Having said that though, from the result with the
envy24control (thanks for the tip by the way) I have a sneaking suspicion
it may have something to do with my configuration settings for the unit. I
dont know if anyone has it working for all output ports but could someone
post a known working/semi-working configuration perhaps?

Failing that I may just have to pull the envy24control program apart and
work out the right set of command calls, though that doesn't look like
it's going to be scalable to the rest of the outputs. :/

----------------------------------------------------------------------
 johnrigg - 07-31-06 10:31 
----------------------------------------------------------------------
You need to get rid of your existing .asoundrc. The Delta 1010 has a
hardware mixer, which is controlled digitally by envy24control. You should
not use dmix with this card. A single Delta 1010 should work perfectly
without any .asoundrc.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-06 07:02 Jarad          New Issue                                    
07-24-06 07:02 Jarad          Kernel Version            => 2.6.11-1.1369_FC
07-24-06 20:01 johnrigg       Note Added: 0011213                          
07-27-06 12:58 tiwai          Note Added: 0011269                          
07-27-06 20:32 johnrigg       Note Added: 0011278                          
07-31-06 02:57 Jarad          Note Added: 0011335                          
07-31-06 10:31 johnrigg       Note Added: 0011339                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
