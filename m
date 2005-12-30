From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001266]: Does not detect my sound card as valid
Date: Fri, 30 Dec 2005 23:55:31 +0100
Message-ID: <71b060ebb4e5f412cdc89426b3435744@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3001168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:55:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1266> 
======================================================================
Reported By:                darins
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1266
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             
======================================================================
Date Submitted:             07-19-2005 06:37 CEST
Last Modified:              12-30-2005 23:55 CET
======================================================================
Summary:                    Does not detect my sound card as valid
Description: 
I have an AudioTrak Prodigy 7.1LT sound card.  Modprobing ice-1724 produces
the following output in /var/log/messages:

Jul 18 23:24:45 coruscant kernel: ice1724: No matching model found for ID
0x32315441
Jul 18 23:24:45 coruscant kernel: ice1724: Invalid EEPROM (size = 120)
Jul 18 23:24:45 coruscant kernel: ICE1724: probe of 0000:00:06.0 failed
with error -5

It looks like the driver just can't identify my card.
I upgraded to the latest driver available from atrpms, but got the same
error.

aplay -l doesn't show any devices from this soundcard available, though
lsmod shows the module loaded and using all the normal stuff.

======================================================================

----------------------------------------------------------------------
 darins - 07-19-05 06:39 
----------------------------------------------------------------------
uname -a output:

Linux coruscant 2.6.11-1.27_FC3 #1 Tue May 17 20:27:37 EDT 2005 i686
athlon i386 GNU/Linux

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:55 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-05 06:37 darins         New Issue                                    
07-19-05 06:37 darins         Distribution              => Fedora Core 3   
07-19-05 06:38 darins         Issue Monitored: darins                      
07-19-05 06:39 darins         Note Added: 0005525                          
12-30-05 23:55 rlrevell       Note Added: 0007304                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
