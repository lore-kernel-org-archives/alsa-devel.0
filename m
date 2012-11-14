From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 15:54:15 -0500
Message-ID: <CA+7tXihk-0XPcVzB0cAHWDgCpn_XiQNxtwjqUUoActcndAj19A@mail.gmail.com>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <50A34FFD.4040603@canonical.com>
 <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>
 <201211142203.52948@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C58DA2625F4
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 21:54:16 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id fn1so869217vbb.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 12:54:16 -0800 (PST)
In-Reply-To: <201211142203.52948@leon.remlab.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?R=E9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2012 at 3:03 PM, R=E9mi Denis-Courmont <remi@remlab.net> wr=
ote:
> Le mercredi 14 novembre 2012 21:49:36, Trent Piepho a =E9crit :
>> > You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from t=
wo
>> > threads simultaneously. Could you elaborate on how this can happen, ma=
ybe
>> > it is easy to fix?
>>
>> gstreamer has no lock around the call to snd_pcm_delay().  So it can
>> race with snd_pcm_wait() or snd_pcm_writei(), which are called in
>> another thread.  There is a lock around the block of code calling
>> wait()/writei(), but this lock isn't used for calling delay().
>
> Use non-blocking I/O and poll(). Then the snd_pcm_write() calls will not =
sleep
> and can be interlocked with snd_pcm_delay() calls.

gstreamer uses non-blocking I/O.  But uses snd_pcm_wait rather than
poll directly.  I wonder if poll() is entirely correct when ALSA
plugins are in the chain?

"the snd_pcm_write() calls ...can be interlocked with snd_pcm_delay() calls=
".

It's still a race to call writei() and delay() at the same time, even
if writei() is non-blocking.  But only if the rate plugin is being
used.  Of course the actual race is very small, and doesn't include
the time spent doing resampling or mixing in plugins which are still
part of the writei() call in non-blocking mode.  It's basically like
the BKL around every ALSA call.

>> It seems that they didn't know there would be a problem.
>
> Eh? It is rather the exception for a library to be thread-safe when using=
 the
> same object in multiple threads.

It's ok to call kernel syscalls on the same fd at the same time.  The
kernel used to have the BKL for this.  Now it has fine grained locking
around the actual critical sections.  So if ALSA is called thread
safe, it doesn't seem that unreasonable to think one can do this.

> It looks more like "they" did not pay attention to what they were doing.

I think the point is that this bug was in gstreamer.  gstreamer is
commonly used by many people.  The bug has been there for years.  Many
programmers have looked at the code.  Yet no one noticed it or tracked
it down until now.  If it's so obvious why did it take so long?

You aren't aware of this problem in other multi-threaded code, but
that doesn't mean it doesn't exist.  You weren't aware of the problem
in gstreamer and yet it exists.
