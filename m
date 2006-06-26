From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002198]: No sound out of the built in
	speakers, but from headphones on a Apple MacBook Pro
Date: Mon, 26 Jun 2006 16:20:43 +0200
Message-ID: <a4df1d843fbffc5dc2fd8552b0db3c81@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B75013E
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:20:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2198> 
======================================================================
Reported By:                enlighter
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2198
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.16.16
======================================================================
Date Submitted:             06-09-2006 12:09 CEST
Last Modified:              06-26-2006 16:20 CEST
======================================================================
Summary:                    No sound out of the built in speakers, but from
headphones on a Apple MacBook Pro
Description: 
Hi,

this error occours on all macbook pros! (see www.mactel-linux.org). Sound
comes only out of the headphones or out of line-out, but the internal
speakers keep mute. I cannot unmute them using the mixer (alsamixer,
kmix). I also tried a rc version of linux-2.6.17 with the same result.

I also tried to load the snd-hda-intel module with "model=laptop" and
"model=laptop-eapd".
======================================================================

----------------------------------------------------------------------
 tiwai - 06-26-06 16:08 
----------------------------------------------------------------------
Don't specify any model option for STAC codecs.

----------------------------------------------------------------------
 enlighter - 06-26-06 16:20 
----------------------------------------------------------------------
I don't use the model option any more. Keeps silent too.

these are my mixer settings (just to be sure that there's not the fault):
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%]
  Front Right: Playback 255 [100%]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [on]
  Front Right: Playback 127 [100%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [on]
  Front Right: Playback 127 [100%] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [on]
Simple mixer control 'Line In as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 0 [0%] [off]
  Front Right: Capture 0 [0%] [off]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 0 [0%]
  Front Right: Capture 0 [0%]

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 12:09 enlighter      New Issue                                    
06-09-06 12:09 enlighter      Distribution              => Gentoo Linux    
06-09-06 12:09 enlighter      Kernel Version            => 2.6.16.16       
06-14-06 09:47 enlighter      Issue Monitored: enlighter                    
06-18-06 09:27 enlighter      Note Added: 0010297                          
06-18-06 09:29 enlighter      Note Added: 0010298                          
06-25-06 20:17 enlighter      Note Added: 0010518                          
06-26-06 16:08 tiwai          Note Added: 0010541                          
06-26-06 16:20 enlighter      Note Added: 0010546                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
