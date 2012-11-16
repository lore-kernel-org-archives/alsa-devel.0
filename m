From: Daniel Sanz <daniellsanz2@gmail.com>
Subject: Re: snd_pcm_wait function
Date: Fri, 16 Nov 2012 11:41:54 +0100
Message-ID: <CAHU0+dTL=rc6gMc49cWiUL3rL2_92myqYrReCUbK3hVy4BB=DA@mail.gmail.com>
References: <50A0A3FE.4090901@tele2.nl> <50A0A709.1050307@ladisch.de>
 <CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>
 <CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>
 <CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A5952616FA
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 11:41:56 +0100 (CET)
Received: by mail-qa0-f44.google.com with SMTP id c4so3322515qae.17
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 02:41:55 -0800 (PST)
In-Reply-To: <CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
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
Cc: Enno Fennema <ennofennema@tele2.nl>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Thanks, Trent, I've been playing a bit with snd_pcm_drain,
snd_pcm_writei, blocking mode, non-blocking mode, etc. but even if I
fill a full last period, audio does not play from the beginning to end
unless I call snd_pcm_drain just before closing the stream. I think
there is some concept that I'm missing about how ALSA works, or maybe
my driver/ALSA configuration is broken (I'm using Arch Linux).

Do you have a brief example of playing a short WAV file using ALSA?

On Tue, Nov 13, 2012 at 5:45 AM, Trent Piepho <tpiepho@gmail.com> wrote:
> snd_pcm_drain() will drain all the pending periods.  In effect, it
> rounds up however many frames are left in the buffer to the next whole
> period.  There is no way to just drain a partially full period.
>
> If you always wrote full periods, and didn't use non-blocking mode so
> that each writei call always wrote everything before returning, then
> you shouldn't have a partially filled period at the end of the buffer.
>
> ALSA has the exact buffer pointer value of the app pointer and also
> when a period should elapse, and could easily tell you the buffer fill
> value mod period size, but I don't think there is any API for that.
>
> On Mon, Nov 12, 2012 at 7:15 PM, Daniel Sanz <daniellsanz2@gmail.com> wrote:
>> Can I expect that there won't be any pending frames (so no need to
>> call snd_pcm_drain) if I always use snd_pcm_writei to write multiples
>> of the period size?
>>
>> And what if the sound is very short or the period size is big? the
>> latency of hardware is negligible?
>>
>> Thanks,
>>
>> On Mon, Nov 12, 2012 at 9:57 PM, Trent Piepho <tpiepho@gmail.com> wrote:
>>> You do have to fill to a full period before calling drain, or it won't
>>> work in a very useful way.  It only stops when periods elapse.  So if
>>> you have a half full period of audio at the end of the buffer you'll
>>> get garbage when it plays to the end of that period before stopping.
>>>
>>> On Mon, Nov 12, 2012 at 2:36 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>>> Enno Fennema wrote:
>>>>> I want to close the pcm AFTER the sound finished.
>>>>
>>>> Then close it after snd_pcm_drain() has returned.
>>>>
>>>>> The docs say calling drain() puts the pcm in the DRAINING state.
>>>>
>>>> It also waits until the device has drained (unless the device is in
>>>> non-blocking mode).
>>>>
>>>>> When I obtain the state immediately after drain() it is already SETUP.
>>>>> I hoped a state change from DRAINING to SETUP  would be the right time
>>>>> to close the pcm but there appears to be no such state change.
>>>>
>>>> That change happens immediately before snd_pcm_drain() returns.
>>>>
>>>>
>>>> Regards,
>>>> Clemens
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
