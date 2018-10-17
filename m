From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v4 2/9] ASoC: sun8i-codec: Don't hardcode
	BCLK / LRCK ratio
Date: Wed, 17 Oct 2018 00:17:41 -0700
Message-ID: <2291476.RZZTV6ctdW@anarsoul-thinkpad>
References: <20181016030239.15449-1-anarsoul@gmail.com>
 <20181016030239.15449-3-anarsoul@gmail.com>
 <20181017071248.65g7m6ih2swazjh4@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C38267545
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 09:17:43 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so12087833pgs.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 00:17:43 -0700 (PDT)
In-Reply-To: <20181017071248.65g7m6ih2swazjh4@flea>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday, October 17, 2018 12:12:48 AM PDT Maxime Ripard wrote:
> Hi!
> 
> On Mon, Oct 15, 2018 at 08:02:32PM -0700, Vasily Khoruzhick wrote:
> > BCLK / LRCK ratio should be sample size * channels, but it was
> > hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
> > 
> > Calculate it basing on sample size and number of channels.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > 
> >  sound/soc/sunxi/sun8i-codec.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> > index fb37dd927e33..2467fab94a19 100644
> > --- a/sound/soc/sunxi/sun8i-codec.c
> > +++ b/sound/soc/sunxi/sun8i-codec.c
> > @@ -24,6 +24,7 @@
> > 
> >  #include <linux/io.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > 
> > +#include <linux/log2.h>
> > 
> >  #include <sound/pcm_params.h>
> >  #include <sound/soc.h>
> > 
> > @@ -52,7 +53,6 @@
> > 
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
> > 
> > -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
> > 
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
> >  #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
> > 
> > @@ -257,8 +257,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai,
> > unsigned int fmt)> 
> >  }
> >  
> >  struct sun8i_codec_clk_div {
> > 
> > -	u8	div;
> > -	u8	val;
> > +	unsigned int	div;
> > +	u8		val;
> > 
> >  };
> 
> Do we still need that type change? It looks like you're not using it
> anywhere in that patch.

We don't need it, I'll drop it for v5.

> 
> Thanks!
> Maxime
