From: "=?iso-8859-1?q?R=E9mi?= Denis-Courmont" <remi@remlab.net>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 22:03:52 +0200
Message-ID: <201211142203.52948@leon.remlab.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <50A34FFD.4040603@canonical.com>
 <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id BDE852625D5
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 21:03:54 +0100 (CET)
In-Reply-To: <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Trent Piepho <tpiepho@gmail.com>
List-Id: alsa-devel@alsa-project.org

	Hello,

Le mercredi 14 novembre 2012 21:49:36, Trent Piepho a =E9crit :
> > You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from two
> > threads simultaneously. Could you elaborate on how this can happen, may=
be
> > it is easy to fix?
> =

> gstreamer has no lock around the call to snd_pcm_delay().  So it can
> race with snd_pcm_wait() or snd_pcm_writei(), which are called in
> another thread.  There is a lock around the block of code calling
> wait()/writei(), but this lock isn't used for calling delay().

Use non-blocking I/O and poll(). Then the snd_pcm_write() calls will not sl=
eep =

and can be interlocked with snd_pcm_delay() calls.

> It seems that they didn't know there would be a problem.

Eh? It is rather the exception for a library to be thread-safe when using t=
he =

same object in multiple threads.

It looks more like "they" did not pay attention to what they were doing.

-- =

R=E9mi Denis-Courmont
http://www.remlab.net/
