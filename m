From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Thu, 17 Jun 2010 08:35:54 +0800
Message-ID: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE4F110391B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 02:35:55 +0200 (CEST)
Received: by vws6 with SMTP id 6so1013224vws.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 17:35:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/25 Clemens Ladisch <clemens@ladisch.de>

> James Courtier-Dutton wrote:
> > On 25 May 2010 09:38, Clemens Ladisch <clemens@ladisch.de> wrote:
> > > All the others seem to be mistakes:
> > >
> > > > soc/codecs/stac9766.c:...
> > > > soc/codecs/wm8350.c:...
> > > > soc/codecs/wm8400.c:...
> > > > soc/codecs/wm8990.c:...
> >
> > Could this maybe explain why pulseaudio was having such problems with
> > alsa with regards to gain controls????
>
> Only if it happens on embedded hardware that uses these particular
> codecs.
>
>
> Regards,
> Clemens
>

http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=c9b86f49a8a1a8c337bf0c1b7f12749e8be781ed

your patch did not fix the buggy driver (e.g. alsa-pulse plugin) which
return volume outside the alllowed range


amixer -D pulse
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 98304 [150%] [on]
  Front Right: Playback 98304 [150%] [on]




Should snd_mixer_selem_get_playback_volume() perform range check ?

tatic int get_volume_ops(snd_mixer_elem_t *elem, int dir,
              snd_mixer_selem_channel_id_t channel, long *value)
{
    selem_none_t *s = snd_mixer_elem_get_private(elem);
    if (s->selem.caps & SM_CAP_GVOLUME)
        dir = SM_PLAY;
    if ((unsigned int) channel >= s->str[dir].channels)
        return -EINVAL;
    *value = s->str[dir].vol[channel];
+       if (*value > s->str[dir].max)
+                return -EINVAL;
+       if (*value < s->str[dir].min)
+                return -EINVAL;
    return 0;
