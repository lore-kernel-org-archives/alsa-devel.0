From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000377]: AudioTrak MAYA44 USB is detected, but doesn't work.
Date: Wed, 10 Nov 2004 22:36:08 +0100
Message-ID: <fa667dd6f6c4e0c190237bbbe5427d38@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1432C236
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 22:36:08 +0100 (MET)
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
Status:                     assigned
Distribution:               Slackware 10.0
Kernel Version:             2.4.26 and 2.6.7
======================================================================
Date Submitted:             07-12-2004 05:56 CEST
Last Modified:              11-10-2004 22:36 CET
======================================================================
Summary:                    AudioTrak MAYA44 USB is detected, but doesn't work.
Description: 
With alsa-driver from latest CVS, this card is detected by hotplug, and
assigned to snd-usb-audio, however it is not detected and set up.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-10-04 13:49 
----------------------------------------------------------------------
In the file alsa-kernel/usb/usbmixer.c in the function
parse_audio_mixer_unit, replace 12 with 11, then it should work.

----------------------------------------------------------------------
 TheMuso - 11-10-04 22:36 
----------------------------------------------------------------------
Ok, changing the number to 11 allows the card to work properly. It now
appears in /proc/asound with all info regarding the card, and the playback
and capture devices. Alsamixer works, and I can even get sound through
it.

Thanks a lot Clemens, much appreciated.

I guess I have to close this bug now?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
