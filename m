From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Disable conversions
Date: Wed, 21 Nov 2007 16:16:21 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711211613180.8325@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hsl2zhlmh.wl%tiwai@suse.de> <s5hir3vwu34.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A29FE24C3B
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:16:22 +0100 (CET)
In-Reply-To: <s5hir3vwu34.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Nov 2007, Takashi Iwai wrote:

> At Wed, 21 Nov 2007 12:40:54 +0100,
> I wrote:
> > 
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
> > For example, what would be the reason to disable softvol?  It's
> > basically irrelevant with the PCM parameters.  It's added just because
> > of lack of hardware volume controls.
> > 
> > One idea I have is to make an API like
> > 
> > 	snd_pcm_alias_plugin(src, dst);
> > 
> > For example,
> > 
> > 	snd_pcm_alias_plugin("softvol", "passthru");

I don't like this idea nor implementation much. It will be much better to 
design a run-time communication with plugins to change configuration 
parameters / behaviour (something like ioctl on opened pcm handle).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
