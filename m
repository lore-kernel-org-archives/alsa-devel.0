From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Headphone jack and auto-mute of speak output
Date: Fri, 8 Oct 2010 07:05:42 +0800
Message-ID: <AANLkTimHatLx7PP6BQc=zxOyBarKiFuTpLbeDpWh7kdJ@mail.gmail.com>
References: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
	<AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
	<4CADEF5F.7070600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id A541524569
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 01:05:45 +0200 (CEST)
Received: by ewy8 with SMTP id 8so248410ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 16:05:45 -0700 (PDT)
In-Reply-To: <4CADEF5F.7070600@canonical.com>
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

2010/10/8 David Henningsson <david.henningsson@canonical.com>

> On 2010-10-07 15:43, Raymond Yau wrote:
> > 2010/10/7 Davyd McColl<davydm@gmail.com>
> >
> >> Good day
> >>
> >> I'm new to this list (though I've done some searching, I'm sure I could
> >> have
> >> missed something), so please bear with me.
> >>
> >> I filed a bug report recently against Ubuntu with respect to the problem
> >> I'm
> >> experiencing (as per the subject: jacking in my headphones doesn't mute
> the
> >> speaker output) and was informed that the decision had been made
> upstream
> >> as
> >> a design intention. I was linked off to:
> >>
> >>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030071.html
> >> with respect to the thread on this topic. I'd like to raise it again
> >> though,
> >> perhaps as a configurable feature, for the following reasons:
> >>
> >
> > Enable auto-muting in model=auto only for devices with HP and speakers.
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=2a2ed0dfc9ec44a899c7d4672f73f2c045099118;hp=299f293b3428ae6d73406642cd7d41f08d524c83
> >
> >
> > if the bios set your laptop 's speaker as line out , you need to
> implement a
> > new model for your laptop ,
>
> Can't you just override the pin config (via user_pin_configs in sysfs,
> or a patch file) in this case?
>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic <http://launchpad.net/%7Ediwic>
>

As you have not provided any output of alsa-info.sh  , it is impossible to
say this case is a regression or not


If the driver cannot find the [Pin Complex] Speaker at Int when you select
model=auto.
it assume that it is a desktop instead of a laptop

Some HDA codecs have "independent HP" switch (e.g. some of those VIA
codecs), the playback device 0 has 2 subdevices o allow headphone and the
line out - green jack at rear panel to play different audio stream
concurrently.

The driver cannot automute the line out when you pluggin the headphone in
this case and those VIA codecs have onle and only one model=auto
