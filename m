From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000566]: Doesn't save nor restore mixer settings (volumes set to 0)
Date: Tue, 12 Oct 2004 14:49:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012124916.3B97118009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 708442D9
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:49:16 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000566
======================================================================
Reported By:                pmatil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     566
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
Resolution:                 duplicate
Duplicate:                  571
======================================================================
Date Submitted:             10-05-2004 17:36 CEST
Last Modified:              10-12-2004 14:49 CEST
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

----------------------------------------------------------------------
 pmatil - 10-07-2004 17:46 CEST 
----------------------------------------------------------------------
OK, so I should put this note into what category? The initscript somehow
resets the file that the mixer settings are in...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:36 pmatil         New Bug                                      
10-05-04 17:36 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:36 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:35 tiwai          Bugnote Added: 0002020                       
10-07-04 17:46 pmatil         Bugnote Added: 0002034                       
10-12-04 14:49 tiwai          duplicate_id             0 => 571            
10-12-04 14:49 tiwai          Assigned To               => tiwai           
10-12-04 14:49 tiwai          Resolution               open => duplicate   
10-12-04 14:49 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
