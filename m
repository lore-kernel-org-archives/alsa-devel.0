From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: S16_LE + softvol = bad
Date: Thu, 17 Jan 2008 20:01:09 +0500
Message-ID: <c072ca310801170701o755601c0ia0822ed3a6b8e7d8@mail.gmail.com>
References: <fmnlt1$g5m$1@ger.gmane.org>
	<1200578447.2521.1231765977@webmail.messagingengine.com>
	<s5hzlv4ee49.wl%tiwai@suse.de> <s5hy7aoedju.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by alsa0.perex.cz (Postfix) with ESMTP id ECDFD243BA
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 16:01:10 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so515647wxc.23
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 07:01:10 -0800 (PST)
In-Reply-To: <s5hy7aoedju.wl%tiwai@suse.de>
Content-Disposition: inline
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

2008/1/17, Takashi Iwai <tiwai@suse.de>:
> ... and the below is the fix.  Give it a try.

Tested with no explicit defaults.pcm.dmix.format, with explicit
S16_LE, and with explicit S32_LE, all with Intel HD audio and the PC
speaker (total 6 cases, including one meaningless). In all cases, the
code was able to choose the correct format for talking with hardware
(i.e., the worst of (a) explicitly specified, if any, and (b) the best
hardware-supported one). Thanks for a quick fix!

>
>
> Takashi
>
> diff -r f20b309ff22a src/conf/alsa.conf
> --- a/src/conf/alsa.conf        Tue Jan 15 14:29:34 2008 +0100
> +++ b/src/conf/alsa.conf        Thu Jan 17 15:18:53 2008 +0100
> @@ -68,7 +68,7 @@ defaults.pcm.ipc_perm 0660
>  defaults.pcm.ipc_perm 0660
>  defaults.pcm.dmix.max_periods 0
>  defaults.pcm.dmix.rate 48000
> -defaults.pcm.dmix.format S16_LE
> +defaults.pcm.dmix.format "unchanged"
>  defaults.pcm.dmix.card defaults.pcm.card
>  defaults.pcm.dmix.device defaults.pcm.device
>  defaults.pcm.dsnoop.card defaults.pcm.card
> diff -r f20b309ff22a src/pcm/pcm_direct.c
> --- a/src/pcm/pcm_direct.c      Tue Jan 15 14:29:34 2008 +0100
> +++ b/src/pcm/pcm_direct.c      Thu Jan 17 15:18:53 2008 +0100
> @@ -874,7 +874,11 @@ int snd_pcm_direct_initialize_slave(snd_
>                         return ret;
>                 }
>         }
> -       ret = snd_pcm_hw_params_set_format(spcm, hw_params, params->format);
> +       if (params->format == SND_PCM_FORMAT_UNKNOWN)
> +               ret = -EINVAL;
> +       else
> +               ret = snd_pcm_hw_params_set_format(spcm, hw_params,
> +                                                  params->format);
>         if (ret < 0) {
>                 static const snd_pcm_format_t dmix_formats[] = {
>                         SND_PCM_FORMAT_S32,
> diff -r f20b309ff22a src/pcm/pcm_dmix.c
> --- a/src/pcm/pcm_dmix.c        Tue Jan 15 14:29:34 2008 +0100
> +++ b/src/pcm/pcm_dmix.c        Thu Jan 17 15:18:53 2008 +0100
> @@ -1267,7 +1267,7 @@ int _snd_pcm_dmix_open(snd_pcm_t **pcmp,
>         params.periods = 3;
>
>         err = snd_pcm_slave_conf(root, dopen.slave, &sconf, 8,
> -                                SND_PCM_HW_PARAM_FORMAT, 0, &params.format,
> +                                SND_PCM_HW_PARAM_FORMAT, SCONF_UNCHANGED, &params.format,
>                                  SND_PCM_HW_PARAM_RATE, 0, &params.rate,
>                                  SND_PCM_HW_PARAM_CHANNELS, 0, &params.channels,
>                                  SND_PCM_HW_PARAM_PERIOD_TIME, 0, &params.period_time,
> @@ -1282,8 +1282,10 @@ int _snd_pcm_dmix_open(snd_pcm_t **pcmp,
>         if (psize == -1 && params.period_time == -1)
>                 params.period_time = 125000;    /* 0.125 seconds */
>
> -       /* sorry, limited features */
> -       if (! (dmix_supported_format & (1ULL << params.format))) {
> +       if (params.format == -2)
> +               params.format = SND_PCM_FORMAT_UNKNOWN;
> +       else if (!(dmix_supported_format & (1ULL << params.format))) {
> +               /* sorry, limited features */
>                 SNDERR("Unsupported format");
>                 snd_config_delete(sconf);
>                 return -EINVAL;
>


-- 
Alexander E. Patrakov
