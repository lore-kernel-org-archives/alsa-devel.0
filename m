From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000566]: Doesn't save nor restore mixer settings (volumes set to 0)
Date: Wed,  6 Oct 2004 11:35:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006093515.30B431200A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 972CA2D9
	for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2004 11:35:15 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000566
======================================================================
Reported By:                pmatil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     566
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
======================================================================
Date Submitted:             10-05-2004 17:36 CEST
Last Modified:              10-06-2004 11:35 CEST
======================================================================
Summary:                    Doesn't save nor restore mixer settings (volumes set to 0)
Description: 
No error messages, init-scripts work but doesn't save nor restore mixer
settings. At boot, volumes are 0% but not muted. After setting the mixer
settings, doing alsactl store / alsactl restore works and actually saves
mixer settings to the default file. Still after boot/reboot settings have
been reset and also the file has been cleared (all volumes = 0). Card is
Terratec DMX Xfire 1024...(cs46xx)
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-2004 11:35 CEST 
----------------------------------------------------------------------
I doubt it's a driver problem if calling alsactl manually works...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:36 pmatil         New Bug                                      
10-05-04 17:36 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:36 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:35 tiwai          Bugnote Added: 0002020                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
