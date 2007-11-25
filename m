From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Disable conversions
Date: Sun, 25 Nov 2007 21:41:32 +0100
Message-ID: <20071125204132.GA15151@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hsl2zhlmh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 79B2224614
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 21:41:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsl2zhlmh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21.11.07 12:40, Takashi Iwai (tiwai@suse.de) wrote:

> At Tue, 20 Nov 2007 01:51:51 +0100,
> Lennart Poettering wrote:
> > 
> > 4) If I open an audio device with "plughw:" i can disable the software
> >    resampling that takes place via
> >    "snd_pcm_hw_params_get_rate_resample()". However, there is no
> >    equivalent for disabling the channel number adjustment or the
> >    sample format conversion. This would be very useful in PA however,
> >    since this would allow me to use only the parts of plughw I am
> >    interested in (softvol), and disable all the rest (resampling,
> >    conversion, channel remixing).
> 
> Hmm..  It's a bit difficult to implement in a clean way.
> For example, what would be the reason to disable softvol?  

Hmm, I think there's some kind of misunderstand here: softvol is the
only part I am interested in to use. It's the resampling, the sample
type conversion, and the channel map changing I want to disable. Right
now, I can only disable the resampling, but the type conversion and
channel conversion always stay enabled. Or did I miss something?

> It's basically irrelevant with the PCM parameters.  It's added just
> because of lack of hardware volume controls.
> 
> One idea I have is to make an API like
> 
> 	snd_pcm_alias_plugin(src, dst);
> 
> For example,
> 
> 	snd_pcm_alias_plugin("softvol", "passthru");
> 
> would take passthru plugin instead of softvol plugin.
> (Suppose passthru plugin as a simply pass-through plugin to its
>  slave.pcm)

I am not sure if I understand what this would be useful for?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
