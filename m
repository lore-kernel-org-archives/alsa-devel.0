From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Thu, 17 Jun 2010 16:48:58 +0800
Message-ID: <AANLkTimHN1eICza_ymoEkMbXnKYF8k7-pEoZV4uqGk0N@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<s5haaqum9ml.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 94FF0103917
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 10:49:00 +0200 (CEST)
Received: by gxk5 with SMTP id 5so1515634gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2010 01:48:58 -0700 (PDT)
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
> > 2010/5/25 Clemens Ladisch <clemens@ladisch.de>
> >
> > > James Courtier-Dutton wrote:
>
> > > >
> > > > Could this maybe explain why pulseaudio was having such problems with
> > > > alsa with regards to gain controls????
> > >
> > > Only if it happens on embedded hardware that uses these particular
> > > codecs.
> > >
> > >
> > > Regards,
> > > Clemens
> > >
> >
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


Clemens's patch just clamp the invalid volume to max  is not  not enough for
alsamixer behave as normal

PA 's server still keep the 9xxxx value , it take a lot of time to press the
arrow key for alsamixer to change from 100% to 99&
