From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH 0/5] ASoC: fsl_ssi: Fixing various channel
 slips and bad samples insertions
Date: Thu, 14 Jan 2016 08:42:42 -0800
Message-ID: <CAG5mAdyB5_iBhB4tLCTiqq8v4L4sOSqYcdUJ838tR9b-KgRROA@mail.gmail.com>
References: <1448546842-4584-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAG5mAdw_+BiDppzpKF0ZBG1NXreGob6+jZd6SLjS1+zdmEE4ZA@mail.gmail.com>
 <5690E8CF.8070700@invoxia.com>
 <CAG5mAdw3HKwyMyX9O2NM=GRDy9nEcOH6FrB1BSYMFhM-kL-BZw@mail.gmail.com>
 <56966324.8090409@invoxia.com>
 <CAG5mAdytoCqchFAh2J1t-oXZbwzxVs2U8amP=EfX1AEZSCtfQg@mail.gmail.com>
 <CAG5mAdzgAHPcqp5o12m+Ba5d69qx3ocWaa5s=ns5A60BWfcm7g@mail.gmail.com>
 <56975F0C.3080906@invoxia.com>
 <CAG5mAdwaY=GqQj10-13ZZNqE_qvZB=LjboXLqpNTesGVV3k4Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF131260524
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 17:43:02 +0100 (CET)
Received: by mail-io0-f193.google.com with SMTP id q21so33443691iod.3
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 08:43:02 -0800 (PST)
In-Reply-To: <CAG5mAdwaY=GqQj10-13ZZNqE_qvZB=LjboXLqpNTesGVV3k4Pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 6:25 AM, Caleb Crome <caleb@crome.org> wrote:
> On Thu, Jan 14, 2016 at 12:40 AM, arnaud.mouiche@invoxia.com
> <arnaud.mouiche@invoxia.com> wrote:
>>
>> [..]
>>>
>>>
>>> SUCCESS!  So far...
>>
>> Great :)
>>
>> I'm preparing a v3 of my patches including the SOR register + rebased on top
>> of v4.4.
>> I will let you propose the water mark / maxburst patch.
>> But it looks obvious to me that triggering the DMA when only 2 words are
>> left in the FIFO can lead to DMA xruns at such data rate.
>>
>> The downside is an increased number of DMA requests.
>> So I don't know if you should propose a configuration through the device
>> tree, or a static configuration as done in your patch.
>>
>
> Sounds to me like the device tree is the right place for it. I'll submit an RFC.
>
> For some reason... looks like it can't yet quite keep up at 48kHz.  it
> was working reliably for a while, but now I can only get it reliable
> at 32kHz.  It seems it's the TX that's broken at 48k.
>
> I'll dig in to see where the failure is.
>
> -C

Okay, setting maxburst and  watermark to 4 instead of 8 seems to solve
the problem at 48kHz.

-Caleb
