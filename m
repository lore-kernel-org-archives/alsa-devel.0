From: Jeffrey Baker <jwbaker@acm.org>
Subject: intel8x0, ad198x, no sound
Date: Sun, 18 May 2003 12:46:17 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030518194617.GA3302@noodles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-Message-ID: <20030518200215.GB3375@noodles>
Resent-To: alsa-devel@lists.sourceforge.net
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is related to the mail last week regarding the Asus P4PE with
ad1980 sound chip.  I got an Asus P4P800 with the ad1985.  The
intel8x0 driver works but there are problems with the sound routing.
There is no sound at all coming from the main (line out) output.
If I plug headphones into the line in jack, there is sound but it
appears to be some kind of surround output, because it lacks all low
frequencies entirely.  No sound comes from the microphone jack.

I think the problem may be related to the "intelligent" jack sensing
built into this hardware.  It is supposed to be able to detect when
you've got your headphones plugged into the wrong jack and reroute
the audio.  Either that, or the chip is stuck in some surround mode
that isn't quite working.

The output from amixer is below.  I tried every slider and I
couldn't get sound out of the line out jack.  Is there a modprobe
argument to load this module in stereo instead of 6-channel mode (or
vice versa)?

I haven't read it but full programming info is available on the
Analog Devices web site.

-jwb


Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] 
  Front Right: Playback 31 [100%] [on] 
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [on] 
  Front Right: Playback 0 [0%] [on] 
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 19 [61%] [on] 
  Front Right: Playback 19 [61%] [on] 
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [on] 
  Front Right: Playback 0 [0%] [on] 
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [off] 
  Front Left: Capture [on] 
  Front Right: Capture [on] 
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono: 
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [off] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%] 
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15 
  Mono: Playback 0 [0%] [off] 
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [off] Capture [off] 
  Front Right: Playback 0 [0%] [off] Capture [off] 
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono: 
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right 
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [off] 
  Front Right: Capture 0 [0%] [off] 
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
