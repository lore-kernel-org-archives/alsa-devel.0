From: Paul Davis <pbd@op.net>
Subject: Re: ALSA Hammerfall DSP driver
Date: Fri, 24 May 2002 10:06:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205241404.g4OE4En24762@post2.fast.net>
References: <001501c202ff$a945b8b0$1700a8c0@sme>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA32548
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 16:04:25 +0200
In-Reply-To: Your message of "Fri, 24 May 2002 10:47:39 +0200."
             <001501c202ff$a945b8b0$1700a8c0@sme>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: sme <marius.schebella@chello.at>
Cc: Marcus Andersson <054185595@telia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>i'm new to this list. i'm writing because i have a hammerfall dsp
>multiface soundcard with a pcmcia interface and would like to run it
>under linux. is it already possible to test the new drivers? i think i
>will need some help to get it to run for i have not so much experience
>in solving difficult (for me) problems. maybe you can tell me whether
>it's better to wait for a more stable release, or give it a try and tell
>me where i can access the drivers.

You are welcome to try it out. it has a few issues still remaining, and
there are no tools to properly control the matrix mixer at this time,
but it works for myself and several other people. 

Oh, I just noticed that you have the cardbus version. I would
appreciate if you would try it. There appear to be possible kernel
problems unrelated to ALSA or the H-DSP driver. I am still trying to
understand what is going on.

>btw. what does CVS stand for?

Concurrent Versions System. It allows multiple developers to be
working on the same source code files at the same term, then "merge"
their changes (perhaps overlapping changes) together. Many open source
and software libre projects use it to allow collaboration over the
internet in an effective and managed way.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
