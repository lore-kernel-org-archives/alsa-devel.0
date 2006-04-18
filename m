From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002035]: Realtek 861 card not functional using included alsa drivers
Date: Tue, 18 Apr 2006 20:50:58 +0200
Message-ID: <c23bdaf3b55fb1eb2c662659f64f8ea6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA228183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 20:50:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2035> 
======================================================================
Reported By:                vertex
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2035
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2080_FC5smp
======================================================================
Date Submitted:             04-18-2006 20:00 CEST
Last Modified:              04-18-2006 20:50 CEST
======================================================================
Summary:                    Realtek 861 card not functional using included alsa
drivers
Description: 
I am using the FC5 drivers to begin with.  The packages are labeled version
1.0.11rc2.  There are only a few options when I run alsamixer. Using the
stock drivers, I have these options:

Headphone switch
CD level
Mic level
Input Source switch(Mic/CD)

I compiled the 1.0.11rc5 drivers from source and rebooted. I now have
these channels when I run alsamixer:

Front switch
CD level
Mic level
Input Source switch(Mic/CD)

I tried compiling the 1.0.9 drivers from Realtek's website(said nothing
about the 861), but they did not build.  In fact, the install script
overwrote my asound libraries requiring a package replacement to get back
to a sane state.

Please let me know if there is something more I can provide.
======================================================================

----------------------------------------------------------------------
 vertex - 04-18-06 20:40 
----------------------------------------------------------------------
Nothing appears to work. No audio playback at any time. I don't know of any
easy way to test the mic functionality if I can't hear playback. I don't
see anything in the mixer controls that would allow me to turn volume up,
much less mute/unmute a channel. Does the second statement imply that
there is no volume control for the sound card? Is the "CD" channel control
the general audio playback?

Yes, I added model=ACL861 to my /etc/modprobe.conf, this had no impact
that I can see. dmesg says:

hda_codec: Unknown model for ACL861, trying auto-probe from BIOS

Also, I have verified the same issue exists using the 2.6.15 kernel
provided by FC5.

This system only has two ports, one for headphones and one for an external
mic. The system has a built-in mic also.

Output of amixer is as follows:

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
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
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

Thanks very much for looking at this so promptly.

----------------------------------------------------------------------
 vertex - 04-18-06 20:50 
----------------------------------------------------------------------
Something interesting here. I rebooted into single user mode, removed the
snd-hda-intel module. Loaded it with modprobe snd-hda-intel model=ACL861.
I ran amixer and it didn't show any changes. I then executed "telinit 3".
I ran "aplay somewavfile.wav" and then ran alsamixer. I now see a PCM
channel:

Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%]
  Front Right: Playback 255 [100%]
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
  Front Left: Playback 23 [100%] [on]
  Front Right: Playback 23 [100%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 13
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'CD'
  Item0: 'CD'

I still do not have any sound coming out of the headphones or built in
speakers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 20:00 vertex         New Issue                                    
04-18-06 20:00 vertex         Distribution              => Fedora Core 5   
04-18-06 20:00 vertex         Kernel Version            => 2.6.16-1.2080_FC5smp
04-18-06 20:09 rlrevell       Note Added: 0009339                          
04-18-06 20:25 pzad           Note Added: 0009340                          
04-18-06 20:40 vertex         Note Added: 0009342                          
04-18-06 20:50 vertex         Note Added: 0009343                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
