From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000566]: Doesn't save nor restore mixer settings (volumes set to 0)
Date: Fri, 12 Nov 2004 12:24:27 +0100
Message-ID: <16047d80ea4c2f0d0f209f76565d4de1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 86BD7263
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2004 12:24:27 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=566> 
======================================================================
Reported By:                pmatil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   566
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian GNU/Linux
Kernel Version:             2.4.22
Resolution:                 duplicate
Duplicate:                  571
Fixed in Version:           
======================================================================
Date Submitted:             10-05-2004 17:36 CEST
Last Modified:              11-12-2004 12:24 CET
======================================================================
Summary:                    Doesn't save nor restore mixer settings (volumes set
to 0)
Description: 
No error messages, init-scripts work but doesn't save nor restore mixer
settings. At boot, volumes are 0% but not muted. After setting the mixer
settings, doing alsactl store / alsactl restore works and actually saves
mixer settings to the default file. Still after boot/reboot settings have
been reset and also the file has been cleared (all volumes = 0). Card is
Terratec DMX Xfire 1024...(cs46xx)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000571 Doesn't store mixer settings
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-04 11:35 
----------------------------------------------------------------------
I doubt it's a driver problem if calling alsactl manually works...

----------------------------------------------------------------------
 pmatil - 10-07-04 17:46 
----------------------------------------------------------------------
OK, so I should put this note into what category? The initscript somehow
resets the file that the mixer settings are in...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-04 17:36 pmatil         New Issue                                    
10-05-04 17:36 pmatil         Distribution              => Debian GNU/Linux
10-05-04 17:36 pmatil         Kernel Version            => 2.4.22          
10-06-04 11:35 tiwai          Note Added: 0002020                          
10-07-04 17:46 pmatil         Note Added: 0002034                          
10-12-04 14:49 tiwai          Status                   new => resolved     
10-12-04 14:49 tiwai          Resolution               open => duplicate   
10-12-04 14:49 tiwai          Relationship added       duplicate of 0000571
10-12-04 14:49 tiwai          Assigned To               => tiwai           
10-26-04 16:12 chomwitt       Issue Monitored: chomwitt                    
11-12-04 12:24 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
