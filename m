From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 07:24:57 -0700
Message-ID: <CAG5mAdwrr6NZ_3bjfeGMDMJhFUubEXtdkbi2pJdmVV00VzQ7Fg@mail.gmail.com>
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
 <CAOMZO5AOPSDH55mkJPbmn_VyNc173cFY6Uykg74-BznxWmwOvg@mail.gmail.com>
 <5630833B.10309@tekno-soft.it>
 <CAG5mAdzt4T8ZZTMX2TZJCQOf-e+HS81V37ib+yCJOFqcwBAj7Q@mail.gmail.com>
 <5630D61E.3030101@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 67C8B2619FA
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 15:25:17 +0100 (CET)
Received: by wicfx6 with SMTP id fx6so200307841wic.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 07:25:17 -0700 (PDT)
In-Reply-To: <5630D61E.3030101@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 7:05 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 10/28/2015 02:59 PM, Caleb Crome wrote:
>> On Wed, Oct 28, 2015 at 1:11 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>> On 10/27/2015 07:57 PM, Fabio Estevam wrote:
>>>> [Adding Roberto in the thread as he is also trying to get SSI TDM support/
>>> Thanks Fabio,
>>>
>>> I'm also having the same issue but employing SSI in TDM master mode against a SLIC Si32178
>>> using its PCM mode. PCLK is at 2048KHz, FSYNC is 8KHz slot length is 32 bits (SSI wants
>>> this since when in master mode) but valid data set to be 8bits in the SSI register.
>>>
>>> My Current situation is that I've a custom fsl_ssi.c driver to control the SSI in TDM master mode
>>> both PCLK and FSYNC works perfectly fine, the SLIC has a register that I can check via SPI for
>>> such purpose, I can see the clocking status from its side. The main problem I've is exactly the same
>>> Caleb is having, after a certain amount of SDMA transfers, roughly 1000 or so, everything stops
>>> without any apparent reason.
>> My problem is that the channels randomly slip a slot and all words end
>> up in the wrong slot.  I suspect this is a DMA issue, but I really
>> haven't diagnosed it yet.  I don't get a full stop on the data.
>
> Ah! Ok!
>
>> FYI, I'm using a very recent 4.3 kernel from linus's repo, but 4.2
>> behaved the same.
>
> Can you please post the code you are using to setup the SSI, what PCLK and FSYNC rates?

My codec is generating the clocks and the MX6 is in slave mode.  PCLK
(I assume that's the bit clock or BCLK in my workld) is 12.288MHz, and
the FSYNC is 48kHz.  16 channels/frame, 16 bits/channel.

I hardly changed the SSI driver at all.  It's goofy now for sure
because I force it to 16 slots/frame no matter what, so beware.  Other
than that, I also set the STCCR for 16 channels and set channels_max
to 16.

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 37c5cd4..73778c2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -749,7 +749,10 @@ static int fsl_ssi_hw_params(struct
snd_pcm_substream *substream,
                 CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
                 channels == 1 ? 0 : i2smode);
     }
-
+    ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
+    regmap_update_bits(regs, CCSR_SSI_SCR,
+               CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
+               ssi_private->i2s_mode);
     /*
      * FIXME: The documentation says that SxCCR[WL] should not be
      * modified while the SSI is enabled.  The only time this can
@@ -863,6 +866,15 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
         return -EINVAL;
     }
     scr |= ssi_private->i2s_mode;
+    // Set to 16 slots/frame
+    regmap_update_bits(regs, CCSR_SSI_STCCR,
+               CCSR_SSI_SxCCR_DC_MASK,
+               CCSR_SSI_SxCCR_DC(16));
+
+    regmap_update_bits(regs, CCSR_SSI_SRCCR,
+               CCSR_SSI_SxCCR_DC_MASK,
+               CCSR_SSI_SxCCR_DC(16));
+

     /* DAI clock inversion */
     switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -1084,14 +1099,14 @@ static struct snd_soc_dai_driver
fsl_ssi_dai_template = {
     .playback = {
         .stream_name = "CPU-Playback",
         .channels_min = 1,
-        .channels_max = 2,
+        .channels_max = 16,
         .rates = FSLSSI_I2S_RATES,
         .formats = FSLSSI_I2S_FORMATS,
     },
     .capture = {
         .stream_name = "CPU-Capture",
         .channels_min = 1,
-        .channels_max = 2,
+        .channels_max = 16,
         .rates = FSLSSI_I2S_RATES,
         .formats = FSLSSI_I2S_FORMATS,
     },


There are other changes I've tried, including watermark changes (check
out the alsa-dev archives on this thread for what I did before).  This
morning I am about to try the watermark changes suggested by Nicolin
Chen.

> Did you have your own DMA handling?

Nope, I don't really know how to do that.  I'm relying on the built in
sdma driver (drivers/dma/imx-sdma.c) + fsl pcm
(sound/soc/fsl/imx-pcm-dma.c) and my modified fsl_ssi.c driver.

-Caleb


>
>>
>> -Caleb
>>
>>>> On Tue, Oct 27, 2015 at 2:45 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>>>> On Tue, Oct 27, 2015 at 2:42 PM, Caleb Crome <caleb@crome.org> wrote:
>>>>>> On Tue, Oct 27, 2015 at 9:10 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>>>>>> On Tue, Oct 27, 2015 at 2:02 PM, Caleb Crome <caleb@crome.org> wrote:
>>>>>>>
>>>>>>>>> Could you please try it without using the external SDMA firmware?
>>>>>>>> I do need *some* SDMA firmware, correct?  The firmware that I'm using
>>>>>>>> ends up in /lib/firmware/imx/sdma/sdma-imx6q.bin and is md5sum
>>>>>>>> 5d4584134cc4cba62e1be2f382cd6f3a.
>>>>>>> SSI can operate with the ROM SDMA firmware.
>>>>>>>
>>>>>>> I would like to know if this issue also happens if you don't pass the
>>>>>>> external firmware and use the internal ROM SDMA firmware instead.
>>>>>> Ah, good to know.  Do I just remove reference in the .dtsi file?
>>>>>> Remove the file from the filesystem?  I'll do both to be doubly sure
>>>>>> :-)
>>>>> Just remove it from the rootfs. Then you will see a message from the
>>>>> kernel saying that no external SDMA firmware could be found and that
>>>>> the internal one is going to be used.
>>>>>
>>>>>>> Also, could you try bumping the SSI and SDMA clock rates at the maximum?
>>>>>> Any idea how I do that?  I guess it's in the .dtsi file perhaps?  I'll
>>>>>> poke around.
>>>>> You can try to call clk_set_rate() with the maximum allowed frequency
>>>>> inside the ssi driver. I don't recall on top of my head what is this
>>>>> value though.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Fabio Estevam
>>>> _______________________________________________
>>>> Alsa-devel mailing list
>>>> Alsa-devel@alsa-project.org
>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
