From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2 2/9] ASoC: sun8i-codec: Don't hardcode
	BCLK / LRCK ratio
Date: Mon, 15 Oct 2018 08:14:25 -0700
Message-ID: <8376208.BHej6axeOA@anarsoul-thinkpad>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-3-anarsoul@gmail.com>
 <20181015070714.tglgw5dym6hraejz@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id EF5622677F5
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 17:14:27 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id 80-v6so9298959pgh.10
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 08:14:27 -0700 (PDT)
In-Reply-To: <20181015070714.tglgw5dym6hraejz@flea>
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

On Monday, October 15, 2018 12:07:14 AM PDT Maxime Ripard wrote:
> On Sat, Oct 13, 2018 at 09:53:22AM -0700, Vasily Khoruzhick wrote:
> > BCLK / LRCK ratio should be sample size * channels, but it was
> > hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
> > 
> > Calculate it basing on sample size and number of channels.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > 
> >  sound/soc/sunxi/sun8i-codec.c | 35 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
> > 
> > diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> > index fb37dd927e33..e681e194ad4c 100644
> > --- a/sound/soc/sunxi/sun8i-codec.c
> > +++ b/sound/soc/sunxi/sun8i-codec.c
> > @@ -52,7 +52,6 @@
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
> > @@ -257,8 +256,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai,
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
> >  
> >  static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
> > 
> > @@ -300,12 +299,33 @@ static u8 sun8i_codec_get_bclk_div(struct
> > sun8i_codec *scodec,> 
> >  	return best_val;
> >  
> >  }
> > 
> > +static const struct sun8i_codec_clk_div sun8i_codec_lrck_div[] = {
> > +	{ .div = 16,	.val = 0 },
> > +	{ .div = 32,	.val = 1 },
> > +	{ .div = 64,	.val = 2 },
> > +	{ .div = 128,	.val = 3 },
> > +	{ .div = 256,	.val = 4 },
> > +};
> 
> That's log2(div) - 4, right? There's no need to store the table if so.

OK, will fix in v3
 
> Maxime
