From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: intel ICH sample rate
Date: Sun, 28 Dec 2003 11:32:44 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312281129520.25504@pnote.perex-int.cz>
References: <200312272109.hBRL9TVD031711@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312272109.hBRL9TVD031711@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 27 Dec 2003, Paul Davis wrote:

> >yOn Sat, 27 Dec 2003, Paul Davis wrote:
> >
> >> >i've been getting my laptop with an ICH soundchip up to speed, and i
> >> >just noticed for the first time yesterday that ALSA fails to get the
> >> >speed to the rate that JACK requests. a quick google reveals that the
> >> >OSS drivers only support 1 h/w rate, but there are suggestions that
> >> >the ALSA driver works better. however, neither JACK nor alsaplayer can
> >> >set the rate on my card to 44.1kHz - its stuck at 48kHz.
> >> >
> >> >this is alsa 1.0.0rc2 from Planet CCRMA. any clues?
> >> 
> >> this is using the snd-intel8x0 module. the wiki page has alerted me to
> >> the ac97_clock option, but it seems ludicrous to have to rmmod &&
> >> modprobe the module just to switch rates ...
> >
> >The ac97_clock option is for situation when another master clock crystal
> >than standard one is used by hardware vendor. You cannot change the real
> >rate with this option.
> >
> >It seems that your AC97 codec does not support VRA (variable rate) so it 
> >is capable only 48kHz or we have a bug somewhere.
> >
> >Can you send me contents of /proc/asound/card0/codec97* files?
> 
> i am entirely willing to believe that it can only do 48kHz. its a
> laptop (HP Pavilion), well known for having crapola audio interfaces
> and relying on s/w to make things work. here's the codec97* file
> (below).
> 
> meanwhile, i have found that the plughw layer doesn't work with JACK
> anymore. it appears that any attempt to set the period size fails. any
> ideas about that?
> 

> Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF
> Extended status  : PRL PRK PRJ PRI SPCV SPDIF=7/8

OK, no VRA, so you have only 48kHz hardware.

Keep in mind that the intel8x0 driver must have period sizes with power of
two. When 44.1kHz -> 48kHz resampling is done, the period size requested
from application must be multiplied with this coeficient, too. But the 
period_size_near function should work (or not? - then a bug is somewhere).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
