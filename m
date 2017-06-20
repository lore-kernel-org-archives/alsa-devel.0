From: Matin Momin <matinmomin@gmail.com>
Subject: Re: Alsa-lib: Dmix slowptr latency behaviour
Date: Tue, 20 Jun 2017 15:59:26 +0530
Message-ID: <CAPdSWWQieVJ5gtr64BCTdCK0XYYTqCLZ68PXWY6sT7V+nEePJA@mail.gmail.com>
References: <CAPdSWWRCeXakghaDxSXms9ui5uV3RNHGeiiPpvO1B8gfDBGrew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D3726680F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 12:29:28 +0200 (CEST)
Received: by mail-ua0-f171.google.com with SMTP id d45so36554377uai.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 03:29:28 -0700 (PDT)
In-Reply-To: <CAPdSWWRCeXakghaDxSXms9ui5uV3RNHGeiiPpvO1B8gfDBGrew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

> Matin Momin wrote:
>>> arecord -D"dsp" -r48000  -c2 -fs32_le | aplay -D"dmix1"

> To reduce the latency, reduce arecord's period size and/or aplay's
> buffer size.

 Actually, my aim is to understand if setting dmix slowptr to true
leads to increase in playback latency by buffer_time. Is it a known
issue or could it be because of the specific alsa device?

>> Now, in the same configuration if I disable slowptr in dmix1, the
>> delay comes down to 160 msecs, which corresponds exactly to buffer
>> time (85 msecs).

> Did you do multuple measurements?

Yes, and in each iteration I get reproducible measurements.

Regards,
Matin

PS: Please keep me in CC, I am not subscribed to the mailing list.



On Fri, Jun 16, 2017 at 11:03 AM, Matin Momin <matinmomin@gmail.com> wrote:
> Hi,
>
> On my embedded device, I am using a push mode simple alsa pipeline
> with following command
>
>> arecord -D"dsp" -r48000  -c2 -fs32_le | aplay -D"dmix1"
>
> where the asound conf looks this
> -------------------------------------------------------------------
> # This is the actual HW device
> pcm.dsp {
>         type hw
>         card 1
>         rate 48000
>         channels 2
>         format S32_LE
> }
> pcm.dmix1 {
>         type dmix
>         ipc_key 1024
>         ipc_key_add_uid false
>         ipc_perm 0666
>         slave.pcm "dsp"
>         slowptr true
> }
> -------------------------------------------------------------------
>
> I measured the pipeline delay by using Audacity on my PC, and
> measuring the difference in spike of audio recorded on the PC in a
> silent environment (1st spike will be from the actual sound and second
> will be from the output of my embedded device).
>
> Here I get a delay of around 245 msecs.
>
> Now, in the same configuration if I disable slowptr in dmix1, the
> delay comes down to 160 msecs, which corresponds exactly to buffer
> time (85 msecs).
>
> I want to know whether this is expected or is it an aberration?
>
> I have measured the userland time for the data to travel from
> alsa-lib/src/pcm/pcm_hw.c: snd_pcm_hw_readi() to
> alsa-lib/src/pcm/pcm_dmix.c:mix_areas() (By adding incremental numbers
> to each period recorded by arecord and seeing how much time they take
> to reach dmix). I cannot find any difference in absolute time
> difference with both slowptr true and false. Also, the critical hw_ptr
> and appl_ptr variables in pcm_hw and pcm_dmix also reflect same values
> for slowptr true and false.
>
> Is the above mentioned method to measure delay correct? If I don't see
> a delay here, where else should I look?
>
> The alsa-lib version is 1.1.0 and kernel is 3.8.13.
>
> Thanks in advance.
>
> Regards,
> Matin
