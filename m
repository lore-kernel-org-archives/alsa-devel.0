From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA Mixer issue
Date: Fri, 30 Jul 2010 15:30:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007301528130.4068@eeebox2.perex-int.cz>
References: <AANLkTi=5Cxxv6bCuFZ9TB7wOKo0m1FrNTvHiOqmhXMAu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ED061039EC
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 15:30:03 +0200 (CEST)
In-Reply-To: <AANLkTi=5Cxxv6bCuFZ9TB7wOKo0m1FrNTvHiOqmhXMAu@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan bisht <bisht.sudarshan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Jul 2010, sudarshan bisht wrote:

> Hi ,
>
> I wanted to know that can we use multiple handlers for the same ALSA mixer ?
>
> My use case is something like this .
>
> I have two modules and having two different handlers for ALSA mixer.  First
> module does some volume change , and I try to read the latest volume using
> my second handler ( of first second module) .
>
> But I am not getting the most recent value in second handler ( the volume
> set by the first module )  so I feel there is some inconsistency when I use
> two handlers from two different modules in order to fetch volume information
> from the ALSA mixer.

You must sync the cached information using poll() or select() on file 
descriptors returned by snd_mixer_poll_descriptors_*() functions and call 
snd_mixer_handle_events() if any events are waiting.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
