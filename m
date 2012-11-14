From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: Races in alsa-lib with threads
Date: Wed, 14 Nov 2012 14:49:36 -0500
Message-ID: <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>
 <s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>
 <50A34FFD.4040603@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C5902625D5
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 20:49:37 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id f13so830501vcb.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:49:36 -0800 (PST)
In-Reply-To: <50A34FFD.4040603@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Krakora Robert-B42341 <B42341@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2012 at 3:02 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 11/13/2012 08:41 PM, Trent Piepho wrote:
>>
>> On Tue, Nov 13, 2012 at 8:50 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>
>>> At Tue, 13 Nov 2012 13:39:24 +0000,
>>> Krakora Robert-B42341 wrote:
>>>>
>>>> The way that the GStreamer ALSA Sink Plugin is using ALSA Lib assumes
>>>> that it is thread safe.  The fix crafted by one of Trent's colleagues
>>>> (attached) seems to be the way to go.  However, I don't know how it would
>>>> impact other functionality within ALSA Lib.
>>>
>>>
>>> No, sorry, we don't want to introduce pthread_lock in alsa-lib PCM
>>> stuff.
>>>
>>
>> The problem with introduction serialization outside alsa-lib is that
>> you must now serialize entire ALSA calls.  The locks must be held for
>> far too long.
>>
>> Consider snd_pcm_writei(), most of the time is usually spent blocked
>> waiting for a period to elapse.  It is perfectly ok to call
>> snd_pcm_delay() during this time.  But if one isn't allowed to make
>> any other pcm calls during snd_pcm_writei() then this can't be done.
>>
>> It's a pretty big problem.  Most code using blocking mode is going to
>> write another period as soon as the writei call returns from the last
>> write.  It will spend almost all its time inside snd_pcm_writei() and
>> thus will always be holding the app's pcm stream lock.  As soon as it
>> releases the lock it grabs it again for the next write.  Another
>> thread trying to call snd_pcm_delay() will virtually NEVER get a
>> chance.  Not only is it unnecessary stopped from getting the delay
>> while another thread is blocked inside writei(), but it won't get a
>> chance to call it between writei() calls either.
>>
>> But there doesn't need to be a conflict, since the actual critical
>> section that needs locking is very small, far smaller than the time
>> spent sleeping inside writei() or wait().  How can just the critical
>> section be protected without placing the locking inside alsa-lib?
>
> Hmm, but the great majority of programs are not interested in accessing
> alsa-lib from multiple threads in the way that's currently unsafe. That
> includes programs who are very dependent on low latency. I would not like to
> see all these programs to suffer from the overhead of adding locks here and
> there, even if those locks are small.

Maybe they just don't know it's unsafe and don't hit a race often
enough to notice?

> You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from two
> threads simultaneously. Could you elaborate on how this can happen, maybe it
> is easy to fix?

gstreamer has no lock around the call to snd_pcm_delay().  So it can
race with snd_pcm_wait() or snd_pcm_writei(), which are called in
another thread.  There is a lock around the block of code calling
wait()/writei(), but this lock isn't used for calling delay().  It
seems that they didn't know there would be a problem.

And if you're not using the alsa rate plugin, then I don't think
snd_pcm_delay() has a race with snd_pcm_writei().  delay for a hw
device will call an ioctl to just get the delay.  I think that's ok,
assuming the kernel part has no races.  It's only when using the rate
plugin that snd_pcm_delay() will try to update the pointer and race
with writei.

So unless you use the rate plugin, you'll never notice this race.
