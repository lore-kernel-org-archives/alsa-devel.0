From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 06:53:57 -0700
Message-ID: <CAG5mAdy-PhQvMdKNL_C8QMnGEd8U1h0aj66cgoJQckdWyBJ9Ew@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <CAOMZO5DPL6H+Ahz_32Zn8AmDU8muGnVQG_owrGXtDQ1MQXcQ5g@mail.gmail.com>
 <CAG5mAdzxHTqYf0MjogUPYKze9WqKaKXpQvqSvvmSBZJORAQz2Q@mail.gmail.com>
 <CAOMZO5D0Xqpv2LDHfgWf87b8YwaZy424q_9wLTh8bYzoqJwq3g@mail.gmail.com>
 <CAG5mAdxAgyC4YNK80bu=JubPV1CfSiazf9QdWjgVFsgvzdGM8A@mail.gmail.com>
 <CAOMZO5CmALnrsCyTwd+v4NvLzZc1QuoSL8vDLi6z9s4mGTMV9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F7AB2619FA
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 14:54:17 +0100 (CET)
Received: by wijp11 with SMTP id p11so256289425wij.0
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 06:54:17 -0700 (PDT)
In-Reply-To: <CAOMZO5CmALnrsCyTwd+v4NvLzZc1QuoSL8vDLi6z9s4mGTMV9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 27, 2015 at 9:45 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Oct 27, 2015 at 2:42 PM, Caleb Crome <caleb@crome.org> wrote:
>> On Tue, Oct 27, 2015 at 9:10 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>> On Tue, Oct 27, 2015 at 2:02 PM, Caleb Crome <caleb@crome.org> wrote:
>>>
>>>>> Could you please try it without using the external SDMA firmware?
>>>>
>>>> I do need *some* SDMA firmware, correct?  The firmware that I'm using
>>>> ends up in /lib/firmware/imx/sdma/sdma-imx6q.bin and is md5sum
>>>> 5d4584134cc4cba62e1be2f382cd6f3a.
>>>
>>> SSI can operate with the ROM SDMA firmware.
>>>
>>> I would like to know if this issue also happens if you don't pass the
>>> external firmware and use the internal ROM SDMA firmware instead.
>>
>> Ah, good to know.  Do I just remove reference in the .dtsi file?
>> Remove the file from the filesystem?  I'll do both to be doubly sure
>> :-)
>
> Just remove it from the rootfs. Then you will see a message from the
> kernel saying that no external SDMA firmware could be found and that
> the internal one is going to be used.

I gave it a try.  No noticeable  change in behavior.

>
>>> Also, could you try bumping the SSI and SDMA clock rates at the maximum?
>>
>> Any idea how I do that?  I guess it's in the .dtsi file perhaps?  I'll
>> poke around.
>
> You can try to call clk_set_rate() with the maximum allowed frequency
> inside the ssi driver. I don't recall on top of my head what is this
> value though.

I don't know what to use as a parameter to clk_set_rate().  The 2
clocks that I see in the SDMA configuration are clk_ipg, and clk_ahb.
The IMX6SDLRM syas, "configurable clock options for the SDMA core and
the ARM platform DMA units.  1:2 ratio with maximum of SDMA core
running at ARM platform peripheral bus speed and DMS running at max
DMA frequency.  1:1 ratio when both SDMA core and ARM platform DMA
clocks are set to the ARM platform peripheral bus speed"

But, I have a hard time reconsiling that statement with the code in
sdma_init, which references only the ipg and ahb clocks.  I put in a
printk, and found the clk_ipg and clk_ahb to be 132 MHz.

The IMX6SDLRM.pdf, page 4717 says: "...but the SDMA core is physically
limited to a maximum 104 MHz frequency...".

So, I just don't know what clock to set to 104 MHz, or if the 104MHz
really is the right limit.  Any ideas?


This made me think that possibly the problem is with cpufreq
dynamically scaling the core frequency. So I tried:
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

To ensure that the clocks don't dynamically switch on me, but I still
get channel slips.  Unfortunately,  it's hard to get statistical
measures with my eyeballs (watching a scope with TDM decode).  It
might be a little better, but still fails.

Thanks,
  -Caleb


>
> Regards,
>
> Fabio Estevam
