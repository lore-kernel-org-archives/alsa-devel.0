From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Mon, 21 Jun 2010 08:56:19 +0800
Message-ID: <AANLkTimKWqxpLS5l8QPLGLh1z6I714SyYEWwn3K01Cyu@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<s5haaqum9ml.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0637710383A
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 02:56:20 +0200 (CEST)
Received: by vws18 with SMTP id 18so357722vws.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 17:56:19 -0700 (PDT)
In-Reply-To: <s5haaqum9ml.wl%tiwai@suse.de>
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

2010/6/17 Takashi Iwai <tiwai@suse.de>

> At Thu, 17 Jun 2010 08:35:54 +0800,
> Raymond Yau wrote:
> >
>
> >
> http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=c9b86f49a8a1a8c337bf0c1b7f12749e8be781ed
> >
> > your patch did not fix the buggy driver (e.g. alsa-pulse plugin) which
> > return volume outside the alllowed range
> >
> >
> > amixer -D pulse
> > Simple mixer control 'Master',0
> >   Capabilities: pvolume pswitch pswitch-joined
> >   Playback channels: Front Left - Front Right
> >   Limits: Playback 0 - 65536
> >   Mono:
> >   Front Left: Playback 98304 [150%] [on]
> >   Front Right: Playback 98304 [150%] [on]
> >
> >
> >
> >
> > Should snd_mixer_selem_get_playback_volume() perform range check ?
> >
> > tatic int get_volume_ops(snd_mixer_elem_t *elem, int dir,
> >               snd_mixer_selem_channel_id_t channel, long *value)
> > {
> >     selem_none_t *s = snd_mixer_elem_get_private(elem);
> >     if (s->selem.caps & SM_CAP_GVOLUME)
> >         dir = SM_PLAY;
> >     if ((unsigned int) channel >= s->str[dir].channels)
> >         return -EINVAL;
> >     *value = s->str[dir].vol[channel];
> > +       if (*value > s->str[dir].max)
> > +                return -EINVAL;
> > +       if (*value < s->str[dir].min)
> > +                return -EINVAL;
> >     return 0;
>
> Some sanity check would be nice, but returning -EINVAL here isn't
> correct, at least.  -EINVAL should be returned when the caller gives a
> wrong value (e.g. a wrong channel value).
>
>
> Takashi
>

But  the application can use snd_mixer_selem_set_playback_volume_range() to
set min and max of the control ,

is there any reason allow the application to set this range ?

it seem that snd_mixer_selem_set_playback_volume did not performe any range
check

correct me if I am wrong, I seem able to use
snd_mixer_selem_set_playback_volume to -1 for the pulse device and there is
no error return , but I get  another value when use
snd_mixer_selem_get_playback_volume

BTW, amixer has -nocheck option to bypass the range check but this option
seem unable to set the value of "Master playback volume" toabove max
