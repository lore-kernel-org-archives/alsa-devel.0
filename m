From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Wed, 17 Jun 2015 11:04:45 +0800
Message-ID: <CAN8cciZW0aMZRJntrOTD11Qs8Uz858JLr_fLyvt==Q6SrzK3SA@mail.gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <CACuU-+gmSj7rw8h6scpokXgMrL8QFr8a+xt2hH-4yLy=3POc5A@mail.gmail.com>
 <557AE213.2010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B259F265A2A
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 05:04:46 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so8201766oiy.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 20:04:45 -0700 (PDT)
In-Reply-To: <557AE213.2010005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>> Hi folks,
>>> I'd like to bring this one up again, since we are currently in the
>>> sub-optimal position of forcing ~100 ms latency on USB devices. The
>>> original thread is here --
>>>
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069666.html
>>
>>
>> While we sort this out, though, is there an upper bound on the USB
>> transfer size (that we could then use a rewind safety margin)? We
>> might be able to use this as a workaround till this can be fixed
>> properly.
>
>
> Hello Arun,
>
> thanks for bringing up the issue again. However, I think that the "~100
ms latency on batch cards" problem can and should also be solved from the
other end, independently from the USB special case. Namely, I think that
the default buffer and period sizes that PulseAudio selects are way too
conservative. The power-saving argument was used in the past as a
justification, and I am calling for a reevaluation. Here is why.
>
> 1. Android's AudioFlinger uses 2 periods, 5 ms each. It is a mobile OS,
and the developers think it is good enough.
>
> 2. I have measured the battery life time of my SandyBridge-based laptop
and found that, with pure ALSA on the hw:0 device, a similar low-latency
setup loses less than 5% of the battery life (935 seconds were lost out of
25742). With PulseAudio, the difference is worse, but let's treat this as a
missed optimization in PulseAudio.

http://www.intel.com/content/www/us/en/chipsets/high-definition-audio-energy-efficient-audio-buffering.html

Do your hda controller support EEaudio Mechanism ?
