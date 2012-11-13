From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: snd_pcm_wait function
Date: Mon, 12 Nov 2012 23:45:10 -0500
Message-ID: <CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
References: <50A0A3FE.4090901@tele2.nl> <50A0A709.1050307@ladisch.de>
 <CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>
 <CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C12B2650AC
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 05:45:11 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id f13so6815812vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 20:45:10 -0800 (PST)
In-Reply-To: <CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Sanz <daniellsanz2@gmail.com>
Cc: Enno Fennema <ennofennema@tele2.nl>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

snd_pcm_drain() will drain all the pending periods.  In effect, it
rounds up however many frames are left in the buffer to the next whole
period.  There is no way to just drain a partially full period.

If you always wrote full periods, and didn't use non-blocking mode so
that each writei call always wrote everything before returning, then
you shouldn't have a partially filled period at the end of the buffer.

ALSA has the exact buffer pointer value of the app pointer and also
when a period should elapse, and could easily tell you the buffer fill
value mod period size, but I don't think there is any API for that.

On Mon, Nov 12, 2012 at 7:15 PM, Daniel Sanz <daniellsanz2@gmail.com> wrote:
> Can I expect that there won't be any pending frames (so no need to
> call snd_pcm_drain) if I always use snd_pcm_writei to write multiples
> of the period size?
>
> And what if the sound is very short or the period size is big? the
> latency of hardware is negligible?
>
> Thanks,
>
> On Mon, Nov 12, 2012 at 9:57 PM, Trent Piepho <tpiepho@gmail.com> wrote:
>> You do have to fill to a full period before calling drain, or it won't
>> work in a very useful way.  It only stops when periods elapse.  So if
>> you have a half full period of audio at the end of the buffer you'll
>> get garbage when it plays to the end of that period before stopping.
>>
>> On Mon, Nov 12, 2012 at 2:36 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>> Enno Fennema wrote:
>>>> I want to close the pcm AFTER the sound finished.
>>>
>>> Then close it after snd_pcm_drain() has returned.
>>>
>>>> The docs say calling drain() puts the pcm in the DRAINING state.
>>>
>>> It also waits until the device has drained (unless the device is in
>>> non-blocking mode).
>>>
>>>> When I obtain the state immediately after drain() it is already SETUP.
>>>> I hoped a state change from DRAINING to SETUP  would be the right time
>>>> to close the pcm but there appears to be no such state change.
>>>
>>> That change happens immediately before snd_pcm_drain() returns.
>>>
>>>
>>> Regards,
>>> Clemens
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
