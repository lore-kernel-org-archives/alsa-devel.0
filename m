From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: read size using poll
Date: Wed, 24 Apr 2002 15:51:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020424155109.6c356b49.mdeboer@iua.upf.es>
References: <20020424150836.7a19c5a1.mdeboer@iua.upf.es>
	<Pine.LNX.4.33.0204241526100.908-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA03765
	for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2002 15:52:33 +0200
In-Reply-To: <Pine.LNX.4.33.0204241526100.908-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > I was assuming that using poll (snd_pcm_wait), with the
> > alsa-lib/test/latency.c program would have snd_pcm_read
> > return period size samples at a time, but this is not
> > the case.
> > [..SNIP..]

> It's intended. It looks better in my eyes, if we can process some data 
> ahead in low-latency application that wait for whole batch. Of course, 
> optimized applications for cpu-usage might work differently.

I see... However, I can imagine many situations in which you are
processing with a fixed buffer size (doing an fft for example).
And I still think that it is reasonable to expect that the default
behavious is that readbuf will always return the same amount of
samples. Would it not be possible to add a commandline argument
to specify the behaviour ?

-p,--poll      use poll (wait for event - reduces CPU usage)
               events are generated when a new period of frames is available
-q,--quickpoll use poll (wait for event - reduces CPU usage)
               events are generated when new frames are available

or something like that. As the user has to specify either one, he/she will
be concient of what is happening.

Apart from that, I think it is a bit agressive that the default execution
of the latency test is non-blocking, which causes all CPU to go to the
latency test, and at first sight really looks like your machine locks up.
Would it be a good idea to make blocking the default, and change the
argument


-b,--block     block mode

for
-n,--nonblock  non-block mode

?

Maarten
