From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] pulseaudio eats 19% CPU power
	in Fedora 12
Date: Tue, 20 Apr 2010 11:30:31 +0800
Message-ID: <q2s4f3252891004192030jb1ef91c1g452136230bbe8f82@mail.gmail.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
	<4BCBE81F.6090606@intel.com> <20100419144832.GC1048@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 688BF1037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 05:30:33 +0200 (CEST)
Received: by pwj8 with SMTP id 8so3479440pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 20:30:32 -0700 (PDT)
In-Reply-To: <20100419144832.GC1048@tango.0pointer.de>
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

2010/4/19 Lennart Poettering <mznyfn@0pointer.de>

> On Mon, 19.04.10 13:20, Shuang He (shuang.he@intel.com) wrote:
>
> Please stop the cross-posting.
> >
>
> >         current latency: 444.25 ms
> >         requested latency: 31.25 ms
>
> So, this is interesting: the client requested 30ms (which is needlessly
> low, but that's another question), but the server ended up providing
> only 444 ms! That is incredibly high and points to the fact that PA
> probably ran into quite a few dropouts before this, presumably due to
> incorrect timing or suchlike, and hence bumped up the minimal latency
> all the time, and bumped down the sleeping time, hence eincreasing the
> CPU load. Almost certainly your audio driver is at fault here.
>
> Check syslog for any comments about that.
>
> Lennart
>
>
when using -ao oss or -ao alsa , mplayer use 16 fragments  and use 0.5
second for the buffer time .  about 31.25ms period time is quite normal

for hda driver which has a constraint of period size must be multiple of 128
bytes ( pcie brust size ) ,

cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 16384

In his case , mplayer is using alsa-pulse plugin and pulse device has no
specific constraint on hw_params , so 31.25 ms is normal since PA did not
reject the 0.5 seconds and 16 periods

since mplayer is no using pulse api , of course it will not adjust the
latency since pulse device is emulate an alsa hardware device
