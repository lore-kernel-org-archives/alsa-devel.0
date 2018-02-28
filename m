From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 6/7] ASoC: max9867: Fix BSEL value in
	master mode.
Date: Wed, 28 Feb 2018 11:00:54 +0100
Message-ID: <20180228100054.GJ1479@piout.net>
References: <20180130110604.GA18123@lenoch> <20180130111033.GG18123@lenoch>
 <20180227172309.GG1479@piout.net> <20180227190338.GB1961@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9452671EC
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 11:01:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180227190338.GB1961@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 27/02/2018 at 20:03:38 +0100, Ladislav Michl wrote:
> On Tue, Feb 27, 2018 at 06:23:09PM +0100, Alexandre Belloni wrote:
> > This also needs a proper commit message.
> 
> Meanwhile more patches for this driver accumulated, so I'll send simple ones
> first and those I'm uncertain of later.
> 
> Now few questions:
> - should hw_params emit any error message when asked to set for example
>   unsupported sample rate? Many drivers do so, but it seems strange.

I would thin that is correct because then the eror goes up to userspace
and it knows it has to resample.

> - table used in this driver is overkill, frequencies can be calculated
>   directly (patch ready), but that brings question about
>   SNDRV_PCM_RATE_CONTINUOUS: what does it exactly mean? What if codec is
>   able to set "any" rate, but there are rounding errors?
> 

That is a good question I can't answer.

> > On 30/01/2018 at 12:10:33 +0100, Ladislav Michl wrote:
> > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > > ---
> > >  Note: It should be reconsidered where BSEL should be set.
> > > 
> > >  sound/soc/codecs/max9867.c | 43 +++----------------------------------------
> > >  1 file changed, 3 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
> > > index 026b7cf94910..6272cf5df4a9 100644
> > > --- a/sound/soc/codecs/max9867.c
> > > +++ b/sound/soc/codecs/max9867.c
> > > @@ -148,46 +148,6 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
> > >  			MAX9867_RAPID_LOCK, MAX9867_RAPID_LOCK);
> > >  		regmap_update_bits(max9867->regmap, MAX9867_AUDIOCLKHIGH,
> > >  			MAX9867_PLL, MAX9867_PLL);
> > > -	} else {
> > > -		unsigned long int bclk_rate, pclk_bclk_ratio;
> > > -		int bclk_value;
> > > -
> > > -		bclk_rate = params_rate(params) * 2 * params_width(params);
> > > -		pclk_bclk_ratio = max9867->pclk/bclk_rate;
> > > -		switch (params_width(params)) {
> > > -		case 8:
> > > -		case 16:
> > > -			switch (pclk_bclk_ratio) {
> > > -			case 2:
> > > -				bclk_value = MAX9867_IFC1B_PCLK_2;
> > > -				break;
> > > -			case 4:
> > > -				bclk_value = MAX9867_IFC1B_PCLK_4;
> > > -				break;
> > > -			case 8:
> > > -				bclk_value = MAX9867_IFC1B_PCLK_8;
> > > -				break;
> > > -			case 16:
> > > -				bclk_value = MAX9867_IFC1B_PCLK_16;
> > > -				break;
> > > -			default:
> > > -				dev_err(codec->dev,
> > > -					"unsupported sampling rate\n");
> > > -				return -EINVAL;
> > > -			}
> > > -			break;
> > > -		case 24:
> > > -			bclk_value = MAX9867_IFC1B_24BIT;
> > > -			break;
> > > -		case 32:
> > > -			bclk_value = MAX9867_IFC1B_32BIT;
> > > -			break;
> > > -		default:
> > > -			dev_err(codec->dev, "unsupported sampling rate\n");
> > > -			return -EINVAL;
> > > -		}
> > > -		regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
> > > -			MAX9867_IFC1B_BCLK_MASK, bclk_value);
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -244,6 +204,9 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> > >  	value &= ~MAX9867_FREQ_MASK;
> > >  	regmap_update_bits(max9867->regmap, MAX9867_SYSCLK,
> > >  			MAX9867_PSCLK_MASK, value);
> > > +	regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
> > > +			MAX9867_IFC1B_BCLK_MASK, 0x010);
> > 
> > This magic value has to be defined somewhere.
> > 
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > -- 
> > > 2.15.1
> > > 
> > 
> > -- 
> > Alexandre Belloni, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
