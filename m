From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 16:04:05 -0700
Message-ID: <20151029230404.GB44369@Asurada-CZ80>
References: <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de>
 <CAOMZO5DPL6H+Ahz_32Zn8AmDU8muGnVQG_owrGXtDQ1MQXcQ5g@mail.gmail.com>
 <CAG5mAdzxHTqYf0MjogUPYKze9WqKaKXpQvqSvvmSBZJORAQz2Q@mail.gmail.com>
 <CAOMZO5D0Xqpv2LDHfgWf87b8YwaZy424q_9wLTh8bYzoqJwq3g@mail.gmail.com>
 <CAG5mAdxAgyC4YNK80bu=JubPV1CfSiazf9QdWjgVFsgvzdGM8A@mail.gmail.com>
 <CAOMZO5CmALnrsCyTwd+v4NvLzZc1QuoSL8vDLi6z9s4mGTMV9g@mail.gmail.com>
 <CAOMZO5AOPSDH55mkJPbmn_VyNc173cFY6Uykg74-BznxWmwOvg@mail.gmail.com>
 <5630833B.10309@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id F20A3265843
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 00:04:09 +0100 (CET)
Received: by padhy1 with SMTP id hy1so47647311pad.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 16:04:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5630833B.10309@tekno-soft.it>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 09:11:39AM +0100, Roberto Fichera wrote:
 
> I'm also having the same issue but employing SSI in TDM master mode against a SLIC Si32178
> using its PCM mode. PCLK is at 2048KHz, FSYNC is 8KHz slot length is 32 bits (SSI wants
> this since when in master mode) but valid data set to be 8bits in the SSI register.

> My Current situation is that I've a custom fsl_ssi.c driver to control the SSI in TDM master mode
> both PCLK and FSYNC works perfectly fine, the SLIC has a register that I can check via SPI for
> such purpose, I can see the clocking status from its side. The main problem I've is exactly the same
> Caleb is having, after a certain amount of SDMA transfers, roughly 1000 or so, everything stops
> without any apparent reason.

I will start to help you to figure out your problem. But it seems that
you are having a different issue here with clock generation. I don't
get why you said *same issue*. For double confirm, the the "everything
stops" mentioned, does it mean that clock from SSI stops?
