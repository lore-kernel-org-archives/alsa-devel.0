From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000377]: AudioTrak MAYA44 USB is detected, but doesn't work.
Date: Thu, 11 Nov 2004 09:22:47 +0100
Message-ID: <805b5f2812844a0b2fae706cdb3b3f14@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 206CC25C
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2004 09:22:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=377> 
======================================================================
Reported By:                TheMuso
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   377
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Slackware 10.0
Kernel Version:             2.4.26 and 2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-12-2004 05:56 CEST
Last Modified:              11-11-2004 09:22 CET
======================================================================
Summary:                    AudioTrak MAYA44 USB is detected, but doesn't work.
Description: 
With alsa-driver from latest CVS, this card is detected by hotplug, and
assigned to snd-usb-audio, however it is not detected and set up.
======================================================================

----------------------------------------------------------------------
 TheMuso - 11-10-04 22:36 
----------------------------------------------------------------------
Ok, changing the number to 11 allows the card to work properly. It now
appears in /proc/asound with all info regarding the card, and the playback
and capture devices. Alsamixer works, and I can even get sound through
it.

Thanks a lot Clemens, much appreciated.

I guess I have to close this bug now?

----------------------------------------------------------------------
 Clemens Ladisch - 11-11-04 09:22 
----------------------------------------------------------------------
Yes.  That is, not anymore. :-)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-04 05:56 TheMuso        New Issue                                    
07-12-04 05:56 TheMuso        Distribution              => Slackware 10.0  
07-12-04 05:56 TheMuso        Kernel Version            => 2.4.26 and 2.6.7
07-14-04 19:27 Clemens LadischNote Added: 0001418                          
07-15-04 00:42 TheMuso        Note Added: 0001422                          
07-15-04 08:59 Clemens LadischNote Added: 0001424                          
07-15-04 13:41 TheMuso        Note Added: 0001432                          
07-16-04 16:59 Clemens LadischNote Added: 0001453                          
07-17-04 03:03 TheMuso        Note Added: 0001455                          
08-15-04 12:14 TheMuso        Note Added: 0001567                          
08-20-04 11:18 Clemens LadischNote Added: 0001597                          
08-22-04 04:01 TheMuso        Note Added: 0001606                          
09-03-04 03:42 TheMuso        Note Added: 0001685                          
09-20-04 15:14 TheMuso        Note Added: 0001787                          
11-10-04 09:54 Clemens LadischFile Added: usb_logging.patch                    
11-10-04 09:56 Clemens LadischNote Added: 0002358                          
11-10-04 11:26 TheMuso        Note Added: 0002361                          
11-10-04 13:49 Clemens LadischNote Added: 0002372                          
11-10-04 22:36 TheMuso        Note Added: 0002378                          
11-11-04 09:22 Clemens LadischStatus                   assigned => resolved
11-11-04 09:22 Clemens LadischResolution               open => fixed       
11-11-04 09:22 Clemens LadischNote Added: 0002382                          
11-11-04 09:22 Clemens LadischStatus                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
