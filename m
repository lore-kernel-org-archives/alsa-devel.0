From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 09:11:39 +0100
Message-ID: <5630833B.10309@tekno-soft.it>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 906332605EA
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 09:11:59 +0100 (CET)
In-Reply-To: <CAOMZO5AOPSDH55mkJPbmn_VyNc173cFY6Uykg74-BznxWmwOvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/27/2015 07:57 PM, Fabio Estevam wrote:
> [Adding Roberto in the thread as he is also trying to get SSI TDM support/

Thanks Fabio,

I'm also having the same issue but employing SSI in TDM master mode against a SLIC Si32178
using its PCM mode. PCLK is at 2048KHz, FSYNC is 8KHz slot length is 32 bits (SSI wants
this since when in master mode) but valid data set to be 8bits in the SSI register.

My Current situation is that I've a custom fsl_ssi.c driver to control the SSI in TDM master mode
both PCLK and FSYNC works perfectly fine, the SLIC has a register that I can check via SPI for
such purpose, I can see the clocking status from its side. The main problem I've is exactly the same
Caleb is having, after a certain amount of SDMA transfers, roughly 1000 or so, everything stops
without any apparent reason.


>
> On Tue, Oct 27, 2015 at 2:45 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Tue, Oct 27, 2015 at 2:42 PM, Caleb Crome <caleb@crome.org> wrote:
>>> On Tue, Oct 27, 2015 at 9:10 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>>> On Tue, Oct 27, 2015 at 2:02 PM, Caleb Crome <caleb@crome.org> wrote:
>>>>
>>>>>> Could you please try it without using the external SDMA firmware?
>>>>> I do need *some* SDMA firmware, correct?  The firmware that I'm using
>>>>> ends up in /lib/firmware/imx/sdma/sdma-imx6q.bin and is md5sum
>>>>> 5d4584134cc4cba62e1be2f382cd6f3a.
>>>> SSI can operate with the ROM SDMA firmware.
>>>>
>>>> I would like to know if this issue also happens if you don't pass the
>>>> external firmware and use the internal ROM SDMA firmware instead.
>>> Ah, good to know.  Do I just remove reference in the .dtsi file?
>>> Remove the file from the filesystem?  I'll do both to be doubly sure
>>> :-)
>> Just remove it from the rootfs. Then you will see a message from the
>> kernel saying that no external SDMA firmware could be found and that
>> the internal one is going to be used.
>>
>>>> Also, could you try bumping the SSI and SDMA clock rates at the maximum?
>>> Any idea how I do that?  I guess it's in the .dtsi file perhaps?  I'll
>>> poke around.
>> You can try to call clk_set_rate() with the maximum allowed frequency
>> inside the ssi driver. I don't recall on top of my head what is this
>> value though.
>>
>> Regards,
>>
>> Fabio Estevam
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
