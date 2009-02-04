From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
 controller
Date: Wed, 4 Feb 2009 16:02:14 +0100
Message-ID: <20090204160214.33bb4e67@hcegtvedt>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<s5hd4dy9zem.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EC32924134
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 16:02:16 +0100 (CET)
In-Reply-To: <s5hd4dy9zem.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 04 Feb 2009 13:09:37 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed,  4 Feb 2009 12:48:34 +0100,
> Hans-Christian Egtvedt wrote:

<snipp>

> > +static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream
> > *substream,
> > +		struct snd_pcm_hw_params *hw_params)
> > +{
> > +	struct atmel_ac97c *chip =
> > snd_pcm_substream_chip(substream);
> > +	int retval;
> > +
> > +	retval = snd_pcm_lib_malloc_pages(substream,
> > +
> > params_buffer_bytes(hw_params));
> > +	if (retval)
> > +		return retval;
> 
> Should be a negative-check.
> 

For some reason if I only check for < 0, then the buffer is not
configured properly. Seems like the preallocation goes wrong for some
reason.

Any pointers to why?

I do snd_pcm_new(), then snd_pcm_set_ops(), then
snd_pcm_lib_preallocate_pages_for_all().

<snipp>

-- 
Best regards,
Hans-Christian Egtvedt
