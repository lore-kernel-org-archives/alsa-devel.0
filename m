From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000904]: PCM volume sliders are
	Left-Right switched for all 3 analog outputs on Audigy2
	Platinum Pro ZS
Date: Tue, 18 Jul 2006 16:15:09 +0200
Message-ID: <5d72a6eef3a6b8df7a941bc3913df180@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C1DC198
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 16:15:09 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=904> 
======================================================================
Reported By:                riwright
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   904
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 3
Kernel Version:              2.6.10-1.741
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-12-2005 20:26 CET
Last Modified:              07-18-2006 16:15 CEST
======================================================================
Summary:                    PCM volume sliders are Left-Right switched for all 3
analog outputs on Audigy2 Platinum Pro ZS
Description: 
Using either the stereo PCM device (hw:0,0) or Lee Revell's multichannel
patch PCM device (hw:0,3), the volume control sliders
(gnome-volume-control) incorrectly control the L & R channels of the
soundcard's analog outputs (i.e. they are backward).

For example for the multichannel case (think 5.1 speaker setup), the PCM
Front LEFT slider controls the Stereo Output #1 RIGHT channel and vice
versa.  The PCM Surround LEFT slider controls the Stereo Output #2 RIGHT
channel and vice versa.  Finally, the PCM Center slider controls the
Stereo Output #3 RIGHT channel and the PCM LFE slider controls the Stereo
Output #3 LEFT channel....this is backwards too, the Center should be Left
and LFE Right.

Using the 2 channel stereo PCM (hw:0,0) the Front Left slider controls the
Stereo Output #1 RIGHT channel and vice versa.  The card's Stereo Output's
#2 & #3 are not available.
======================================================================

----------------------------------------------------------------------
 riwright - 07-18-06 15:33 
----------------------------------------------------------------------
I just noticed that this "bug" has been assigned.  I appologize for not
closing this issue sooner, but it simply fell off my radar screen.

There is no L/R problem with this driver on my card.  The problem ended up
being my cheap-ass stereo-to-RCA cable being L/R switched!  I confirmed
this several ways, including using a multi-meter to check the cable
against other known good cables and simply using typical PC speakers.

Previously I had attributed this weird behavior to the pcm_playback
channel mapping (which I determined empirically) for this card and never
thought maybe the cable was backwards....I thought there were standards
for this!

jcdutton: please don't spend any time on this!

Sorry for the noise,
Rick

----------------------------------------------------------------------
 jcdutton - 07-18-06 16:15 
----------------------------------------------------------------------
User reported problem solved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 20:26 riwright       New Issue                                    
02-12-05 20:26 riwright       Distribution              => Fedora Core 3   
02-12-05 20:26 riwright       Kernel Version            =>  2.6.10-1.741   
02-12-05 20:27 riwright       Issue Monitored: riwright                    
02-12-05 22:55 riwright       Note Added: 0003573                          
07-18-06 14:48 jcdutton       Status                   new => assigned     
07-18-06 14:48 jcdutton       Assigned To               => jcdutton        
07-18-06 15:33 riwright       Note Added: 0011061                          
07-18-06 16:15 jcdutton       Status                   assigned => closed  
07-18-06 16:15 jcdutton       Note Added: 0011063                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
