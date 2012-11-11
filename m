From: Daniel Sanz <daniellsanz2@gmail.com>
Subject: Re: Non-blocking snd_pcm_drain?
Date: Sun, 11 Nov 2012 19:10:42 +0100
Message-ID: <CAHU0+dS7W+Xa9FMxTU1J-0mka4p0fuF9y5a1KXoWx-hfKdnoEQ@mail.gmail.com>
References: <CAHU0+dREbMHoAKOHgPpHfEO+kr93d1FmtrrQ6-nXUN3=7MqGxw@mail.gmail.com>
 <509E8ECD.7080205@ladisch.de>
 <CAHU0+dTCkmMiF9P9FJUj0n3kU7aGt72P_fc_tMSo6ZDp+PEtqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B43E326171E
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 19:10:43 +0100 (CET)
Received: by mail-qa0-f51.google.com with SMTP id t11so1373482qaa.17
 for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2012 10:10:42 -0800 (PST)
In-Reply-To: <CAHU0+dTCkmMiF9P9FJUj0n3kU7aGt72P_fc_tMSo6ZDp+PEtqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Removing the last line, snd_pcm_close(handle), plays the entire sound,
but I don't think it is a good solution.

It is like there is somewhere a huge latency between the moment I call
snd_pcm_writei and the moment I hear sound, but I don't know what's
causing this. I've even tried reducing the period size to 32 frames or
padding the last buffer with zeros, but no luck either.

I'm out of ideas.


On Sat, Nov 10, 2012 at 6:57 PM, Daniel Sanz <daniellsanz2@gmail.com> wrote:
> If I don't drain the buffer, then I don't hear the entire sound, even
> though I think I'm writing correctly all the frames.
>
> Here's the relevant code (playback of 2 seconds of a sound file
> represented by file pointer "fp"):
>
>         snd_pcm_hw_params_get_period_size(params, &frames, 0);
>         buffer_size = frames * channels * 2;
>         buffer = (char*)malloc(buffer_size);
>
>         snd_pcm_hw_params_get_period_time(params, &period_time, NULL);
>
>         for (loops = (2 * 1000000) / period_time; loops > 0; loops--)
>         {
>                 fread(buffer, sizeof(char), buffer_size, fp);
>
>                 if ((err = snd_pcm_writei(handle, buffer, frames)) == -EPIPE)
>                 {
>                         printf("XRUN.\n");
>                         snd_pcm_prepare(handle);
>                 }
>                 else if (err < 0)
>                 {
>                         printf("ERROR. Can't write to the device. %s\n", snd_strerror(err));
>                 }
>        }
>
>        snd_pcm_close(handle);
>
> Thanks,
>
> On Sat, Nov 10, 2012 at 6:28 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>>
>> Daniel Sanz wrote:
>> > I noticed that the snd_pcm_drain call blocks until the buffer is
>> > completely drained. Is there any way to drain the buffer without
>> > a block?
>>
>> Try calling snd_pcm_nonblock(handle, 1).
>>
>> > I've tried calling snd_pcm_nonblock(handle, 1) before the call to
>> > snd_pcm_drain but it does not work.
>>
>> How so?
>>
>> > The context is that this is an application that plays a particular WAV
>> > sound repeatedly, so I don't want to wait until the sound is played
>> > completely before it is played again.
>>
>> Then why do you drain at all?  Just write the new data into the buffer.
>>
>>
>> Regards,
>> Clemens
