From: Josh Huber <huber+keyword+alsa.9c0e1c@alum.wpi.edu>
Subject: snd-powermac in CVS busted?
Date: Thu, 19 Sep 2002 23:06:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87it11icm2.fsf@mail.paradoxical.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've finally decided to switch from using OSS to ALSA, and everything
works great, except I don't get any sound output!  I'm sending this to
the devel list since I'm dealing with the CVS version of the driver.

Using alsamixer I tried setting the Master channel at 100% as well as
the "PC Speaker" channel at 100%.

The detection of headphones seems to work, since the pc speaker
channel gets auto-muted when headphones are plugged in. (but, still no
sound is played out the headphone jack.

Using alsaplayer works great, and the visual plugins show that sound
should be playing. xmms works with the OSS compatibility driver as
well.

I built the drivers with --enable-debug=full, but I don't see any
additional kernel messages from ALSA.

I'm running Debian unstable (sid), on a Powerbook G3 Lombard, which
has the AWACS sound chip.  I'm using the CVS version of the drivers,
and the packages for libasound (0.9.0rc3), alsa-utils (0.9.0rc3), and
alsaplayer (0.99.71).

Any ideas?  What can I do to further debug this problem?

Here's the output from amixer:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right 
  Capture channels: Mono
  Limits: Playback 0 - 15 
  Mono: Capture [off] 
  Front Left: Playback 15 [100%] [on] 
  Front Right: Playback 15 [100%] [on] 
Simple mixer control 'Headphone Detection',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off] 
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off] 
Simple mixer control 'CD',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off] 
Simple mixer control 'Mic',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off] 
Simple mixer control 'Mic Boost',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 2
  Mono: 2 [100%] 
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 15 
  Front Left: Playback 15 [100%] [on] 
  Front Right: Playback 15 [100%] [on] 
Simple mixer control 'Capture',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right 
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] 
  Front Right: Capture 15 [100%] 
Simple mixer control 'Auto Mute',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 15 [15%] 


I've seen mention of people wondering where the PCM slider is in the
mixer, does this have anything to do with my problem? (perhaps?)  Am I
supposed to have a PCM channel?

Thanks in advance for the help,

-- 
Josh Huber




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
