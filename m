From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000571]: Doesn't store mixer settings
Date: Thu, 18 Nov 2004 18:10:20 +0100
Message-ID: <caa524162eceff5d66a65bf9a2dbaf8a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 52F07230
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 18:10:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=571> 
======================================================================
Reported By:                pmatil
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   571
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-07-2004 18:27 CEST
Last Modified:              11-18-2004 18:10 CET
======================================================================
Summary:                    Doesn't store mixer settings
Description: 
No errors are produced by the initscripts, however it seems that it doesn't
save mixer settings. After boot, asound.state is 'zeroed' eg. all sliders
are down, but unmuted. Running manually alsactl store, asound.state gets
all the right values, but after next boot / reboot, asound.state is
'zeroed' again. Asound.state lies in /var/lib/alsa/asound.state
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000566 Doesn't save nor restore mixer settings...
======================================================================

----------------------------------------------------------------------
 pmatil - 10-15-04 13:51 
----------------------------------------------------------------------
Mkay, after compiling with cs46xx_new_dsp, everything works. Volumes are
saved and restored and KDE doesn't overwrite them. I don't know was it
because of cs46xx_new_dsp or the fact that I unchecked the box "save
volumes" in kmix.

----------------------------------------------------------------------
 tiwai - 10-18-04 17:42 
----------------------------------------------------------------------
Ok, now I close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 18:27 pmatil         New Issue                                    
10-12-04 14:44 tiwai          Note Added: 0002096                          
10-12-04 14:49 tiwai          Relationship added       has duplicate 0000566
10-13-04 12:30 pmatil         Note Added: 0002120                          
10-13-04 12:53 tiwai          Note Added: 0002121                          
10-14-04 13:25 pmatil         Note Added: 0002144                          
10-14-04 15:14 tiwai          Note Added: 0002149                          
10-14-04 16:26 pmatil         Note Added: 0002154                          
10-15-04 13:51 pmatil         Note Added: 0002166                          
10-18-04 17:42 tiwai          Status                   new => resolved     
10-18-04 17:42 tiwai          Resolution               open => not an issue
10-18-04 17:42 tiwai          Assigned To               => tiwai           
10-18-04 17:42 tiwai          Note Added: 0002195                          
11-18-04 18:10 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
