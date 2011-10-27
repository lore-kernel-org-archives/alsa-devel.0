From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Clear BIT_CLK_MASTER and
 WORD_CLK_MASTER bits for for slave mode
Date: Thu, 27 Oct 2011 13:52:21 +0200
Message-ID: <1319716341.4629.10.camel@puukko.homenet-68>
References: <1319704549.2673.2.camel@phoenix>
	 <1319704722.2673.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319704722.2673.5.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Vladimir Barinov <vbarinov@embeddedalley.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-10-27 at 16:38 +0800, Axel Lin wrote:
> According to the datasheet:
> 
> Page0 / Register8: Audio Serial Data interface Control Register A
> BIT 7: Bit Clock Directional Control
>         0: Bit clock is an input (slave mode)
>         1: Bit clock is an output (master mode)
> 
> BIT 6: Word Clock Directional Control
>         0: Word clock is an input (slave mode)
>         1: Word clock is an output (master mode)
> 
> Current code sets BIT_CLK_MASTER and WORD_CLK_MASTER bits for master mode,
> but does not clear these bits for slave mode.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
This is not entirely true - there is this fussy '& 0x3f' operation that
does clear those bits a few code lines above your change. Now we can rid
of it thanks to your patch, hopefully for iface_breg too (in case if you
are going to send an another patch as this is applied) :-)

-- 
Jarkko
