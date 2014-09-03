From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 1/4] ASoC: simple-card: add
 asoc_simple_card_fmt_master() to simplify the code.
Date: Wed, 3 Sep 2014 02:37:06 +0000
Message-ID: <707d1400a4514be9b599d4b7a6449ba7@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
 <1409649969-15759-2-git-send-email-Li.Xiubo@freescale.com>
 <5405A598.4050208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C3EE265586
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 04:37:08 +0200 (CEST)
In-Reply-To: <5405A598.4050208@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "moinejf@free.fr" <moinejf@free.fr>, "andrew@lunn.ch" <andrew@lunn.ch>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCHv2 1/4] ASoC: simple-card: add asoc_simple_card_fmt_master()
> to simplify the code.
> 
> On 09/02/2014 12:26 PM, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >   sound/soc/generic/simple-card.c | 61 ++++++++++++++++++++-----------------
> ----
> >   1 file changed, 29 insertions(+), 32 deletions(-)
> >
> > diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-
> card.c
> > index 986d2c7..cad2b30 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c
> > @@ -163,6 +163,26 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
> >   	return 0;
> >   }
> >
> > +static inline unsigned int
> > +asoc_simple_card_fmt_master(struct device_node *np,
> > +			    struct device_node *bitclkmaster,
> > +			    struct device_node *framemaster)
> > +{
> > +	switch (((np == bitclkmaster) << 4) | (np == framemaster)) {
> > +	case 0x11:
> > +		return SND_SOC_DAIFMT_CBS_CFS;
> > +	case 0x10:
> > +		return SND_SOC_DAIFMT_CBS_CFM;
> > +	case 0x01:
> > +		return SND_SOC_DAIFMT_CBM_CFS;
> > +	default:
> > +		return SND_SOC_DAIFMT_CBM_CFM;
> > +	}
> > +
> > +	/* Shouldn't be here */
> > +	return -EINVAL;
> > +}
> > +
> ....
> > +	fmt = asoc_simple_card_fmt_master(np, bitclkmaster, framemaster);
> > +	dai_props->cpu_dai.fmt = daifmt | fmt;
> ...
> > +		fmt = asoc_simple_card_fmt_master(np, bitclkmaster,
> > +						  framemaster);
> > +		dai_props->codec_dai.fmt = daifmt | fmt;
> 
> This won't work. The logic for cpu node needs to be negated for codec node.
> 

Yes, actually it should be.

As my previous patches about this:
----
Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
frame clock is as master/slave.

So these same DAI formats should be informed to CPU and CODE DAIs at
the same time. For the Codec driver will set the bit clock and frame
clock as the DAI formats said, but for the CPU driver, if the the
bit clock or frame clock is as Codec master, so it should be set CPU
DAI device as bit clock or frame clock as slave, and vice versa.

The old code will cause confusion, and we should be clear that the
letter 'C' here mean to Codec.
----

For the master format, no matter for CPU or CODEC, it always means Codec
is master or slave for bit/frame clock, not means the local DAI device's
bit/frame clock as master or slave.

So your CPU DAI device driver should negate this locally as the existed
Ones do.

Thanks,

BRs
Xiubo
