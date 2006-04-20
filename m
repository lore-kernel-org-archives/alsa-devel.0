From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002027]: No sound on AD1986A (ASUS Laptop, Z62F)
Date: Thu, 20 Apr 2006 14:47:05 +0200
Message-ID: <19ce7dc01196d78e57f21f16269e3e53@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF0E31A8
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 14:47:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2027> 
======================================================================
Reported By:                jaidormi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2027
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.16-gentoo-r2
======================================================================
Date Submitted:             04-17-2006 08:00 CEST
Last Modified:              04-20-2006 14:47 CEST
======================================================================
Summary:                    No sound on AD1986A (ASUS Laptop, Z62F)
Description: 
Actually I am using 1.0.11rc5

I am unable to get any sound output on speakers or headphone jack.  Oddly,
it seems that the IEC958 output works (shared with headphone jack), based
on the fact that it lights up when un-muted.

I have tried a number of model= and position_fix= options with no luck.

On this machine there is a set of stereo speakers, a line-in, mic, and
shared sp-dif/headphone jack.

Is there any output or system info I can provide to help?
======================================================================

----------------------------------------------------------------------
 jaidormi - 04-17-06 08:15 
----------------------------------------------------------------------
OK, set model=asus.

amixer output:

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31  Mono:
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [on]
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'Phone',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 15
  Mono:
  Front Left: Playback 15 [100%] [off]
  Front Right: Playback 15 [100%] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 31 [100%] [off]
  Front Right: Playback 31 [100%] [off]
Simple mixer control 'Mono',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 29 [94%] [off]
  Front Right: Playback 29 [94%] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 0 [0%] [off]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Stereo Downmix',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]

----------------------------------------------------------------------
 tiwai - 04-20-06 14:47 
----------------------------------------------------------------------
Try model=asus-eapd instead.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-06 08:00 jaidormi       New Issue                                    
04-17-06 08:00 jaidormi       Distribution              => Gentoo          
04-17-06 08:00 jaidormi       Kernel Version            => 2.6.16-gentoo-r2
04-17-06 08:04 rlrevell       Note Added: 0009305                          
04-17-06 08:08 jaidormi       Note Added: 0009306                          
04-17-06 08:15 jaidormi       Note Added: 0009307                          
04-17-06 08:15 jaidormi       Note Deleted: 0009306                        
04-20-06 14:47 tiwai          Note Added: 0009377                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
