From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Question regarding the alsa's audio latency benchmark
Date: Mon, 06 Oct 2003 22:11:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310070211.h972BIqI025360@oud>
References: <000001c38c74$f6825f20$0f02a8c0@ICO>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 06 Oct 2003 21:47:27 EDT."
             <000001c38c74$f6825f20$0f02a8c0@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Admittedly, it's quite old but that, if anything speaks only in Linux's
>favor in terms of its pro-audio readiness. At any rate, I was checking
>out the benchmark data and was wondering as to how did this
>person/software app get to the 0.73ms buffer fragment that is equal to
>128bytes? In other words, what sampling rate was used?

its based, IIRC, on the frequency of the RTC interrupt, which is
always in power-of-2 Hz.

>Furthermore, my question is what app was used to produce those
>graphs/results and whether these latency tests take into account
>hardware latencies (i.e. DSP converters, PCI->CPU->PCI->output etc.), in
>other words, is this latency that is achievable with the following
>setup:
>
>Input->soundcard->cpu(with some kind of DSP)->soundcard->Output

It isn't measuring that kind of latency. Benno wrote a custom program
to measure the ability to satisfy audio interface requirements.
Benno's test program is measuring how rapidly after an audio interface
interrupt it is possible to service the card. this is the "bottom
line" for latency performance - if you can't service the interrupt
quickly enough, nothing else matters. what his test was showing that
we can, from user space, service the card, although his test was based
on using the RTC, which for some hardware will allow you to get even
lower latencies than using the interface's own interrupt. its a hack,
though, and i wouldn't encourage people to do it.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
