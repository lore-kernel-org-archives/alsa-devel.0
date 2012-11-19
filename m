From: Daniel Sanz <daniellsanz2@gmail.com>
Subject: Re: snd_pcm_wait function (really snd_pcm_draiin)
Date: Mon, 19 Nov 2012 12:10:54 +0100
Message-ID: <CAHU0+dQv_JK9RvcbaqdLaZbTTJPVirc8MM5i=PyH1DH5urf6Wg@mail.gmail.com>
References: <50A0A3FE.4090901@tele2.nl> <50A0A709.1050307@ladisch.de>
 <CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>
 <CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>
 <CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
 <CAHU0+dTL=rc6gMc49cWiUL3rL2_92myqYrReCUbK3hVy4BB=DA@mail.gmail.com>
 <50A6695B.6080202@tele2.nl> <50A68FAE.9010505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 645C126163D
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 12:10:55 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so2912749qcs.38
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 03:10:54 -0800 (PST)
In-Reply-To: <50A68FAE.9010505@canonical.com>
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
Cc: Enno Fennema <ennofennema@tele2.nl>, alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Yes, David, you are right, it's actually pulseaudio blocking for about
2 seconds after the sound is played. You can see it by tracing an
application that calls snd_pcm_drain using strace -tt.

I think I worked around the problem by sleeping before calling snd_pcm_drain:
...
snd_pcm_delay(handle, &delay);
usleep(delay * microseconds_per_frame);
snd_pcm_drain(handle);
...

Similar workarounds are implemented in other software, like Mplayer, I believe.

Regards,

On Fri, Nov 16, 2012 at 8:10 PM, David Henningsson
<david.henningsson@canonical.com> wrote:
> On 11/16/2012 05:27 PM, Enno Fennema wrote:
>>
>> On 11/16/12 11:41, Daniel Sanz wrote:
>>>
>>> Thanks, Trent, I've been playing a bit with snd_pcm_drain,
>>> snd_pcm_writei, blocking mode, non-blocking mode, etc. but even if I
>>> ...
>>
>>
>> I wanted to play a short sound and release the pcm. It works with a
>> non-block drain as Clemens suggested.
>>
>> I noticed using gettimeofday() around drain() that it takes a bit over 2
>> seconds. Rather long for a sound that only takes 0.1 sec.
>
>
> That is a known pulseaudio problem; which we also noted on PulseConf a few
> weeks ago. I want to do something about it but it is not on the top of my
> priority list right now.
>
> Are the rest of you trying with PulseAudio as well? Maybe it could be worth
> also trying the direct plughw path do see if the behaviour is different.
>
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
