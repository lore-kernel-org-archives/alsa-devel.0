From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000571]: Doesn't store mixer settings
Date: Mon, 18 Oct 2004 17:42:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018154251.8FD6D11032@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D0B7B2C2
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2004 17:42:51 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000571
======================================================================
Reported By:                pmatil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Bug ID:                     571
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not a bug
======================================================================
Date Submitted:             10-07-2004 18:27 CEST
Last Modified:              10-18-2004 17:42 CEST
======================================================================
Summary:                    Doesn't store mixer settings
Description: 
No errors are produced by the initscripts, however it seems that it doesn't
save mixer settings. After boot, asound.state is 'zeroed' eg. all sliders
are down, but unmuted. Running manually alsactl store, asound.state gets
all the right values, but after next boot / reboot, asound.state is
'zeroed' again. Asound.state lies in /var/lib/alsa/asound.state
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:44 CEST 
----------------------------------------------------------------------
Is alsactl patched?  It's usually in /etc/asound.state.

asound.state is saved when alsasound init service is stopped, too.
This means that the status of sound differs at this stage from
what you have now.  Possibly, the window system (e.g. KDE) modifies
and restores the sound status by itself.

----------------------------------------------------------------------
 pmatil - 10-13-2004 12:30 CEST 
----------------------------------------------------------------------
It's possible. System is Debian so maybe it's patched. It doesn't matter
whether I start X (KDE) or not, sound levels aren't saved by the init
script. I don't know where alsa thinks it saved the volume levels, because
I don't know much of init scripting and it gives no error. So maybe this
is mainly a Debian problem...

----------------------------------------------------------------------
 tiwai - 10-13-2004 12:53 CEST 
----------------------------------------------------------------------
Check the init script you use.  The alsasound script provided from the
original alsa-driver package uses /etc/asound.state, and call with -f
option.

----------------------------------------------------------------------
 pmatil - 10-14-2004 13:25 CEST 
----------------------------------------------------------------------
OK, update: I noticed that after updating alsa-packages from apt, the
init.script actually does save the volumes, and restore them
(/var/lib/alsa/asound.state), but after starting KDE, volumes are zeroed
(amixer). Asound.state at this point contains the saved settings. So: KDE
resets the volumes at its startup but doesn't modify asound.state. Sorry I
haven't noticed this earlier... Now I have to find out how to prevent it
from resetting the volumes or find a way to run 'alsactl restore' after
KDE startup...

----------------------------------------------------------------------
 tiwai - 10-14-2004 15:14 CEST 
----------------------------------------------------------------------
Ok, then it's likely a problem of KDE thing.  I guess it's kmix.
What happens if you exclude kmix from start up apps?

----------------------------------------------------------------------
 pmatil - 10-14-2004 16:26 CEST 
----------------------------------------------------------------------
Kmix doesn't start automatically... So it's something else.

----------------------------------------------------------------------
 pmatil - 10-15-2004 13:51 CEST 
----------------------------------------------------------------------
Mkay, after compiling with cs46xx_new_dsp, everything works. Volumes are
saved and restored and KDE doesn't overwrite them. I don't know was it
because of cs46xx_new_dsp or the fact that I unchecked the box "save
volumes" in kmix.

----------------------------------------------------------------------
 tiwai - 10-18-2004 17:42 CEST 
----------------------------------------------------------------------
Ok, now I close this bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 18:27 pmatil         New Bug                                      
10-12-04 14:44 tiwai          Bugnote Added: 0002096                       
10-13-04 12:30 pmatil         Bugnote Added: 0002120                       
10-13-04 12:53 tiwai          Bugnote Added: 0002121                       
10-14-04 13:25 pmatil         Bugnote Added: 0002144                       
10-14-04 15:14 tiwai          Bugnote Added: 0002149                       
10-14-04 16:26 pmatil         Bugnote Added: 0002154                       
10-15-04 13:51 pmatil         Bugnote Added: 0002166                       
10-18-04 17:42 tiwai          Assigned To               => tiwai           
10-18-04 17:42 tiwai          Resolution               open => not a bug   
10-18-04 17:42 tiwai          Status                   new => resolved     
10-18-04 17:42 tiwai          Bugnote Added: 0002195                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
