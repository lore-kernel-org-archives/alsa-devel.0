From: Ivica Bukvic <ico@fuse.net>
Subject: Re: question regarding latest CS4205 laptop soundcard
	driver
Date: 27 Feb 2002 14:11:18 -0500
Message-ID: <1014837078.10692.18.camel@meowing.memh.uc.edu>
References: <200202271510.KAA11571@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from meowing.ccm.uc.edu (meowing.memh.uc.edu [129.137.2.219])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA27628
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2002 20:04:59 +0100
In-Reply-To: <200202271510.KAA11571@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@alsa-project.org, ico@fuse.net
List-Id: alsa-devel@alsa-project.org


> The trident cards can also do this. I believe that all cards that are
> actually capable of doing this and for which the docs have been
> provided have ALSA drivers that support it.

Well that's exactly where lies the problem. Most of the laptop
soundcards have marginal Alsa (and for that matter OSS) support. The
only ones that I am aware of so far of being able to do multiple
hardware streams in Linux are es1969 (thanks to Patrick Shirkey) and
Trident that you have mentioned (although I am not sure what model and
in what laptop), and possibly Yamaha chipset. That is rather sparse
choice and usually laptops that utilize these are either outdated or
have other peripherals weak (i.e. marginal video card).

>    Windows (WDM):     i don't know.

WDM is good, since Sonar claims sub-7 ms latencies on average sound
hardware in XP right out of the box.

> They don't do it flawlessly. It works for many simple cases. ASIO,
> which until WDM showed up was by far the preferred driver API for
> audio, doesn't allow device sharing at all AFAIK. 

I agree, my "flawless" statement was certainly overrated. Yet, the
question remains: what am I to do as a musician needing to utilize my
portable laptop while the apps/software I currently use get ported to
the JACK architecture (if they get ported at all)? Please don't get me
wrong, I do like to do programming, and I am about to join JACK
community. Yet, I need to continue "churning" music as well in order to
finish my degree. Programming alone will not get me there, although I
love Linux for what it is, and would love to contribute as much as my
time allows.

> don't consider it so rudimentary. you think of it as basic because
> Windows and MacOS did it, but they did it at the expense of
> low latency use. When Apple finally fixed this (with CoreAudio), they
> have forced not only a completely new API but for many people
> (non-ASIO developers), a whole new design on their developer community.

Well, what if we had at least a temporary, even higher-latency solution,
so that I could at least get some work done without worrying about these
serious software limitations and trying to come-up with poor and
temporary work-arounds?

Thanks for your insightful comments! Sincerely,

Ico



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
