From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Tue, 13 May 2014 23:21:03 +0600
Message-ID: <5372547F.5000805@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>	<CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>	<535FDEA8.7010206@gmail.com>	<CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>	<5364CE4D.7040506@gmail.com>	<CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>	<536E26A4.1060002@gmail.com>
 <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
 <53705396.3070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 9631626547F
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 19:24:36 +0200 (CEST)
Received: by mail-lb0-f177.google.com with SMTP id s7so524805lbd.8
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 10:24:36 -0700 (PDT)
In-Reply-To: <53705396.3070406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: sergemp@mail.ru, artur.stat@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

12.05.2014 10:52, I wrote:
> 12.05.2014 09:11, Raymond Yau wrote:
>> D: [alsa-sink] alsa-util.c: PCM state is RUNNING
>> I: [alsa-sink] alsa-sink.c: Starting playback.
>> I: [alsa-sink] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_START failed (-77)
>>
>> does SNDRV_PCM_IOCTL_START fail mean pcm state is no longer running ?
>
> Note that this comes from pcm_hw.c. As PulseAudio does not use the hw:
> device in this particular use case, I have to conclude that it comes
> through the a52 or ioplug code. I am not really familiar with this code.

This error code means -EBADFD. There is indeed some ifdefed-out code 
that prints the state on -EBADFD, so probably you are right. OTOH there 
is something strange in the code that may or may not be relevant. I have 
not tested my findings.

The a52 plugin sets the start threshold of the "slave" to its own start 
threshold. However, it doesn't write anything to the "slave" until it 
has enough data for one A52 frame. So, if the start threshold is too 
low, or if the pcm is started manually, it is quite possible that the 
"slave" is started without anything written into it. Result: immediate 
underrun. The dca plugin deals with this situation by inserting one DTS 
frame of silence before everything else, and writing as many "samples" 
to the slave as the application samples written into it.

Note that PulseAudio always starts the stream manually after writing the 
first full buffer.

And the log that you quoted also says:

I: [alsa-sink] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_START failed (-77)
D: [alsa-sink] alsa-util.c: Got POLLERR from ALSA
D: [alsa-sink] alsa-util.c: Got POLLOUT from ALSA
D: [alsa-sink] alsa-util.c: PCM state is RUNNING

The failure is for the hw plugin, however, the a52 plugin reports that 
it is running. Quite obvious desynchronization of state between the a52 
plugin and its "slave".

>>  >
>>  >>  > hw_ptr granularity is defined only by period_bytes_min (and
>>  >> additional constraints if any).
>>  >
>>  >
>>  > Well, this disagrees with my experiments. For S16_LE stereo,
>> snd_pcm_hw_params_get_period_size_min() says 32 samples for both PCH and
>> HDMI, while the measured granularity is different (8 and 16 samples).
>>
>> should you use period_bytes_min instead of period_size_min ?
>>
>> 128 bytes / (8 x 2)  = 8 samples for 8 channels
>>
>> for 6 channels playback , the period does not fit exactly the pcie
>> playload size 128 bytes
>
> Will retest later today.

Sorry, there is no userspace API for that. The only way to get the 
minimum period size is via snd_pcm_hw_params_get_period_size_min, which 
obtains the result in terms of frames.

>> does this mean the pulseaudio still keep the audio data until the
>> pulseaudio client close the stream ?
>
> Not ready to answer this yet.

Still don't know for sure.

-- 
Alexander E. Patrakov
