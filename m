From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000377]: AudioTrak MAYA44 USB is detected, but doesn't work.
Date: Wed, 10 Nov 2004 13:49:36 +0100
Message-ID: <5ffdfdbd138982a19ecae5c905fd02a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9F72620A
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 13:49:36 +0100 (MET)
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
Last Modified:              11-10-2004 13:49 CET
======================================================================
Summary:                    AudioTrak MAYA44 USB is detected, but doesn't work.
Description: 
With alsa-driver from latest CVS, this card is detected by hotplug, and
assigned to snd-usb-audio, however it is not detected and set up.
======================================================================

----------------------------------------------------------------------
 TheMuso - 11-10-04 11:26 
----------------------------------------------------------------------
Dmesg output:
usb.c: registered new driver snd-usb-audio
ALSA usbaudio.c:3186: probing 0a92:0091:0
ALSA usbaudio.c:3235: creating streams
ALSA usbaudio.c:2572: 2:1:1: add audio endpoint 0x1
ALSA usbaudio.c:2572: 2:2:1: add audio endpoint 0x82
ALSA usbaudio.c:3240: creating mixer
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 7
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 6
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 5
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 4
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 3
ALSA ../alsa-kernel/usb/usbmixer.c:506: checking source unit 3
ALSA ../alsa-kernel/usb/usbmixer.c:874: [4] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:635: min 0, max 255
ALSA ../alsa-kernel/usb/usbmixer.c:874: [4] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 2
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 1
ALSA ../alsa-kernel/usb/usbmixer.c:506: checking source unit 1
ALSA ../alsa-kernel/usb/usbmixer.c:874: [2] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:635: min 0, max 255
ALSA ../alsa-kernel/usb/usbmixer.c:874: [2] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1
ALSA ../alsa-kernel/usb/usbmixer.c:506: checking source unit 6
ALSA ../alsa-kernel/usb/usbmixer.c:874: [7] FU [Speaker Playback Switch]
ch = 1, val = 0/1/1
ALSA ../alsa-kernel/usb/usbmixer.c:635: min 0, max 255
ALSA ../alsa-kernel/usb/usbmixer.c:874: [7] FU [Speaker Playback Volume]
ch = 2, val = 0/255/1
ALSA ../alsa-kernel/usb/usbmixer.c:1458: parse_audio_unit 11
ALSA ../alsa-kernel/usb/usbmixer.c:1005: invalid mixer unit descriptor 11
ALSA usbaudio.c:3242: creating mixer failed
ALSA usbaudio.c:3263: error, exiting

----------------------------------------------------------------------
 Clemens Ladisch - 11-10-04 13:49 
----------------------------------------------------------------------
In the file alsa-kernel/usb/usbmixer.c in the function
parse_audio_mixer_unit, replace 12 with 11, then it should work.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
