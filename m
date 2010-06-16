From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Wed, 16 Jun 2010 08:41:12 +0800
Message-ID: <AANLkTikXirIJROWtqacciq2eKF2IN20GURCk458WXRiV@mail.gmail.com>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>
	<hv912l$j53$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id D16CA24141
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 02:41:15 +0200 (CEST)
Received: by vws1 with SMTP id 1so1405481vws.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 17:41:13 -0700 (PDT)
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

> 'Twas brillig, and Raymond Yau at 15/06/10 23:29 did gyre and gimble:
> > 2010/6/16 Colin Guthrie <gmane@colin.guthr.ie>
> >
> >> 'Twas brillig, and Raymond Yau at 15/06/10 00:43 did gyre and gimble:
> >>> +12dB(400%) is even larger than the software gain 150% of PA
> >>
> >> Software gain of PA 150% = ~+11dB, so not as different as you imply.
> >>
> >> I've explained the cubic mapping already, so please don't use arbitrary,
> >> differently calculated percentages when comparing things. It's like
> >> comparing apples to oranges.
> >>
> >> Col
> >>
> >>
> > When I changed the volume slider of the gnome sound applet ( select
> > perference ) in Fedora 13 to maximum (i.e. PA 150% )
> >
> > Seem to be bug in amixer and alsamixer
> >
> > alsamixer also change to 150% but press any key change back to 100%
>
> The fact that any key changes it back to 100% is kinda expected. It's
> not designed to handle values >100% so it makes sense that it clamps it.
> Annoying, but it makes sense.
>

The bug is alsa-lib allow alsa-pulse plugin to set the value 98304 which is
outside 0 - 65536.





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

it is not related to 100% ,

the mixer application use snd_mixer_selem_get_playback_volume_range() to get
min and max to calculate the number of possible step in creating the slider
since the mixer application can only set the volume between min and max by
snd_mixer_selem_set_playback_volume()

The percentage is calculated by dividing the value by (max - min)

Please study ALSA 's simpler api interface

http://www.alsa-project.org/alsa-doc/alsa-lib/group___simple_mixer.html


So this is a bug in alsa-lib which mislead the PA developers
