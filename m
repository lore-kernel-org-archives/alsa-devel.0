From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 9 Mar 2009 17:01:37 +0100
Message-ID: <74d0deb30903090901ha30bc21q9999dc44c3606c8@mail.gmail.com>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<1236610986.6781.93.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f177.google.com (mail-gx0-f177.google.com
	[209.85.217.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A100103822
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 17:01:38 +0100 (CET)
Received: by gxk25 with SMTP id 25so2567444gxk.22
	for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2009 09:01:37 -0700 (PDT)
In-Reply-To: <1236610986.6781.93.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 9, 2009 at 4:03 PM, Liam Girdwood <lrg@kernel.org> wrote:
> On Mon, 2009-03-09 at 15:47 +0100, pHilipp Zabel wrote:
>> Ok,
>>
>> I'm not sure how to handle this correctly.
>>
>> Magician needs stereo S16_LE input data from alsa, DAIFMT_DSP_A on the
>> wire with a frame size of 16 bit (one frame for each channel) and thus
>> 2-byte DMA transfers to the FIFO (currently called 'mono' DMA params).
>> Zylonite's current code uses 32 bit frame size and 4-byte DMA
>> transfers to emulate I2S (S16_LE,stereo). Network mode seems to work,
>> so it could be changed to use two 16 bit slots instead with 2-byte DMA
>> transfers (which would make Magician happy). But...
>> Daniel's board needs very strange settings because network mode
>> doesn't work, so I guess he can't use 2-byte DMA transfers. Is that
>> correct?
>>
>> If we can't find a way to have all machines use the mono DMA params,
>> there has to be some kind of interface to set the width of the data in
>> the FIFO independently from the Alsa format. How should that interface
>> look like?
>
> Btw, what pxa processor variants are you and Daniel using ?
>
> Iirc, PXA3x SSP is quite different in terms of "usability" compared to
> to PXA2x SSP. It might be worth diverging the SSP code a little here if
> your CPUs are different.

PXA272 in my case, but I share Mark's hope of keeping it unified.

regards
Philipp
