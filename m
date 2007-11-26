From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Disable conversions
Date: Mon, 26 Nov 2007 16:55:54 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711261638320.24363@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hsl2zhlmh.wl%tiwai@suse.de>
	<20071125204132.GA15151@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DA1424856
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 16:55:55 +0100 (CET)
In-Reply-To: <20071125204132.GA15151@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> On Wed, 21.11.07 12:40, Takashi Iwai (tiwai@suse.de) wrote:
> 
> > At Tue, 20 Nov 2007 01:51:51 +0100,
> > Lennart Poettering wrote:
> > > 
> > > 4) If I open an audio device with "plughw:" i can disable the software
> > >    resampling that takes place via
> > >    "snd_pcm_hw_params_get_rate_resample()". However, there is no
> > >    equivalent for disabling the channel number adjustment or the
> > >    sample format conversion. This would be very useful in PA however,
> > >    since this would allow me to use only the parts of plughw I am
> > >    interested in (softvol), and disable all the rest (resampling,
> > >    conversion, channel remixing).
> > 
> > Hmm..  It's a bit difficult to implement in a clean way.
> > For example, what would be the reason to disable softvol?  
> 
> Hmm, I think there's some kind of misunderstand here: softvol is the
> only part I am interested in to use. It's the resampling, the sample
> type conversion, and the channel map changing I want to disable. Right
> now, I can only disable the resampling, but the type conversion and
> channel conversion always stay enabled. Or did I miss something?

I though about this idea again. Resampling is a bit exception, because we 
have no very good implementation in alsa-lib and there are rounding 
problems regarding period sizes due to nature of ALSA API, so it's better 
to resample on bytestream if possible.

I think that Takashi already proposed to handle "disabling" using
a configuration file (interface). We can even create an argument for 
plughw device:

1) Proposal - one argument specifying multiple disabled conversions:

   plughw:CARD=0,DEV=0,DISABLECONV=cfr

   c = channels
   f = format
   r = rate

   And add 'disableconv' to pcm/pcm_plug.c configuration parser.

2) Proposal - multiple arguments

   plughw:CARD=0,DEV=0,DISABLECHANNELS=1,DISABLERATE=1,DISABLEFORMAT=1

I prefer first proposal (I don't think that it will be widely used), but I 
have no objections for second, too.

This can be applied to plug: device as well.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
