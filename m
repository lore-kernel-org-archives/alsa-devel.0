From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Wed, 16 Jun 2010 14:33:33 +0800
Message-ID: <AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
	<hv912l$j53$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9C6232413B
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 08:33:35 +0200 (CEST)
Received: by vws1 with SMTP id 1so1740201vws.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 23:33:34 -0700 (PDT)
In-Reply-To: <hv912l$j53$1@dough.gmane.org>
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

2010/6/16 Colin Guthrie <gmane@colin.guthr.ie>

> The fact that any key changes it back to 100% is kinda expected. It's
> not designed to handle values >100% so it makes sense that it clamps it.
> Annoying, but it makes sense.
>
> > The volume range is only from 0 to  65536
> >
> > why did alsa-lib allow alsa-pulse plugin to set it outside the range ,
> > alsamixer and amixer also display 150% ?
> >
> > amixer -D pulse
> > Simple mixer control 'Master',0
> >   Capabilities: pvolume pswitch pswitch-joined
> >   Playback channels: Front Left - Front Right
> >   Limits: Playback 0 - 65536
> >   Mono:
> >   Front Left: Playback 98304 [150%] [on]
> >   Front Right: Playback 98304 [150%] [on]
>
>
> While I agree this could be thought of as a bug, it's actually the
> nicest possible display for a system that has no concept of volumes > 100%.
>
> That said, the correct fix would be a nice mechanism for marking the
> 100% mark. e.g. specifying the limits as a triplet, lower, normal (aka
> 100%) and max.
>
> AFAIK, no such system is currently in place.
>
> An alternative would be to scale the alsa volume control to the full
> range, e.g. make 0 - 98304[1] the range it accepts. But this sucks as
> the percentage shown in alsa is not the same as the percentage shown in
> other GUIs.
>
> In a practical sense, the current setup is probably less problematic
> than the latter suggestion.
>
> Col
>
> [1] FWIW, this precice value will likely change. I've not yet actioned
> it but it's likely to be fixed at +11dB which IIRC is slightly above
> 150%. 11dB is just a figure that we felt was "sensible" with regards to
> GUI consistency and I'll try and push this out ot all the UIs I can.
>
>
>
You have made a big mistake , please study the source code of alsamixer and
amixer

Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [on]
  Front Right: Playback 31 [100%] [12.00dB] [on]


    control.39 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'PCM Playback Volume'
        value.0 31
        value.1 31
    }

---------------------------------------------------------------------

Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [0.00dB] [on]
  Front Right: Playback 23 [74%] [0.00dB] [on]


    control.39 {
        comment.access 'read write'
        comment.type INTEGER
        comment.count 2
        comment.range '0 - 31'
        comment.dbmin -3450
        comment.dbmax 1200
        iface MIXER
        name 'PCM Playback Volume'
        value.0 23
        value.1 23
    }

The percentage displayed below the vertical slider in alsamixer and the
percentage after the dB values are the percentage of the current step / the
total number of step

so you cannot get any percentage > 100% in alsamixer and amixer

snd_mixer_selem_get_playback_volume_range()  of PCM return min =0 and max=
31
at 0dB the percentage is 23/32  about 74%  since 0dB is step 23 in  step 0
-34.5dB , step31 is 12dB (the difference between step is 1.5dB

This percentage in alsamixer and amixer is not those volume scale which you
described  BASE_VOLUME  or PA_NORM
