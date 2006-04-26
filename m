From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002078]: Controls don't fully work for an ALC861
Date: Thu, 27 Apr 2006 00:44:07 +0200
Message-ID: <98ae7aac5dcfe05f96fef1415fdd86c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4F3D15C
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 00:44:07 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2078> 
======================================================================
Reported By:                arcee
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2078
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               FC5
Kernel Version:             2.6.17rc1
======================================================================
Date Submitted:             04-27-2006 00:44 CEST
Last Modified:              04-27-2006 00:44 CEST
======================================================================
Summary:                    Controls don't fully work for an ALC861
Description: 
This card comes with the Asus W5F laptop:

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1043:1263


The controls I get with amixer are:

Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 60 [24%]
  Front Right: Playback 60 [24%]
Simple mixer control 'Front',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 17 [74%] [on]
  Front Right: Playback 17 [74%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 1 [4%] [off]
  Front Right: Playback 1 [4%] [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 13
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'CD'
  Item0: 'Mic'


Mic control is working fine, but the front toggle and the PCM controls do
nothing (including mute); I have the output volume apparently stuck at
max.
The IEC958 toggle doesn't seem to be doing anything, either. At least, it
doesn't light up when unmuted (the IEC958 plug is shared with the
headphone jack)

 On load, dmesg shows:

hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

Please indicate what other information you need...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-06 00:44 arcee          New Issue                                    
04-27-06 00:44 arcee          Distribution              => FC5             
04-27-06 00:44 arcee          Kernel Version            => 2.6.17rc1       
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
