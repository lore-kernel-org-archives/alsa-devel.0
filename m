From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Re: Delta 410 status
Date: Mon,  2 Dec 2002 21:33:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038861230.3debc3aeb6ded@albert.homedns.org>
References: <Pine.LNX.4.44.0212012216320.1488-100000@gin.nowhere.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0212012216320.1488-100000@gin.nowhere.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Reiner Klenk <pdq808@t-online.de>, "Alsa-devel@lists.sourceforge.net" <Alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Quoting Jaroslav Kysela <perex@suse.cz>:

> It's nice. Could you try the latest CVS? I've done all changes you've
> described.

I never knew that 'I am linus torvalds and I pronounce linux as linux' could 
sound so heavenly :-)

> > The faders in envy24control are still stuck at 000, but it is
> > nevertheless possible to unmute the channels by clicking somewhere close
> > to the bottom of the faders.
> 
> Should be fixed, too. Thank you very much.
Since I'm not running X, I have to do my settings with alsamixer. By default, 
channels are _not_ muted.

When I turn up the volume on dac0, sound level is decreased. Muting dacs does 
not work.

The choice for H/W x is {PCM OUT; H/W IN 0->7; IEC985; digital} Shouldn't I be 
able to select PCM OUT0->7 ? As far as I can understand, now I can only play 
mono.

What are the multi (capture) settings for ? When I try them out, they don't 
have any effect at all ?

What are the multi track internal clock, peak, rate locking, rate reset and 
volume rate for ?

In attachment an extract of amixer.

Ciaos,

Kristof

amixer
Simple mixer control 'IEC958',0
  Capabilities:
  Mono:
Simple mixer control 'IEC958',1
  Capabilities:
  Mono:
Simple mixer control 'DAC',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',1
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',2
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',3
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',4
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',5
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',6
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'DAC',7
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 127
  Mono: 0 [0%]
Simple mixer control 'Deemphasis',0
  Capabilities:
  Mono:
Simple mixer control 'Deemphasis',1
  Capabilities:
  Mono:
Simple mixer control 'Deemphasis',2
  Capabilities:
  Mono:
Simple mixer control 'Deemphasis',3
  Capabilities:
  Mono:
Simple mixer control 'H/W',0
  Capabilities:
  Mono:
Simple mixer control 'H/W',1
  Capabilities:
  Mono:
Simple mixer control 'H/W',2
  Capabilities:
  Mono:
Simple mixer control 'H/W',3
  Capabilities:
  Mono:
Simple mixer control 'H/W',4
  Capabilities:
  Mono:
Simple mixer control 'H/W',5
  Capabilities:
  Mono:
Simple mixer control 'H/W',6
  Capabilities:
  Mono:
Simple mixer control 'H/W',7
  Capabilities:
  Mono:
Simple mixer control 'Multi',0
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',1
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',2
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',3
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',4
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',5
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',6
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',7
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',8
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi',9
  Capabilities: pvolume cvolume pswitch cswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 96 Capture 0 - 96
  Front Left: Playback 0 [0%] [off] Capture 0 [0%] [off]
  Front Right: Playback 0 [0%] [off] Capture 0 [0%] [off]
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities:
  Mono:
Simple mixer control 'Multi Track Peak',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Front Center - Rear Left - Rear 
Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
  Limits: 0 - 255
  Mono: 250 [98%]
  Front Left:
  Front Right:
  Front Center:
  Rear Left:
  Rear Right:
  Woofer:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
  ?:
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Multi Track Volume Rate',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 255
  Mono: 0 [0%]

> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Get the new Palm Tungsten T
> handheld. Power & Color in a compact size!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
