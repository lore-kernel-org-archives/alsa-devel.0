From: "=?iso-8859-1?q?R=E9mi?= Denis-Courmont" <remi@remlab.net>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 23:19:08 +0200
Message-ID: <201211142319.08294@leon.remlab.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <201211142203.52948@leon.remlab.net>
 <CA+7tXihk-0XPcVzB0cAHWDgCpn_XiQNxtwjqUUoActcndAj19A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 2308D264F06
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 22:19:10 +0100 (CET)
In-Reply-To: <CA+7tXihk-0XPcVzB0cAHWDgCpn_XiQNxtwjqUUoActcndAj19A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le mercredi 14 novembre 2012 22:54:15, Trent Piepho a =E9crit :
> gstreamer uses non-blocking I/O.  But uses snd_pcm_wait rather than
> poll directly.  I wonder if poll() is entirely correct when ALSA
> plugins are in the chain?
> =

> "the snd_pcm_write() calls ...can be interlocked with snd_pcm_delay()
> calls".
> =

> It's still a race to call writei() and delay() at the same time, even
> if writei() is non-blocking.  But only if the rate plugin is being
> used.  Of course the actual race is very small, and doesn't include
> the time spent doing resampling or mixing in plugins which are still
> part of the writei() call in non-blocking mode.  It's basically like
> the BKL around every ALSA call.

Of course, you will need a lock around many ALSA calls, at least all =

potentially concurrent call. But that's a great improvement over holding a =

lock while sleeping inside a blocking I/O operation.

> >> It seems that they didn't know there would be a problem.
> > =

> > Eh? It is rather the exception for a library to be thread-safe when usi=
ng
> > the same object in multiple threads.
> =

> It's ok to call kernel syscalls on the same fd at the same time.

Yes and no. Typically the kernel protects itself against undefined behaviou=
r =

induced by user space. But it does not protect user space against their own =

undefined behaviour. The file descriptors table is a very good example of t=
hat.

In fact,  calling snd_pcm_delay() and snd_pcm_write() concurrently is just =

PLAIN STUPID. The delay measurement may or may not include the impeding wri=
te =

operation, or maybe only a part of it. Essentially, the delay value is not =

much more than random garbage.

Hiding a mutex inside alsa-lib will NOT fix this intrinsic problem: Instead=
 of =

having data races in memory, you will have logical races and gstreamer woul=
d =

still be buggy in some ways.

> The kernel used to have the BKL for this.  Now it has fine grained locking
> around the actual critical sections.  So if ALSA is called thread
> safe, it doesn't seem that unreasonable to think one can do this.

Thread-safe means you can enter the library functions from multiple threads=
. =

Thread-safe never meant that you can enter the library functions from multi=
ple =

threads with the SAME DATA.

See also Lennart's and Kay's example library...

> > It looks more like "they" did not pay attention to what they were doing.
> =

> I think the point is that this bug was in gstreamer.  gstreamer is
> commonly used by many people.  The bug has been there for years.  Many
> programmers have looked at the code.  Yet no one noticed it or tracked
> it down until now.  If it's so obvious why did it take so long?
> =

> You aren't aware of this problem in other multi-threaded code, but
> that doesn't mean it doesn't exist.  You weren't aware of the problem
> in gstreamer and yet it exists.

Hey, I don't use gstreamer.  VLC has interlocked its ALSA calls for many ye=
ars =

and I did not blame alsa-lib for not doing it internally. In fact, I realiz=
ed =

that this was not a problem that ALSA could nor should solve.

Also, all audio APIs are like that. Even PulseAudio requires the applicatio=
n =

to acquire locks explicitly.

-- =

R=E9mi Denis-Courmont
http://www.remlab.net/
