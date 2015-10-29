From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 06:44:12 -0700
Message-ID: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 972202605CC
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 14:44:32 +0100 (CET)
Received: by wmff134 with SMTP id f134so24639187wmf.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 06:44:32 -0700 (PDT)
In-Reply-To: <20151029045350.GA3374@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 9:53 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 03:06:40PM -0700, Caleb Crome wrote:
>
>> > 2) Set the watermarks for both TX and RX to 8 while using burst sizes
>> >    of 6. It'd be nicer to provisionally set these numbers using hard
>> >    code than your current change depending on fifo_depth as it might
>> >    be an odd value.
>
>> Ah, this is fascinating you say this.  fifo_depth is definitely odd,
>> it's 15 as set in imx6qdl.dtsi:
>
>> fsl,fifo-depth = <15>;
>> But the DMA maxburst is made even later in the code...
>
> And odd number for burst size may course a similar problem like
> channel swapping in two-channel cases because the number of data
> FIFO is 2 -- an even number. But it seems not to be related to
> your problem here.
>
>> Setting the watermark to 8 and maxburst to 8 dramatically reduces the
>> channel slip rate, in fact, i didn't see a slip for more than 30
>> minutes of playing.  That's a new record for sure.  But, eventually,
>> there was an underrun, and the channels slipped.
>>
>> Setting watermark to 8 and maxburst to 6 still had some slips,
>> seemingly more than 8 & 8.
>>
>> I feel like a monkey randomly typing at my keyboard though.  I don't
>> know why maxburst=8 worked better.  I get the
>> feeling that I was just lucky.
>
> That's actually another possible root cause -- performance issue.
> burst=8 will have less bus transaction number than the case when
> burst=6. As you have quite a lot channels comparing to normal 2
> channels, you need to feed the FIFO more frequently. If SDMA does
> not feed the data before the input FIFO gets underrun, a channel
> swapping might happen: in your case, channel slip.
>
>> There does seem to be a correlation between user space reported
>> underruns and this channel slip, although they definitely are not 1:1
>
> Reported by user space? Are you saying that's an ALSA underrun in
> the user space, not a hardware underrun reported by the IRQ in the
> driver? They are quite different. ALSA underrun comes from the DMA
> buffer gets underrun while the other one results from FIFO feeding
> efficiency. For ALSA underrun, enlarging the playback period size
> and period number will ease the problem:
>
> period number = buffer size / period size;
>
> An ALSA underrun may not be companied by a hardware underrun but
> they may co-exist.

Sometimes they happen at the same time.  So, I run aplay, and all is
fine.  Then the user space app will underrun, and then I look at the
scope, and the channels have slipped.  So somehow the start/restart
after the underrun is not always perfect I guess.

Is there any mechanism for the DMA fifo underruns to be reported back
to user space?  There certainly should be, because the consequences
are catastrophic, yet the user space app goes on as if everything is
just great.  Much, much worse than the underrun that is reported (i.e.
a skip in audio is bad but sometimes tolerable.  A channel slip is
permanent and absolutely intolerable).

>
>> ratio:  underruns happen without slips and slips happen without
>> underruns.  The latter is very disturbing because user space has no
>> idea something is wrong.
>
>> @@ -1260,8 +1260,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
>>          * We have burstsize be "fifo_depth - 2" to match the SSI
>>          * watermark setting in fsl_ssi_startup().
>>          */
>> -       ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
>> -       ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
>> +       ssi_private->dma_params_tx.maxburst = 8;
>> +       ssi_private->dma_params_rx.maxburst = 8;
>
> I am actually thinking about setting a watermark to a larger number.
> I forgot how the SDMA script handles this number. But if this burst
> size means the overall data count per transaction, it might indicate
> that each FIFO only gets half of the burst size due to dual FIFOs.
>
> Therefore, if setting watermark to 8, each FIFO has 7 (15 - 8) space
> left, the largest safe burst size could be 14 (7 * 2) actually.

Oh, does this depend on the data size?  I'm using 16-bit data, so I
guess the bursts are measured in 2 byte units?  Does this mean that
the burst size should be dynamically adjusted depending on word size
(I guess done in hw_params)?

>
> Yes. That's kind of fine tunning the parameters. And for your case,
> you may try a larger number as the SSI is simultaneously consuming
> a large amount of data even though it sounds risky. But it's worth
> trying since you are using SSI which only has tight FIFOs not like
> ESAI has 128 depth.
>
> Nicolin
