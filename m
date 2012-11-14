From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 12:55:33 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C9874E7@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org> <s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>,
 <50A34FFD.4040603@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id EB48A2616BB
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 13:55:37 +0100 (CET)
In-Reply-To: <50A34FFD.4040603@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Trent Piepho <tpiepho@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of David Henningsson [david.henningsson@canonical.com]
Sent: Wednesday, November 14, 2012 3:02 AM
To: Trent Piepho
Cc: Takashi Iwai; alsa-devel@alsa-project.org; Krakora Robert-B42341
Subject: Re: [alsa-devel] Races in alsa-lib with threads

On 11/13/2012 08:41 PM, Trent Piepho wrote:
> On Tue, Nov 13, 2012 at 8:50 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Tue, 13 Nov 2012 13:39:24 +0000,
>> Krakora Robert-B42341 wrote:
>>> The way that the GStreamer ALSA Sink Plugin is using ALSA Lib assumes that it is thread safe.  The fix crafted by one of Trent's colleagues (attached) seems to be the way to go.  However, I don't know how it would impact other functionality within ALSA Lib.
>>
>> No, sorry, we don't want to introduce pthread_lock in alsa-lib PCM
>> stuff.
>>
>
> The problem with introduction serialization outside alsa-lib is that
> you must now serialize entire ALSA calls.  The locks must be held for
> far too long.
>
> Consider snd_pcm_writei(), most of the time is usually spent blocked
> waiting for a period to elapse.  It is perfectly ok to call
> snd_pcm_delay() during this time.  But if one isn't allowed to make
> any other pcm calls during snd_pcm_writei() then this can't be done.
>
> It's a pretty big problem.  Most code using blocking mode is going to
> write another period as soon as the writei call returns from the last
> write.  It will spend almost all its time inside snd_pcm_writei() and
> thus will always be holding the app's pcm stream lock.  As soon as it
> releases the lock it grabs it again for the next write.  Another
> thread trying to call snd_pcm_delay() will virtually NEVER get a
> chance.  Not only is it unnecessary stopped from getting the delay
> while another thread is blocked inside writei(), but it won't get a
> chance to call it between writei() calls either.
>
> But there doesn't need to be a conflict, since the actual critical
> section that needs locking is very small, far smaller than the time
> spent sleeping inside writei() or wait().  How can just the critical
> section be protected without placing the locking inside alsa-lib?

Hmm, but the great majority of programs are not interested in accessing
alsa-lib from multiple threads in the way that's currently unsafe. That
includes programs who are very dependent on low latency. I would not
like to see all these programs to suffer from the overhead of adding
locks here and there, even if those locks are small.

You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from two
threads simultaneously. Could you elaborate on how this can happen,
maybe it is easy to fix?



--
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Hi David,

It is not just merely a claim, it is a fact that the GStreamer ALSA Sink plugin calls snd_pcm_delay() on a different thread from snd_pcm_writei().  We believe that we may now have a workable solution and Jarloslav updated the ALSA wiki to reflect that ALSA is SMP/thread safe in the kernel space but no in user space.  I believe that this is probably where the disconnect was; developers, that do not develop but merely use ALSA, misled by the original statement at the top of the ALSA wiki that ALSA was thread safe.  I think we all understand the issue of added latency in regards to the addition of mutexes and are in agreement with the ALSA developers in this regard.

Best Regards,

Rob Krakora
