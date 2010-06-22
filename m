From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: reading 1 second of audio at a time
Date: Tue, 22 Jun 2010 10:09:59 +0800
Message-ID: <AANLkTilW8o1ak7xcYwqJIA4sONC4qfJZPQ1KPYFlBfnF@mail.gmail.com>
References: <20100621192559.GP15838@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 787EC103894
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 04:10:01 +0200 (CEST)
Received: by vws20 with SMTP id 20so1453651vws.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 19:09:59 -0700 (PDT)
In-Reply-To: <20100621192559.GP15838@belle.intranet.vanheusden.com>
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

2010/6/22 folkert <folkert@vanheusden.com>

> Hi,
>
> Am trying to achieve something trivial: reading 1 second of audio at a
> time, but something goes wrong:
>
> Sound 1277148008.835094
> Sound 1277148008.838224
> Sound 1277148010.834839
> Sound 1277148010.838001
> Sound 1277148012.834523
> Sound 1277148012.837580
> Sound 1277148014.835240
> Sound 1277148014.838333
>
> As you can see; audio is returned for 2 seconds, then it sleeps 2
> secondsn, then 2 seconds of audio, etc.
>
> What I do is:
>
>        if (snd_pcm_hw_params_set_access(pcm_handle, hwparams,
> SND_PCM_ACCESS_RW_INTERLEAVED) < 0) {
>        }
>
>        if (snd_pcm_hw_params_set_format(pcm_handle, hwparams,
> SND_PCM_FORMAT_S16_LE) < 0) {
>        }
>
>        exact_rate = 44100;
>        if (snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams,
> &exact_rate, 0) < 0) {
>                error_exit("Error setting rate.\n");
>        }
>        if (*rate != exact_rate) {
>                fprintf(stderr, "The rate %d Hz is not supported by your
> hardware.\n ==> Using %d Hz instead.\n", *rate, exact_rate);
>                *rate = exact_rate;
>        }
>
>        if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2) < 0) { }
>
>        int periods = 2;
>        if (snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0)
> < 0) {
>        }
>
>        if (snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams,
> exact_rate * 2 * n_channels) < 0) {
>        }
>

buffer_size is actually no of samples , exact_rate*2*n_channels seem to be
buffer_bytes

Have you checked whether hardware driver support exactly 1 second buffer ?

since the most common HDA , you cannot get exactlyy 1 second buffer because
period_size is multiple of 128 bytes




>
>        if (snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
>        }
>
>        return pcm_handle;
> }
>
> void get_audio_1s(snd_pcm_t *pcm_handle, short *buffer, int rate, int
> channels)
> {
>        int samples = channels * rate, index = 0;
>
>        while(samples > 0)
>        {
>                int cur = samples, pcmreturn;
>
>                while ((pcmreturn = snd_pcm_readi(pcm_handle,
> &buffer[index], cur)) < 0) {
>                        snd_pcm_prepare(pcm_handle);
>                        printf("
> underrun\n");
>                }
>
>                index += pcmreturn;
>                samples -= pcmreturn;
>        }
> }
>
> So I call this get_audio_1s() with the samplerate (44100) and the number of
> channels (2).
> Then it seems to return the first second at once, then the second second of
> audio too, then sleeps for 2 seconds(!) and then repeats.
>
>
> Folkert van Heusden
>
> --
> Ever wonder what is out there? Any alien races? Then please support
> the seti@home project: setiathome.ssl.berkeley.edu
> ----------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
