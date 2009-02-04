From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
 controller
Date: Wed, 4 Feb 2009 13:16:42 +0100
Message-ID: <20090204131642.73cc2085@hcegtvedt>
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
	by alsa0.perex.cz (Postfix) with ESMTP id 00DFF24385
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:16:43 +0100 (CET)
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

> > diff --git a/include/sound/atmel-ac97c.h
> > b/include/sound/atmel-ac97c.h new file mode 100644
> > index 0000000..d5daddd
> > --- /dev/null
> > +++ b/include/sound/atmel-ac97c.h
> 
> Is it needed to be in include/sound directory?
> If it's just for a local driver, better to put in the local directory.
> 

Yes, the header must be available for the boards so they can see the
platform data struct. This is how the DMA slave and GPIO for reset line
is passed to the AC97C driver.

> > diff --git a/sound/avr32/ac97c.c b/sound/avr32/ac97c.c
> > new file mode 100644
> > index 0000000..218d666
> > --- /dev/null
> > +++ b/sound/avr32/ac97c.c
> > @@ -0,0 +1,994 @@
> ...
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

OK

> > +static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream
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
> Ditto.
> 

OK

> > +static int __devinit atmel_ac97c_probe(struct platform_device
> > *pdev)
> ...
> > +	mutex_init(&opened_mutex);
> 
> This is superfluous.
> 
> > +
> > +	retval = -ENOMEM;
> > +	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
> > +			THIS_MODULE, sizeof(struct atmel_ac97c));
> 
> Use snd_card_create().
> 

OK, I'll convert to using this for both drivers.

-- 
Best regards,
Hans-Christian Egtvedt
