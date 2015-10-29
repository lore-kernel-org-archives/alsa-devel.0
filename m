From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 17:34:16 +0100
Message-ID: <56324A88.4070400@tekno-soft.it>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
 <56323D3F.4080708@tekno-soft.it>
 <CAG5mAdywpA1af60wTwgPWMPGWmz7cYDHOycbSUeWHF3Znyr78w@mail.gmail.com>
 <5632431D.1020001@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id EF0472606A7
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 17:34:35 +0100 (CET)
In-Reply-To: <5632431D.1020001@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/29/2015 05:02 PM, Roberto Fichera wrote:
> On 10/29/2015 04:54 PM, Caleb Crome wrote:
>> On Thu, Oct 29, 2015 at 8:37 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>> On 10/29/2015 03:55 PM, Caleb Crome wrote:
>>>> On Thu, Oct 29, 2015 at 6:44 AM, Caleb Crome <caleb@crome.org> wrote:
>>>>> On Wed, Oct 28, 2015 at 9:53 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>>>>>> I am actually thinking about setting a watermark to a larger number.
>>>>>> I forgot how the SDMA script handles this number. But if this burst
>>>>>> size means the overall data count per transaction, it might indicate
>>>>>> that each FIFO only gets half of the burst size due to dual FIFOs.
>>>>>>
>>>>>> Therefore, if setting watermark to 8, each FIFO has 7 (15 - 8) space
>>>>>> left, the largest safe burst size could be 14 (7 * 2) actually.
>>>>> Oh, does this depend on the data size?  I'm using 16-bit data, so I
>>>>> guess the bursts are measured in 2 byte units?  Does this mean that
>>>>> the burst size should be dynamically adjusted depending on word size
>>>>> (I guess done in hw_params)?
>>>>>
>>>>>> Nicolin
>>>> Okay, so wm=8 and maxburst=14 definitely does not work at all,.  wm=8,
>>>> maxburst=8 works okay, but still not perfect.
>>>>
>>>> I just discovered some new information:
>>>>
>>>> With wm=8 and maxburst=8 (which is my best setting so far), I just
>>>> captured a problem at the very start of playing a file, and restarted
>>>> enough times to capture it starting wrong:
>>>>
>>>> Instead of the playback starting with
>>>>
>>>> (hex numbers:  my ramp file has first nibble as channel, second nibble as frame)
>>>>
>>>> frame 0:  00, 10, 20, 30, 40, 50, 60, 70, 80, 90, a0, b0, c0, d0, e0, f0
>>>> frame 1:  01, 11, 21, 31, 41, 51, 61, 71, 81, 91, a1, b1, c1, d1, e1, f1
>>>>
>>>> It started with:
>>>>
>>>> frame 0:  00, 00, 10, 20, 30, 40, 50, 60, 70, 80, 90, a0, b0, c0, d0, e0
>>>> frame 1:  f0, 01, 11, 21, 31, 41, 51, 61, 71, 81, 91, a1, b1, c1, d1, e1
>>>>
>>>> So, the transfer started wrong right out of the gate -- with an extra
>>>> sample inserted at the beginning. Again, my setup is:
>>>> 1) use scope to capture the TDM bus.  Trigger on first data change
>>>> 2) aplay myramp.wav
>>>> 3) If okay, ctrl-c and goto 2.
>>>> 4) The capture below shows everything off by 1 sample.
>>>>
>>>> The capture is here:
>>>> https://drive.google.com/open?id=0B-KUa9Yf1o7iOXFtWXk2ZXdoUXc
>>>>
>>>> This test definitely reveals that there is a startup issue.  Now for
>>>> the $64,000 question: what to do with this knowledge?  I'm quite
>>>> unfamiliar with how the DMA works at all.
>>> I'm my case for example, I'm using a iMX6SX SoC, I've changed fsl_ssi.c to start the SSI
>>> clock generated internally by setting both RDMAE and TDMAE just once I'm pretty sure
>>> that everything has been setup (DMA and callback). Note that I'm not using alsa because,
>>> my target is to integrate SSI in TDM network mode with my DAHDI driver for VoIP app.
>>>
>>> Back to the DMA question, in your case shouldn't be really a problem since all DMA
>>> stuff is handled by the linux audio framework.
>>>
>>> Regarding my SSI problem, I was able to keep the DMA working for few second once before
>>> it get stopped and never retriggered. Currently I've 2 DMA channel one for TX and another for RX
>>> I've changed my DTS and update my fsl_ssi to handle new clocks, I guess only the CLK_SPBA
>>> has improved my situation. I've also tried to enable both RIE and TIE to service the ISR, with
>>> and without SSI DMA support, but this end with a full system freeze.
>> I got this system freeze too when enabling RIE and TIE because the
>> interrupts TFE1IE, TFE0IE, TDE1IE, TDE0IE are *enabled* at reset.
>> (Check ref manual 61.9.5).   which I suspect was a livelock kind of
>> situation where the ISR is just called infinitely often.  After
>> disabling those, then the system worked okay.  Check out the previous
>> patch I sent on the issue yesterday or the day before.
> Ooohh!!! Forgot to check this!!! I'm now going to mask them!!!

Doesn't work for me! Still freeze the system!  SIER=0x01d005f4

>
>>> Another thing I'm looking is the sdma events (37 and 38) which are reported by the reference
>>> manual to
>>>
>>> 37 -> SSI1 Receive 0 DMA request
>>> 38 -> SSI1 Transmit 0 DMA request
>>>
>>> along that there are also
>>>
>>> 35 -> SSI1 Receive 1 DMA request
>>> 36 -> SSI1 Transmit 1 DMA request
>>>
>>> I don't know actually how the two events types will behaves from the SDMA point of view.
>> The 35 and 36 are for Dual fifo mode only, and no current system (with
>> fsl_ssi.c anyway) uses dual fifo mode.  How do I know?  Because the
>> it's definitely broken in the fsl_ssi.c.  I was just about to report
>> that bug.
> Ah! Thanks! The reference manual is really clear to explain it :-D !
>
>> hint:  fsl_ssi.c:  if (ssi_private->use_dma && !ret && dmas[3] ==
>> IMX_DMATYPE_SSI_DUAL) {
>> should read  if (ssi_private->use_dma && !ret && dmas[4] ==
>> IMX_DMATYPE_SSI_DUAL) {
> Yep! I know such piece of code.
>
>>> I'm also considering to make plain new audio driver to at least try to use something which
>>> is supposed to work fine with SSI.
>> Yeah, maybe that's the easiest way to go just to get operational.
>> Start with just the bare minimum ssi driver so you know all the
>> registers are locked into place the way you like.
>>
>> -caleb
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
