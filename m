From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001178]: Headphone and Speaker volume control
Date: Fri, 8 Jul 2005 11:51:27 +0200
Message-ID: <82ce729a6783dd1d1e7b7ffcacbaa4b1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65DB818A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 11:51:27 +0200 (MEST)
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
Last Modified:              07-08-2005 11:51 CEST
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
 sgoodall - 07-07-05 11:30 
----------------------------------------------------------------------
I've just upgraded to fc4 which has alsa 1.0.9. The problem is still in
this version.
Making the master and headphone control do the same thing is not quite the
behaviour I would like.
I would still like to be able to make sure the main speakers are muted
should say I forget to plug headphones in.

----------------------------------------------------------------------
 tiwai - 07-08-05 11:51 
----------------------------------------------------------------------
Sorry, I don't understand your request.  Please describe more clearly?

Does the hardware switch (mute/unmute) the speaker volume when you plug in
HP jack?  Or you have to turn on/off mixer switch (which) manually?
In the former case, ac97_quirk=hp_only should suffice.  I don't want to
implemenet a separate HP volume.  In the latter case, we'll need a code to
handle the ac97 jack detection, which is sitll missing.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
