From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001053]: cannot change line-in volume on MSI K8N Platinum that has SBLive! 24 bit
Date: Fri, 1 Jul 2005 20:00:45 +0200
Message-ID: <7caf949ba18b22a101e1831f90286fed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F196F1A8
	for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2005 20:00:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1053> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1053
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4 test 2
Kernel Version:             2.6.11-1.1236 FC4-x86_64 that contains 2.6.12rc2
======================================================================
Date Submitted:             04-14-2005 19:27 CEST
Last Modified:              07-01-2005 20:00 CEST
======================================================================
Summary:                    cannot change line-in volume on MSI K8N Platinum
that has SBLive! 24 bit
Description: 
I have a MSI K8N Platinum motherboard that has SBLive! 24 bit integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack in the pci version of the sb live 24
bit (see image).

The result is that I cannot use line-in for my soundcard becuase the
volume is 0 and I cannot change it.

The "Capture feedback into playback" in the mixer change the mic's volume.
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-01-05 14:48 
----------------------------------------------------------------------
Just to clarify. I have not yet added any volume control to the capture
features on this card yet. One either can capture sound or not. No volume
control. All capture volumes are set at 100%
The control to adjust for capture are:
Mic/Line in Capture  (up/down arrows to adjust)
i2s in (space bar to select)

These controls have only been tested with the SB Live 24bit with shared
mic/line in. I have no information on how to get separate controls
working.

When testing, try capture with:
arecord -fdat -Dhw:0,0
arecord -fdat -Dhw:0,1
arecord -fdat -Dhw:0,2
arecord -fdat -Dhw:0,3

You might find the mic on 0,0 and the line in on 0,1

----------------------------------------------------------------------
 Cimmo - 07-01-05 20:00 
----------------------------------------------------------------------
Ok,
my problem isn't recording now, but listening from line-in that is
separated from mic.
You don't have my motherboard, but can i provide to you some details to
make it work?

This is the question...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-05 19:27 Cimmo          New Issue                                    
04-14-05 19:27 Cimmo          File Added: MSIK8N.jpg                       
04-14-05 19:27 Cimmo          Distribution              => Fedora Core 4 test 2
04-14-05 19:27 Cimmo          Kernel Version            => 2.6.11-1.1236
FC4-x86_64 that contains 2.6.12rc2
04-14-05 21:42 jcdutton       Note Added: 0004495                          
04-14-05 21:42 jcdutton       Status                   assigned => acknowledged
05-11-05 15:05 Cimmo          Note Added: 0004636                          
05-14-05 13:14 pelias         Note Added: 0004657                          
05-14-05 15:48 jcdutton       Note Added: 0004659                          
05-20-05 00:14 dwh            Note Added: 0004697                          
05-28-05 12:16 jcdutton       Note Added: 0004764                          
05-28-05 12:16 jcdutton       Status                   acknowledged => feedback
05-30-05 12:57 Cimmo          Note Added: 0004805                          
05-30-05 12:58 Cimmo          File Added: alsamixer.jpg                    
05-30-05 14:33 jcdutton       Note Added: 0004814                          
05-30-05 14:56 Cimmo          Note Added: 0004816                          
05-30-05 14:57 Cimmo          Note Edited: 0004816                         
06-01-05 19:44 Cimmo          Note Added: 0004867                          
06-01-05 19:50 Cimmo          Note Edited: 0004867                         
07-01-05 14:03 Cimmo          Note Added: 0005332                          
07-01-05 14:48 jcdutton       Note Added: 0005334                          
07-01-05 20:00 Cimmo          Note Added: 0005336                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
