From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002321]: no audio and very few mixer
	options with C-Media 106 based USB sound card
Date: Sat, 5 Aug 2006 17:16:59 +0200
Message-ID: <7121bc37695e557479d2c086bb979636@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2764316A
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 17:17:00 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2321> 
======================================================================
Reported By:                doobedoobedo
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2321
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14/5
======================================================================
Date Submitted:             08-01-2006 16:43 CEST
Last Modified:              08-05-2006 17:16 CEST
======================================================================
Summary:                    no audio and very few mixer options with C-Media 106
based USB sound card
Description: 
no audio output with the snd-usb-audio module

amixer output:
Simple mixer control 'PCM',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4095
  Front Left: Capture 2048 [50%] [on]
  Front Right: Capture 2048 [50%] [on]
Simple mixer control 'PCM Capture Source',0
  Capabilities: enum
  Items: 'Mic' 'Input 1' 'Input 2' 'Mixer'
  Item0: 'Mic'
Simple mixer control 'PCM',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4095
  Front Left: Capture 2048 [50%]
  Front Right: Capture 2048 [50%]
Simple mixer control 'Mic',0
  Capabilities: pvolume cvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 8191 Capture 0 - 4095
  Front Left: Playback 2048 [25%] [off] Capture 2048 [50%]
  Front Right: Playback 2048 [25%] [off] Capture 2048 [50%]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 8191
  Mono:
  Front Left: Playback 2048 [25%] [on]
  Front Right: Playback 2048 [25%] [on]
Simple mixer control 'Speaker',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 37
  Mono: Playback 15 [41%] [on]

speaker 0 and mic will only decrease in volume in alsamixer, although no
sound is played trough the speakers at all.
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-04-06 02:06 
----------------------------------------------------------------------
You should add some printk()s to debug it.  First, verify that it is
recognizing your device and the USB id matches right.  Then, try changing
the usbmix_name_map table around.  For example create 10 entries and label
them "Master 1-10", etc.

----------------------------------------------------------------------
 doobedoobedo - 08-05-06 17:16 
----------------------------------------------------------------------
Good idea, the usb ids matched but the indexes in the map don't correspond
to those in asound.state (but I believe they correspond to the bUnitID as
output by lsusb -v ?) my patch ended up:

--- alsa-driver-1.0.11.orig/alsa-kernel/usb/usbmixer_maps.c     2006-03-16
08:25:56.000000000 +0000
+++ alsa-driver-1.0.11/alsa-kernel/usb/usbmixer_maps.c  2006-08-05
12:35:17.000000000 +0100
@@ -234,6 +234,13 @@
        { 0 } /* terminator */
 };

+/* C-Media 106 based card from Asound - hack to get only working volume
control marked as Master */
+static struct usbmix_name_map cm106_map[] = {
+       { 12, "Master Playback Switch"},
+       { 13, "Master Playback"},
+       { 0 } /* terminator */
+};
+
 /*
  * Control map entries
  */
@@ -276,6 +283,10 @@
                .id = USB_ID(0x0c45, 0x1158),
                .map = justlink_map,
        },
+       {
+               .id = USB_ID(0x0d8c, 0x0006),
+               .map = cm106_map,
+       },
        { 0 } /* terminator */
 };

Unfortunately mythtv still doesn't like it as it's a mono mixer and it
expects stereo :/. looks like I need to write an external volume control
script... which means I don't need the patch.

I have, however, learnt something :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-06 16:43 doobedoobedo   New Issue                                    
08-01-06 16:43 doobedoobedo   Distribution              => Gentoo          
08-01-06 16:43 doobedoobedo   Kernel Version            => 2.6.14/5        
08-01-06 16:51 doobedoobedo   Issue Monitored: doobedoobedo                    
08-01-06 16:54 doobedoobedo   Note Added: 0011376                          
08-03-06 03:40 doobedoobedo   Note Added: 0011393                          
08-03-06 17:34 doobedoobedo   Note Added: 0011404                          
08-03-06 19:15 rlrevell       Note Added: 0011407                          
08-03-06 20:32 doobedoobedo   Note Added: 0011408                          
08-03-06 20:37 rlrevell       Note Added: 0011409                          
08-03-06 23:02 doobedoobedo   Note Added: 0011410                          
08-03-06 23:13 rlrevell       Note Added: 0011411                          
08-04-06 00:58 doobedoobedo   Note Added: 0011412                          
08-04-06 01:21 rlrevell       Note Added: 0011413                          
08-04-06 01:31 rlrevell       Note Added: 0011414                          
08-04-06 01:54 doobedoobedo   Note Added: 0011415                          
08-04-06 02:06 rlrevell       Note Added: 0011416                          
08-05-06 17:16 doobedoobedo   Note Added: 0011438                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
