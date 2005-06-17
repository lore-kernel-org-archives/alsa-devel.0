From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001162]: no sound on speakers, low volume on the headphones
Date: Fri, 17 Jun 2005 14:20:03 +0200
Message-ID: <4f689f20d3d1af49a4a68c0976e56269@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A96FE177
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 14:20:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1162> 
======================================================================
Reported By:                Gildoniel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1162
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSe Linux 9.3 Professional
Kernel Version:             2.6.11.4.20a
======================================================================
Date Submitted:             06-06-2005 18:54 CEST
Last Modified:              06-17-2005 14:20 CEST
======================================================================
Summary:                    no sound on speakers, low volume on the headphones
Description: 
Problem diagnosis:
 
* Sound card is detected and automatically configured, but no sound can be
heard.
* It is possible to hear _faint_ sound (very low volume) through
headphones.
* Headphone volume is 0 and I can still hear low volume sound (maybe
master/headphone switched?)
* It seems to be possible to record voice on the microphone (I see the
amplitude when talking into the mic)
 
Solution attempts so far:
 
* used alsamixer to turn up and unmute all channels (failed: no sound on
speakers, very low volume on headphones)
* use the "quirk" option of the driver -1 through 7 (failed - no bettering
and error messages with certain settings)
* tried other sounddrivers (intel, via and others - didn't try them all)
(failed - error loading modules on those I tried)
======================================================================

----------------------------------------------------------------------
 Gildoniel - 06-17-05 11:54 
----------------------------------------------------------------------
Problem is with my system: Turning ACPI off crashes the system when running
in 64bit mode (so I have to do without sound). In 32bit mode I'm able to
boot the system and have sound with ACPI disabled, but that's no real fix
for the problem, as without ACPI many important functions for notebook
mobility won't work.
If there is any chance to get this fixed I'd very much appreciate it.

----------------------------------------------------------------------
 tiwai - 06-17-05 14:20 
----------------------------------------------------------------------
Since the APCI looks like the cause of this trouble, I'm afraid that this
isn't solvable in the ALSA driver itself.  Could you report this to ACPI
guys or kernel bugzilla?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 18:54 Gildoniel      New Issue                                    
06-06-05 18:54 Gildoniel      File Added: qta0733a.inf                     
06-06-05 18:54 Gildoniel      Distribution              => SuSe Linux 9.3
Professional
06-06-05 18:54 Gildoniel      Kernel Version            => 2.6.11.4.20a    
06-07-05 17:52 Gildoniel      Note Added: 0004913                          
06-08-05 14:35 tiwai          Note Added: 0004922                          
06-08-05 14:43 Gildoniel      File Added: asound.state                     
06-08-05 14:50 Gildoniel      File Added: proc-asound-card-codec97.txt          
         
06-08-05 14:52 Gildoniel      Note Added: 0004924                          
06-08-05 14:59 Gildoniel      Note Added: 0004927                          
06-08-05 15:08 tiwai          Note Added: 0004929                          
06-08-05 15:29 Gildoniel      Note Added: 0004933                          
06-08-05 15:31 Gildoniel      Note Added: 0004934                          
06-08-05 15:36 pzad           Note Added: 0004935                          
06-08-05 16:13 Gildoniel      Note Added: 0004948                          
06-08-05 16:21 pzad           Note Added: 0004949                          
06-08-05 16:39 Gildoniel      Note Added: 0004954                          
06-08-05 16:41 tiwai          Note Added: 0004955                          
06-08-05 16:42 pzad           Note Added: 0004956                          
06-08-05 16:43 tiwai          Note Added: 0004957                          
06-08-05 16:45 pzad           Note Added: 0004958                          
06-08-05 16:52 Gildoniel      Note Added: 0004959                          
06-08-05 16:57 pzad           Note Added: 0004960                          
06-08-05 17:03 tiwai          Note Added: 0004961                          
06-08-05 17:13 Gildoniel      Note Added: 0004963                          
06-08-05 17:31 Gildoniel      Note Added: 0004964                          
06-08-05 17:35 tiwai          Note Added: 0004965                          
06-08-05 18:03 Gildoniel      Note Added: 0004967                          
06-08-05 18:39 Gildoniel      Note Added: 0004970                          
06-17-05 11:54 Gildoniel      Note Added: 0005068                          
06-17-05 14:20 tiwai          Note Added: 0005069                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
