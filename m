From: Paul Davis <pbd@Op.Net>
Subject: Re: [Jackit-devel] Re: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 08:50:45 -0500
Message-ID: <200202141355.IAA27451@renoir.op.net>
In-reply-to: Your message of "Thu, 14 Feb 2002 15:35:19 +0200."
             <Pine.LNX.4.44.0202141523230.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I've now added a few debugging points to jackd's alsa_driver.c:
>	- five checks for xruns in various parts
>	  of alsa_driver_wait() (prints an error if xrun
>	  is detected; check with snd_pcm_state())
>	- prints an error if playback_avail or capture_avail
>	  is not 1024 (period size in use)
>	- prints a warning everytime alsa_driver_wait()
>	  takes more than 25msecs (23.2msec == period time)
>
>In the below test run, audio got garbled when the ecasound
>subgraph timed out. To create the timeout I generated lot of cpu and disk 
>i/o stress. Few points to note:
>
>- no xruns are detected even though after the timeout
>  alsa_driver_wait() took 56.4msec which is more than
>  period_size * number_of_periods (1024*2/44100*1000=46msec);
>  in other words there should have been an xrun

i recall abramo saying that if the xrun happens within an
mmap_begin/commit pair, the driver can't detect it, or something like
that. 

i added kernel debugging to the hammerfall driver to check on aspects
of this problem. it demonstrated that everything at the driver level
was as expected. because this problem occurs on several different
cards, i am starting to suspect part of jack's design rather than
ALSA, but i have not yet managed to figure out what it could be. when
i check the channel_area_t addresses used by jack, they also appear to
be just as one would expect.

btw, ctrl-c'ing jack_simple_client will cause a timeout 80% of the
time on my machine, which is a simple, load-free way to create the problem.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
