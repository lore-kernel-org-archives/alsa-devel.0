From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Wed, 28 Oct 2015 15:09:41 -0700
Message-ID: <CAG5mAdzQGD5h3AVX3KMOwqDKAtcm1+csipnFEwu_ow5KpKdayQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C648265011
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 23:10:01 +0100 (CET)
Received: by wijp11 with SMTP id p11so271413735wij.0
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 15:10:00 -0700 (PDT)
In-Reply-To: <CAG5mAdzt4T8ZZTMX2TZJCQOf-e+HS81V37ib+yCJOFqcwBAj7Q@mail.gmail.com>
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

On Wed, Oct 28, 2015 at 6:59 AM, Caleb Crome <caleb@crome.org> wrote:
> On Wed, Oct 28, 2015 at 1:11 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 10/27/2015 07:57 PM, Fabio Estevam wrote:
>>> [Adding Roberto in the thread as he is also trying to get SSI TDM support/
>>
>> Thanks Fabio,
>>
>> I'm also having the same issue but employing SSI in TDM master mode against a SLIC Si32178
>> using its PCM mode. PCLK is at 2048KHz, FSYNC is 8KHz slot length is 32 bits (SSI wants
>> this since when in master mode) but valid data set to be 8bits in the SSI register.
>>
>> My Current situation is that I've a custom fsl_ssi.c driver to control the SSI in TDM master mode
>> both PCLK and FSYNC works perfectly fine, the SLIC has a register that I can check via SPI for
>> such purpose, I can see the clocking status from its side. The main problem I've is exactly the same
>> Caleb is having, after a certain amount of SDMA transfers, roughly 1000 or so, everything stops
>> without any apparent reason.
>
> My problem is that the channels randomly slip a slot and all words end
> up in the wrong slot.  I suspect this is a DMA issue, but I really
> haven't diagnosed it yet.  I don't get a full stop on the data.
>
> FYI, I'm using a very recent 4.3 kernel from linus's repo, but 4.2
> behaved the same.
>

Now I'm recalling when I tried the patches on 4.1, everything
definitely froze.  What kernel are you using?.  I'm basically using
the 4.3-rc7

-Caleb
