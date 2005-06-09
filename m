From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001178]: Headphone and Speaker volume control
Date: Thu, 9 Jun 2005 16:09:57 +0200
Message-ID: <3a189eac33eb35cee7f12b71cc5eb789@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF3FA1CC
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 16:09:57 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              06-09-2005 16:09 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-05 16:09 sgoodall       New Issue                                    
06-09-05 16:09 sgoodall       Distribution              => Fedora Core 3   
06-09-05 16:09 sgoodall       Kernel Version            =>
kernel-2.6.11-1.27_FC3
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
