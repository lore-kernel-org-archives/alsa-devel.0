From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: intel ICH sample rate
Date: Sat, 27 Dec 2003 20:49:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312272046580.25504@pnote.perex-int.cz>
References: <200312271711.hBRHBANb017469@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312271711.hBRHBANb017469@dhin.linuxaudiosystems.com>
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

yOn Sat, 27 Dec 2003, Paul Davis wrote:

> >i've been getting my laptop with an ICH soundchip up to speed, and i
> >just noticed for the first time yesterday that ALSA fails to get the
> >speed to the rate that JACK requests. a quick google reveals that the
> >OSS drivers only support 1 h/w rate, but there are suggestions that
> >the ALSA driver works better. however, neither JACK nor alsaplayer can
> >set the rate on my card to 44.1kHz - its stuck at 48kHz.
> >
> >this is alsa 1.0.0rc2 from Planet CCRMA. any clues?
> 
> this is using the snd-intel8x0 module. the wiki page has alerted me to
> the ac97_clock option, but it seems ludicrous to have to rmmod &&
> modprobe the module just to switch rates ...

The ac97_clock option is for situation when another master clock crystal
than standard one is used by hardware vendor. You cannot change the real
rate with this option.

It seems that your AC97 codec does not support VRA (variable rate) so it 
is capable only 48kHz or we have a bug somewhere.

Can you send me contents of /proc/asound/card0/codec97* files?

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
