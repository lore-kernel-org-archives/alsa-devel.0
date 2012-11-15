From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Thu, 15 Nov 2012 01:52:01 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C98764D@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <201211142203.52948@leon.remlab.net>
 <CA+7tXihk-0XPcVzB0cAHWDgCpn_XiQNxtwjqUUoActcndAj19A@mail.gmail.com>,
 <201211142319.08294@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 66C3C264F28
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 02:52:08 +0100 (CET)
In-Reply-To: <201211142319.08294@leon.remlab.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>, Trent Piepho <tpiepho@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.=
org] on behalf of R=E9mi Denis-Courmont [remi@remlab.net]
Sent: Wednesday, November 14, 2012 4:19 PM
To: Trent Piepho
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Races in alsa-lib with threads

Le mercredi 14 novembre 2012 22:54:15, Trent Piepho a =E9crit :
> gstreamer uses non-blocking I/O.  But uses snd_pcm_wait rather than
> poll directly.  I wonder if poll() is entirely correct when ALSA
> plugins are in the chain?
>
> "the snd_pcm_write() calls ...can be interlocked with snd_pcm_delay()
> calls".
>
> It's still a race to call writei() and delay() at the same time, even
> if writei() is non-blocking.  But only if the rate plugin is being
> used.  Of course the actual race is very small, and doesn't include
> the time spent doing resampling or mixing in plugins which are still
> part of the writei() call in non-blocking mode.  It's basically like
> the BKL around every ALSA call.

Of course, you will need a lock around many ALSA calls, at least all
potentially concurrent call. But that's a great improvement over holding a
lock while sleeping inside a blocking I/O operation.

> >> It seems that they didn't know there would be a problem.
> >
> > Eh? It is rather the exception for a library to be thread-safe when usi=
ng
> > the same object in multiple threads.
>
> It's ok to call kernel syscalls on the same fd at the same time.

Yes and no. Typically the kernel protects itself against undefined behaviour
induced by user space. But it does not protect user space against their own
undefined behaviour. The file descriptors table is a very good example of t=
hat.

In fact,  calling snd_pcm_delay() and snd_pcm_write() concurrently is just
PLAIN STUPID. The delay measurement may or may not include the impeding wri=
te
operation, or maybe only a part of it. Essentially, the delay value is not
much more than random garbage.

Hiding a mutex inside alsa-lib will NOT fix this intrinsic problem: Instead=
 of
having data races in memory, you will have logical races and gstreamer would
still be buggy in some ways.

> The kernel used to have the BKL for this.  Now it has fine grained locking
> around the actual critical sections.  So if ALSA is called thread
> safe, it doesn't seem that unreasonable to think one can do this.

Thread-safe means you can enter the library functions from multiple threads.
Thread-safe never meant that you can enter the library functions from multi=
ple
threads with the SAME DATA.

See also Lennart's and Kay's example library...

> > It looks more like "they" did not pay attention to what they were doing.
>
> I think the point is that this bug was in gstreamer.  gstreamer is
> commonly used by many people.  The bug has been there for years.  Many
> programmers have looked at the code.  Yet no one noticed it or tracked
> it down until now.  If it's so obvious why did it take so long?
>
> You aren't aware of this problem in other multi-threaded code, but
> that doesn't mean it doesn't exist.  You weren't aware of the problem
> in gstreamer and yet it exists.

Hey, I don't use gstreamer.  VLC has interlocked its ALSA calls for many ye=
ars
and I did not blame alsa-lib for not doing it internally. In fact, I realiz=
ed
that this was not a problem that ALSA could nor should solve.

Also, all audio APIs are like that. Even PulseAudio requires the application
to acquire locks explicitly.

--
R=E9mi Denis-Courmont
http://www.remlab.net/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Hi Remi,

We have a solution now that we are testing where the ALSA calls reside is a=
 single thread within the GStreamer ALSA Sink plugin.  Once we tested it fo=
r a bit, we will submit it to the GStreamer folks for approval.  Now that t=
he ALSA Wiki has been updated with Jarloslav's caveat about ALSA thread saf=
ety, newbies should no longer misuse that ALSA Lib API.  Thanks so much for=
 your insight and for Takashi's and Jarloslav's help as well.  Sorry to tak=
e up so much of your time.  ;-)

Best Regards,

Rob
