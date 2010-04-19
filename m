From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Mon, 19 Apr 2010 16:34:05 +0800
Message-ID: <y2z4f3252891004190134g4bbb189enb81a1422e65aeb9@mail.gmail.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 72A1724628
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 10:34:06 +0200 (CEST)
Received: by pvg12 with SMTP id 12so2529491pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 01:34:05 -0700 (PDT)
In-Reply-To: <20100419032856.GA13629@tango.0pointer.de>
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

> On Wed, 14.04.10 15:56, Wu Fengguang (fengguang.wu@intel.com) wrote:
>
> > Hi Lennart,
> >
> > We found that pulseaudio eats CPU ~19% CPU time, a little more than
> > mplayer when playing video. This is horrible for laptop batteries.
>
> This is not a particularly useful report.
>
> You know, this can have so many different reasons, the only thing I can
> really say, is that you can rest assured that it is not supposed to eat
> that much in normal use.
>
> The CPU usage of PA is primarily dependant of the latency requested by
> the clients. Low latency means high CPU load. Lower latency means higher
> CPU load. Try "pacmd list-sink-inputs" to figure out the latency the
> various applications requested.
>
> Then there can be driver problems, where the timing information is not
> entirely correct that ALSA passes on to, with the result that we get
> dropouts where we shouldn't, with the results that we shorten our sleep
> times, with the final effect that the CPU usage goes up.
>
> Of course, if PA is used resampling and suchlike is moved from the
> clients into the sound server and hence will be added to its CPU
> usage. And PA uses a better resampler by default than ALSA traditionally
> did, hence the CPU use will be a bit higher than plain ALSA.
>
> And then of course, the CPU usage depends on the CPU used. Is this some
> embedded hardware?
>
> In summary: if you want to know what is going on, you need a suitable
> tool, like a profiler and do the dirty work to figure out what is going
> on. Just saying "19%" is not helpful to figure out what is going on.
>
> On my machine here it uses 3% CPU while playing.
>
> > Can we make it just work -- in green CPU mode?
>
> Yes, sure. If you use "pacat" you can play audio with almost zero CPU
> usage, because it is one of the few clients that actually asks for
> sensible latency (2s), which allows us to minimize the wakeup intervals
> to less than a second.
>
> > I can find many users
> > complaining about this, and it seems like some fix is available in
> > this link:
> > https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/207135
>
> Fix? Where?
>
> Lennart
>
>
AFAIK , the CPU usage increase with the number of applications connected to
PA server .

If I run 4 instances of mplayer on Fedora 10 , the CPU usage will increase
from 3% to 12%
