From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000484]: Hercules MUSE Pocket, channels swapping randomly during playback
Date: Tue, 9 Nov 2004 16:20:11 +0100
Message-ID: <310a3f59e02c053af765beaac486fce2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00941244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:20:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=484> 
======================================================================
Reported By:                jone
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   484
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable
Kernel Version:             2.4.23-cobalt3
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-06-2004 21:32 CEST
Last Modified:              11-09-2004 16:20 CET
======================================================================
Summary:                    Hercules MUSE Pocket, channels swapping randomly
during playback
Description: 
When my Hercules MUSE Pocket device is connected via a hub the  sound
channels swap back and forth randomly during playback.
======================================================================

----------------------------------------------------------------------
 jone - 09-07-04 17:54 
----------------------------------------------------------------------
It's just a simple el-cheapo passive 1.1 hub.

Bus 002 Device 002: ID 05e3:0604 Genesys Logic, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.01
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0604 
  bcdDevice            0.12
  iManufacturer           0 
  iProduct                1 
  iSerial                 0 
  bNumConfigurations      1

----------------------------------------------------------------------
 Clemens Ladisch - 09-08-04 11:18 
----------------------------------------------------------------------
Channel swapping occurs if the device receives an odd number of audio
samples.  The snd-usb-audio driver always sends an even number of samples
(the OSS driver, too), so it seems your hardware loses some data on the
way.

Apparently, there is an incompatibility between the Cobalt's USB
controller and the Genesys hub.  (There are many Genesys chips that have,
er, issues.)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-06-04 21:32 jone           New Issue                                    
09-06-04 21:32 jone           Distribution              => Debian unstable 
09-06-04 21:32 jone           Kernel Version            => 2.4.23-cobalt3  
09-07-04 17:44 Clemens LadischNote Added: 0001721                          
09-07-04 17:54 jone           Note Added: 0001722                          
09-08-04 11:18 Clemens LadischStatus                   assigned => resolved
09-08-04 11:18 Clemens LadischResolution               open => not an issue
09-08-04 11:18 Clemens LadischNote Added: 0001727                          
11-09-04 16:20 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
