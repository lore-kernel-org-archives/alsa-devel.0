From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH v2] alsa-plugins/pulse: Implement 'pause'.
Date: Thu, 18 Jun 2009 16:40:42 +0200
Message-ID: <20090618144042.GA28833@tango.0pointer.de>
References: <alpine.LFD.2.00.0906172120550.20793@troy-laptop>
	<20090617213755.GB23735@tango.0pointer.de>
	<alpine.LFD.2.00.0906181444420.6800@troy-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906181444420.6800@troy-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Moure <twmoure@szypr.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 18.06.09 14:55, Troy Moure (twmoure@szypr.net) wrote:

> > pa_stream_cork() will return a pa_operation object on success. The
> > least you need to do is call pa_operation_unref() on it, which you can
> > safely do right-away. Otherwise this will leak memory.
> > 
> > Lennart
> 
> Thanks, Lennart, for looking at the first verson I sent.  I've added a 
> call to pa_operation_unref() as you suggested.

Looks good to me now.

> 
>  pulse/pcm_pulse.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
> index db8d1e1..c276839 100644
> --- a/pulse/pcm_pulse.c
> +++ b/pulse/pcm_pulse.c
> @@ -739,6 +739,30 @@ static int pulse_close(snd_pcm_ioplug_t * io)
>  	return 0;
>  }
>  
> +static int pulse_pause(snd_pcm_ioplug_t * io, int enable)
> +{
> +	snd_pcm_pulse_t *pcm = io->private_data;
> +	int err = 0;
> +
> +	assert (pcm);
> +	assert (pcm->p);
> +
> +	pa_threaded_mainloop_lock(pcm->p->mainloop);
> +
> +	if (pcm->stream) {
> +		pa_operation *o;
> +		o = pa_stream_cork(pcm->stream, enable, NULL, NULL);
> +		if (o)
> +			pa_operation_unref(o);
> +		else
> +			err = -EIO;
> +	}
> +
> +	pa_threaded_mainloop_unlock(pcm->p->mainloop);
> +
> +	return err;
> +}
> +
>  static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
>  	.start = pulse_start,
>  	.stop = pulse_stop,
> @@ -750,6 +774,7 @@ static const snd_pcm_ioplug_callback_t pulse_playback_callback = {
>  	.prepare = pulse_prepare,
>  	.hw_params = pulse_hw_params,
>  	.close = pulse_close,
> +	.pause = pulse_pause
>  };
>  
>  


Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
