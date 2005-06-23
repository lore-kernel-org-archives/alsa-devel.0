From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001178]: Headphone and Speaker volume control
Date: Thu, 23 Jun 2005 12:10:03 +0200
Message-ID: <997b4d0620b61ecbcd528058c7d28dbe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D908A164
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 12:10:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1178> 
======================================================================
Reported By:                sgoodall
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1178
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             kernel-2.6.11-1.27_FC3
======================================================================
Date Submitted:             06-09-2005 16:09 CEST
Last Modified:              06-23-2005 12:10 CEST
======================================================================
Summary:                    Headphone and Speaker volume control
Description: 
The master contol on this device does not affect the headphone speaker
socket volume. This is a problem for assigning keyboard shortcuts (using
gnome) to the voume controls as these get mapped to the master control. So
when using headphones (which I usually do) i cannot control the volume.
Ideally the master control can also affect the headphone volume, and have
a separate control for the main speakers. (I would like to be able to keep
these muted so sounds does not play should headphones not be plugged in
unless I explicitly enable them).
I am running fc3 on a dell inspiron 8500.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-23-05 12:10 
----------------------------------------------------------------------
First, please try the latest ALSA version.  This might have been already
fixed.

If not, you can pass "ac97_quirk=hp_only" option so that both master and
headphone volumes are bound together.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 16:09 sgoodall       New Issue                                    
06-09-05 16:09 sgoodall       Distribution              => Fedora Core 3   
06-09-05 16:09 sgoodall       Kernel Version            =>
kernel-2.6.11-1.27_FC3
06-23-05 12:10 tiwai          Note Added: 0005177                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
