From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] alsa-plugins/pulse: Implement 'pause'.
Date: Wed, 17 Jun 2009 23:37:55 +0200
Message-ID: <20090617213755.GB23735@tango.0pointer.de>
References: <alpine.LFD.2.00.0906172120550.20793@troy-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906172120550.20793@troy-laptop>
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

On Wed, 17.06.09 21:55, Troy Moure (twmoure@szypr.net) wrote:

> Just cork or uncork the stream to pause or unpause it.

Looks mostly good to me, but:

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
> +	if (pcm->stream)
> +		if (!pa_stream_cork(pcm->stream, enable, NULL, NULL))
> +			err = -EIO;

pa_stream_cork() will return a pa_operation object on success. The
least you need to do is call pa_operation_unref() on it, which you can
safely do right-away. Otherwise this will leak memory.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
