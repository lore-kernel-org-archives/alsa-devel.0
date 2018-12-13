From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] ASoC: simple-card: Dereference pointer for memcpy sizeof
 in asoc_simple_card_probe
Date: Wed, 12 Dec 2018 22:09:41 -0700
Message-ID: <20181213050941.GA32000@flashbox>
References: <20181213043548.29747-1-natechancellor@gmail.com>
 <87y38u10rx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y38u10rx.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 13, 2018 at 02:07:42PM +0900, Kuninori Morimoto wrote:
> 
> Hi Nathan
> 
> > sound/soc/generic/simple-card.c:462:6: warning: argument to 'sizeof' in
> > 'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
> > source; expected 'struct asoc_simple_dai' or an explicit length
> > [-Wsizeof-pointer-memaccess]
> >                                         sizeof(priv->dai_props->cpu_dai));
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > sound/soc/generic/simple-card.c:464:6: warning: argument to 'sizeof' in
> > 'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
> > source; expected 'struct asoc_simple_dai' or an explicit length
> > [-Wsizeof-pointer-memaccess]
> >                                         sizeof(priv->dai_props->codec_dai));
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2 warnings generated.
> > 
> > Commit 4fb7f4df49d3 ("ASoC: simple-card: use cpu/codec pointer on
> > simple_dai_props") updated {cpu,codec}_dai to be pointers in struct
> > simple_dai_props but didn't update these locations to dereference the
> > pointers to get the proper size of their contents.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  sound/soc/generic/simple-card.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> > index 766123485d7c..d4738d3eb2f1 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c
> > @@ -459,9 +459,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
> >  		dai_link->dai_fmt	= cinfo->daifmt;
> >  		dai_link->init		= asoc_simple_card_dai_init;
> >  		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
> > -					sizeof(priv->dai_props->cpu_dai));
> > +					sizeof(*priv->dai_props->cpu_dai));
> >  		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
> > -					sizeof(priv->dai_props->codec_dai));
> > +					sizeof(*priv->dai_props->codec_dai));
> >  	}
> 
> Ahh.. yes, simple-card is supporting non DT case, too.
> Thank you for your patch.
> But, I think "&priv->dai_props->codec_dai" need to fix, too.
> And it needs to point cpu_dai/codec_dai.
> Thank you for pointing it. I will fixup and post with your name.
> 
> Best regards
> ---
> Kuninori Morimoto

Sure, whatever you think is best, thank you for the quick response!

Nathan
