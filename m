From: Ihar Filipau <thephilips@gmail.com>
Subject: Re: dmix produces garbled sound on ARM
Date: Thu, 9 Jun 2016 15:17:53 +0200
Message-ID: <CAD08gxL6TVwu63B11_Hs9qbvFgwDjPnv3Y4mV-pMss6mK2kuGg@mail.gmail.com>
References: <CAD08gxJmvpJ-DdGpEawmBZ4aZCNj_Gyhqdf7bSbqRrZ4Xa9Lqg@mail.gmail.com>
 <s5hshwmfre1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 777FB26070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 15:17:54 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id m124so10607349wme.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2016 06:17:54 -0700 (PDT)
In-Reply-To: <s5hshwmfre1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/9/16, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 09 Jun 2016 13:38:19 +0200,
> Ihar Filipau wrote:
>>
>> Hi All!
>>
>> When using the dmix on ARM, the sound comes out garbled, with as if
>> overlapping, increasing-in-number echoes. That happens even with a
>> single aplay instance.
>>
>> In a forum discussion, it was suggested that ARM lacks optimized dmix
>> implementation. But that implies that the generic dmix code is broken,
>> since it is what is used on ARM/etc, but not on i386/amd64. (The forum
>> discussion about my particular issue:
>> http://unix.stackexchange.com/questions/288451/sound-corruption-echo-when-trying-to-use-alsa-dmix
>> )
>>
>> Does anybody has any suggestions how to fix/avoid the dmix issue on ARM?
>
> This is likely the cache coherency issue.  For example, the generic
> dmix code works fine on x86-64 if I modify the ifdef condition (I
> tested now).
>

Thanks for the test!

> I suppose the mmap support is broken with your device / driver.
> Does "aplay -Dhw -M --period-size=1024 somefile.wav" work?  This
> should show a similar problem.
>

The command plays the audio perfectly well.

The hardware works, and it worked for quite some time now. But
apparently it doesn't support the hardware mixing (I'm not even sure
how to check that, found no documentation) while now we need the audio
playback from two applications. The second applications gets -EBUSY
when trying to open the "default" pcm. I have tried the 'dmix' - e.g.
"aplay -Dplug:dmix somefile.wav" . With that I can open the pcm
multiple times - "for X in 1 2 3 4; do aplay -Dplug:dmix somefile.wav
& ; done" - but the sound is garbled, whether it is a single aplay or
multiple aplays.

Is there any other way I can debug/trace the alsa to shed light on the
problem I'm having?

Thanks.
