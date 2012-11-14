From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 20:06:22 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C9875DB@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <50A34FFD.4040603@canonical.com>
 <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>,
 <201211142203.52948@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C892625D5
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 21:06:37 +0100 (CET)
In-Reply-To: <201211142203.52948@leon.remlab.net>
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
To: =?iso-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Trent Piepho <tpiepho@gmail.com>
List-Id: alsa-devel@alsa-project.org

________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.=
org] on behalf of R=E9mi Denis-Courmont [remi@remlab.net]
Sent: Wednesday, November 14, 2012 3:03 PM
To: alsa-devel@alsa-project.org
Cc: Trent Piepho
Subject: Re: [alsa-devel] Races in alsa-lib with threads

        Hello,

Le mercredi 14 novembre 2012 21:49:36, Trent Piepho a =E9crit :
> > You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from two
> > threads simultaneously. Could you elaborate on how this can happen, may=
be
> > it is easy to fix?
>
> gstreamer has no lock around the call to snd_pcm_delay().  So it can
> race with snd_pcm_wait() or snd_pcm_writei(), which are called in
> another thread.  There is a lock around the block of code calling
> wait()/writei(), but this lock isn't used for calling delay().

Use non-blocking I/O and poll(). Then the snd_pcm_write() calls will not sl=
eep
and can be interlocked with snd_pcm_delay() calls.

> It seems that they didn't know there would be a problem.

Eh? It is rather the exception for a library to be thread-safe when using t=
he
same object in multiple threads.

It looks more like "they" did not pay attention to what they were doing.

--
R=E9mi Denis-Courmont
http://www.remlab.net/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

HI R=E9mi,

We are using non-blocking mode with snd_pcm_wait() and snd_pcm_writei().  W=
e have a workable solution.  Thanks for the advice.

Best Regards.

Rob
