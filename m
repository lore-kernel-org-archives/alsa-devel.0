From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Long-standing SDL ALSA bug
Date: Tue, 13 Oct 2009 09:03:57 +0200
Message-ID: <4AD4265D.2050109@ladisch.de>
References: <3adffa60910121114p54e74010r541c6cee86db6721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AC836103877
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 09:04:02 +0200 (CEST)
In-Reply-To: <3adffa60910121114p54e74010r541c6cee86db6721@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sam Lantinga <slouken@libsdl.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sam Lantinga wrote:
> I'm attaching the latest versions of the SDL audio files, and I'd
> really appreciate it if you take a look and sanity check our code.

> 	device = SDL_getenv("AUDIODEV");	/* Is there a standard variable name? */

ALSA's devices look at certain environment variables; you are supposed
to use names like "default" or "surround51" to get that default
configuration.

> 	if (channels == 6) device = "surround51";
> 	else if (channels == 4) device = "surround40";

The devices do not have automatic sample format/rate conversion; you
might want to use "plug:surround.." instead.

> /* This function waits until it is possible to write a full sound buffer */
> static void ALSA_WaitAudio(_THIS)

This function doesn't actually wait ...

> 	if ( status == -EAGAIN ) {
> 		SDL_Delay(1);
> 		continue;
> 	}

Not necessary in blocking mode.

> 	rate = spec->freq;
> 	status = SDL_NAME(snd_pcm_hw_params_set_rate_near)(pcm_handle, hwparams, &rate, NULL);
> 	spec->freq = rate;

The returned rate could be wildly different, but I guess SDL correctly
handles the new value in spec->freq.

> 	/* Set the buffer size, in samples */
> 	frames = spec->samples;
> 	status = SDL_NAME(snd_pcm_hw_params_set_period_size_near)(pcm_handle, hwparams, &frames, NULL);

This does _not_ set the buffer size.

> 	periods = 2;
> 	SDL_NAME(snd_pcm_hw_params_set_periods_near)(pcm_handle, hwparams, &periods, NULL);

A bigger number of periods would make the writing of audio data less
bursty.

>	status = SDL_NAME(snd_pcm_sw_params_set_start_threshold)(pcm_handle, swparams, 0);

Zero doesn't really make sense; the default value 1 would be OK.

> 	status = SDL_NAME(snd_pcm_sw_params_set_avail_min)(pcm_handle, swparams, frames);

The default value is the period size anyway, so you can remove this.
(If you change the buffer size code above to use _set_buffer_size_near,
this call would be wrong.)


Best regards,
Clemens
