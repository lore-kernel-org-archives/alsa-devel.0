From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Wed, 27 Apr 2011 09:00:56 +0800
Message-ID: <BANLkTinXTK541r+2ae-iadn7jTzD2O4QOQ@mail.gmail.com>
References: <4DB02F8A.4040001@canonical.com>
	<BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
	<4DB67BD3.7090706@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 74C4C10385E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 03:00:57 +0200 (CEST)
Received: by fxm5 with SMTP id 5so956413fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 18:00:57 -0700 (PDT)
In-Reply-To: <4DB67BD3.7090706@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maarten Lankhorst <m.b.lankhorst@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/26 David Henningsson <david.henningsson@canonical.com>

> On 2011-04-22 01:25, Raymond Yau wrote:
>
>> 2011/4/21 David Henningsson<david.henningsson@canonical.com>
>>
>>  Due to a round-off error, snd_pcm_avail could in some cases
>>> return 0 even though more data could be written to the stream.
>>>
>>> This was discovered by Maarten Lankhorst [1], and there is also a test
>>> program available that triggers this error [2].
>>>
>>> [1]
>>>
>>> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009935.html
>>>
>>> [2]
>>>
>>> https://tango.0pointer.de/pipermail/pulseaudio-discuss/attachments/20110420/3c852d6e/attachment.c
>>>
>>>
>> if the test program can force under-run occur with "hw" device and "pulse"
>> device with his patch in
>>
>> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009918.html
>>
>> Is it normal that underrun does not occur with the test program and your
>> patch
>>
>
> Yes; underruns are not reported to the application due to the risk of the
> underrun being obsolete at that time. As for Maarten's patch in the post you
> refer to,
>
> 1) if underruns are being reported (this is configurable), it might be a
> good idea to call "pulse_start".
>
> 2) it changes underruns to being reported by default, which is what I'm
> opposed to.
>
> >>> However if I force underruns to occur, the state will stay running and
it appears
>>> there is still some data left in the buffer, so sound stalls entirely.
The latency gets >>> updated to something like 0x7bdXXXXXXXXXXXXX which
looks suspiciously
>>> much like a pointer to me, which may be a bug.
>>> So my questions are.
>>> 1. Is the weird latency value update a bug? Digging it up I can only
assume it's a
>>> bug in src/stream.c , but I haven't figured out why yet.  Tested with
pulseaudio.c
>>> 2. Any comments on this patch for alsa-plugins?

There are some difference between devices "hw" , "plug:dmix" and "pulse"
when I run "aplay -v --test-position any.wav" with different period size and
buffer size

It seem that the delay of  device "pulse" is much larger than those of
"dmix" and "hw"
