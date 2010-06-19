From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Sat, 19 Jun 2010 16:35:14 +0800
Message-ID: <AANLkTilJ-eLGx_QluMtj3LqQc4DOEUskj4m-xjy-wYud@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<4C1A2A9C.3000902@ladisch.de>
	<AANLkTimF2iotSHsjFQFtHYo89yuXZRcYvHNvJm79g4Dw@mail.gmail.com>
	<hvhu14$cov$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 91F7A103801
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 10:35:16 +0200 (CEST)
Received: by gxk5 with SMTP id 5so1011394gxk.38
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 01:35:15 -0700 (PDT)
In-Reply-To: <hvhu14$cov$2@dough.gmane.org>
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

2010/6/19 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 19/06/10 03:39 did gyre and gimble:
> > 2010/6/17 Clemens Ladisch <clemens@ladisch.de>
> >
> >> Raymond Yau wrote:
> >>> Should snd_mixer_selem_get_playback_volume() perform range check ?
> >>
> >> No, it's the responsibility of the control implementation to return
> >> valid values (and to check that values that are being set are valid).
> >>
> >>
> >> Regards,
> >> Clemens
> >> _
> >>
> >
> > The root cause of the bug is gnome-volume-control allow user to set
> > PA_VOLUME to 150% and PA return the value outside the allowed range of
> the
> > "master" volume control of the pulse device
> >
> >
> http://git.gnome.org/browse/gnome-media/commit/?id=cfe5cf8d6826f2eacf0d2b109381ec61dda50185
>
> This is not the root cause of the bug Raymond. I have explained this
> several times now.
>
> This is perfectly acceptable behaviour in PA.
>
> I have stated the two possible solutions quite clearly (twice!) in one
> of the three threads you've managed to create on this topic.
>
> Please stop going on about the issue and please reply just once to each
> email, it's incredibly annoying trying to follow any discussion you
> comment on due to this deluge of responses.
>
> Col
>


I am discussing with Clemen 's patch  which clamp the display volume within
the allowed range is not correct. since the display percentage jump from
150% to 100% immediately but the actually value is still 9xxxx which is much
larger than 65536, the user has to pressed the down arrow key for a long
time (alsamixer seem freezing ) for the value to down below the allowed
range (100% to 99%)  when the buggy driver did not return value within
allowed range of control

I don't think this behaviour of alsamixer is normal


http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=c9b86f49a8a1a8c337bf0c1b7f12749e8be781ed;hp=5a016b583b5c949253a9e791ad79f13e54f87054
