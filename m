From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000377]: AudioTrak MAYA44 USB is detected, but doesn't work.
Date: Wed, 10 Nov 2004 09:56:13 +0100
Message-ID: <70486906c251997eff4eeddf42af4f05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 25C74196
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 09:56:14 +0100 (MET)
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
Last Modified:              11-10-2004 09:56 CET
======================================================================
Summary:                    AudioTrak MAYA44 USB is detected, but doesn't work.
Description: 
With alsa-driver from latest CVS, this card is detected by hotplug, and
assigned to snd-usb-audio, however it is not detected and set up.
======================================================================

----------------------------------------------------------------------
 TheMuso - 09-20-04 15:14 
----------------------------------------------------------------------
Tried again with latest CVS, just to see whether anything may have changed
to allow the card to load properly. Got the same sort of output as above,
but noticed something with the dmesg output:

ALSA ../alsa-kernel/usb/usbmixer.c:866: [4] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:866: [4] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1
ALSA ../alsa-kernel/usb/usbmixer.c:866: [2] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:866: [2] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1
ALSA ../alsa-kernel/usb/usbmixer.c:866: [7] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:866: [7] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1

The card has 4 inputs and outputs. Do these lines indicate that all inputs
and outputs are initialized or not?

----------------------------------------------------------------------
 Clemens Ladisch - 11-10-04 09:56 
----------------------------------------------------------------------
It seems the driver aborts while parsing the descriptors for the mixer
controls.

Please apply the patch and recompile with --with-debug=detect, then show
the dmesg output.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
