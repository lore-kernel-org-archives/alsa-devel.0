From: mark@undertone.org
Subject: Re: btw
Date: Thu, 17 Oct 2002 08:42:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021017134235.GA14241@undertone.org>
References: <20021014191214.GB6704@undertone.org> <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de> <20021015175750.GA8918@undertone.org> <s5hof9u666f.wl@alsa2.suse.de> <20021016194055.GA11982@undertone.org> <s5h8z0x5v3r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8z0x5v3r.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 17, 2002 at 10:26:48AM +0200, Takashi Iwai wrote:
> ah, since 8000Hz 8 bit is not supported on this device.
> please use plughw instead of hw, that is,
> 
> 	% aplay -Dplughw:1,0 foo.wav

atrophy:~# aplay -Dplughw:1,0 foo.wav
Playing raw data 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_hw.c:428:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: Invalid argument
aplay: set_params:813: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: (124988 124989)
PERIOD_SIZE: (999 1000)
PERIOD_BYTES: (999 1000)
PERIODS: (4 5)
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 4000
TICK_TIME: 10000
atrophy:~# 

I've tried an entire array of different wav's in different formats,
all with similar debugging output.

I've also tried installing various modules and drivers in a vain and
blind attempt to just get it to play the stream. What "is supported"
natively by the driver?

> for the control (mixer) interface, no second zero, that is, use
> '-Dhw:1'.  (btw, it's equitvalent "amixer -c 1").

Yes, I've been able to mix the thing properly now. Thanks. Uh, I'm
guessing the code is the best place to actually get a decent
description why this is?

> > I compiled both controler modules and have tried using them
> > interchangably. Same result. There is no difference in the stream0
> > file - checked with a diff.
> 
> you can check this also via the output of 'lsusb -v'.

Only differences were fairly cosmetic:

atrophy:~/alsa# diff uhci usb-uhci 
15c15
<   iProduct                2 USB UHCI-alt Root Hub
---
>   iProduct                2 USB UHCI Root Hub
50c50
< Bus 001 Device 002: ID 041e:3000 Creative Labs 
---
> Bus 001 Device 005: ID 041e:3000 Creative Labs 

I had to disconnect my minihub and connect only the extigy by itself
in order to use the usb-uhci driver. I normally only use uhci, as I
need to use a usb mouse and the extigy, which requires a hub that
doesnt like usb-uhci.

Given the output above, I'm probably doing something rather silly
again with regards to some kind of random compatibility issue. I am
still running the mixer with the debug hack you put in.

-mark


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
