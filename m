From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000484]: Hercules MUSE Pocket, channels swapping randomly during playback
Date: Tue,  7 Sep 2004 17:54:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907155459.F33F5E05E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5F9B223E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 17:55:00 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000484
======================================================================
Reported By:                jone
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     484
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.4.23-cobalt3
======================================================================
Date Submitted:             09-06-2004 21:32 CEST
Last Modified:              09-07-2004 17:54 CEST
======================================================================
Summary:                    Hercules MUSE Pocket, channels swapping randomly during playback
Description: 
When my Hercules MUSE Pocket device is connected via a hub the  sound
channels swap back and forth randomly during playback.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-07-2004 17:44 CEST 
----------------------------------------------------------------------
Is this a USB 2.0 hub?

----------------------------------------------------------------------
 jone - 09-07-2004 17:54 CEST 
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-06-04 21:32 jone           New Bug                                      
09-06-04 21:32 jone           Distribution              => Debian unstable 
09-06-04 21:32 jone           Kernel Version            => 2.4.23-cobalt3  
09-07-04 17:44 Clemens LadischBugnote Added: 0001721                       
09-07-04 17:54 jone           Bugnote Added: 0001722                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
