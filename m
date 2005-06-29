From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001215]: AC3 Passthrough does not work
Date: Wed, 29 Jun 2005 20:23:01 +0200
Message-ID: <10d52801f2a63d388b82c0b3e58c4f59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8BF8219D
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 20:23:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1215> 
======================================================================
Reported By:                hugo4711
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1215
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC
======================================================================
Date Submitted:             06-27-2005 21:59 CEST
Last Modified:              06-29-2005 20:23 CEST
======================================================================
Summary:                    AC3 Passthrough does not work
Description: 
Since the update from FC3 to FC4 I am not able to use AC3-passthrough. It
won't work with xine or mplayer. 

The AC3-Reciever I am using indicates "No Audio" when playing a DVD with
AC3-Sound. Before the Update it switches to Dolby AC3 Decoding mode. 

When I play a movie with xine, and the driver is switched into
AC3-passthrough-mode and then I quit xine, the driver is not switched back
out of the passthrough-mode (which is a bug in xine, I guess). This is
very anoying, because there is no such thing as to reset the mixer
settings, unless the previous settings are stored (alsactl
store/restore).

Another thing is, that I am not able to hear sound from sources which are
plugged into line-in. Mixer Settings are checked. Every channel is unmuted
and volume is at 100%. Digital Out is unmuted, IEC-Compliancy is muted.
======================================================================

----------------------------------------------------------------------
 hugo4711 - 06-28-05 20:05 
----------------------------------------------------------------------
Here is some more information (if you need more, just ask me):

cat /proc/asound/version
------------------------
Advanced Linux Sound Architecture Driver Version 1.0.9rc2 (Thu Mar 24
10:33:39 2005 UTC).

cat /proc/asound/cards
----------------------
0 [Unknown ]: Audigy - Audigy 1 or 2 [Unknown]
                     Audigy 1 or 2 [Unknown] (rev.3, serial:0x511102) at
0xe800, irq 11
1 [Bt878 ]: Bt87x - Brooktree Bt878
                     Brooktree Bt878 at 0xdddfe000, irq 10

----------------------------------------------------------------------
 tiwai - 06-29-05 20:23 
----------------------------------------------------------------------
I guess this is already fixed with the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 21:59 hugo4711       New Issue                                    
06-27-05 21:59 hugo4711       Distribution              => Fedora Core 4   
06-27-05 21:59 hugo4711       Kernel Version            => 2.6.11-1.1369_FC
06-28-05 20:05 hugo4711       Note Added: 0005299                          
06-29-05 20:23 tiwai          Note Added: 0005312                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
