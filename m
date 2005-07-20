From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001259]: Audigy 4 Pro (SB0380) with ALSA 1.0.9rc2 - no sound from AUX in
Date: Wed, 20 Jul 2005 05:32:58 +0200
Message-ID: <2f46d74aab693e1dc5716d5573681dbc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EEB61BC
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2005 05:32:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1259> 
======================================================================
Reported By:                iq79
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1259
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.12-gentoo-r1
======================================================================
Date Submitted:             07-15-2005 18:18 CEST
Last Modified:              07-20-2005 05:32 CEST
======================================================================
Summary:                    Audigy 4 Pro (SB0380) with ALSA 1.0.9rc2 - no sound
from AUX in
Description: 
I am unable to unmute the internal AUX-in header of my Audigy4Pro.

- I played around with all (Playback/Capture) mixer settings in alsamixer
but I couldn't find a configuration which gives me sound from AUX-in.

- I tried loading emu10k1 module with several extin/exout combinations.
That didn't help, too.
======================================================================

----------------------------------------------------------------------
 iq79 - 07-16-05 18:38 
----------------------------------------------------------------------
Unmuting "Line" or "Line2" doesn't help.
I've uploaded the output from amixer.

----------------------------------------------------------------------
 jcdutton - 07-20-05 05:32 
----------------------------------------------------------------------
I will look at this in a few weeks time, as I am away from home at the
moment.
I have an Audigy4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-05 18:18 iq79           New Issue                                    
07-15-05 18:18 iq79           Distribution              => Gentoo Linux    
07-15-05 18:18 iq79           Kernel Version            => 2.6.12-gentoo-r1
07-15-05 19:49 pzad           Note Added: 0005483                          
07-15-05 19:50 pzad           Note Edited: 0005483                         
07-15-05 23:40 iq79           Note Added: 0005484                          
07-16-05 16:31 jdthood        Note Added: 0005496                          
07-16-05 18:36 iq79           File Added: amixer_output                    
07-16-05 18:38 iq79           Note Added: 0005500                          
07-20-05 05:32 jcdutton       Note Added: 0005532                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
