From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000571]: Doesn't store mixer settings
Date: Tue, 12 Oct 2004 14:44:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012124403.1D85118009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5AB582D9
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:44:03 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000571
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     571
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-07-2004 18:27 CEST
Last Modified:              10-12-2004 14:44 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 18:27 pmatil         New Bug                                      
10-12-04 14:44 tiwai          Bugnote Added: 0002096                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
