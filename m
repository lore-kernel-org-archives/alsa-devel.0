From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001178]: Headphone and Speaker volume control
Date: Sat, 16 Jul 2005 17:05:32 +0200
Message-ID: <bc24c0b73fe849e4ad61dd8b91e869a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EA3B192
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 17:05:32 +0200 (MEST)
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
Last Modified:              07-16-2005 17:05 CEST
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
 sgoodall - 07-11-05 18:21 
----------------------------------------------------------------------
That patch seems to work ok, however when using the gnome keyboard
shortcuts, it umutes the master contol when the volume changes.

Would it be possible to have a mute speakers instead of mute headphone
switch?

----------------------------------------------------------------------
 jdthood - 07-16-05 17:05 
----------------------------------------------------------------------
> That patch seems to work ok, however when using the gnome keyboard
> shortcuts, it umutes the master contol when the volume changes.

Please submit a bug report against the appropriate GNOME package, then.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 16:09 sgoodall       New Issue                                    
06-09-05 16:09 sgoodall       Distribution              => Fedora Core 3   
06-09-05 16:09 sgoodall       Kernel Version            =>
kernel-2.6.11-1.27_FC3
06-23-05 12:10 tiwai          Note Added: 0005177                          
07-07-05 11:30 sgoodall       Note Added: 0005398                          
07-08-05 11:51 tiwai          Note Added: 0005409                          
07-08-05 12:39 sgoodall       Note Added: 0005420                          
07-08-05 12:54 tiwai          Note Added: 0005421                          
07-08-05 12:55 tiwai          File Added: ac97-bind-hp-vol.diff                 
  
07-11-05 18:21 sgoodall       Note Added: 0005450                          
07-16-05 17:05 jdthood        Note Added: 0005498                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
