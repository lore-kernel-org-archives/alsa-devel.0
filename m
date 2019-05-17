From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH][RFC] ASoC: soc-dpm: fixup DAI active
 unbalance
Date: Fri, 17 May 2019 09:08:18 +0530
Message-ID: <20190517033818.GE2707@vkoul-mobl>
References: <87mujl3n4t.wl-kuninori.morimoto.gx@renesas.com>
 <34505df5-e479-679c-7c67-ecb45d61414b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CDBCF80759
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2019 05:38:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <34505df5-e479-679c-7c67-ecb45d61414b@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 16-05-19, 22:21, Pierre-Louis Bossart wrote:
> On 5/16/19 8:21 PM, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > snd_soc_dai_link_event() is updating snd_soc_dai :: active,
> > but it is unbalance.
> > It counts up if it has startup callback.
> > 
> > 	case SND_SOC_DAPM_PRE_PMU:
> > 		...
> > 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> > 			...
> > 			if (source->driver->ops->startup) {
> > 				...
> > =>				source->active++;
> > 			}
> > 			...
> > 		}
> > 		...
> > 
> > But, always counts down
> > 
> > 	case SND_SOC_DAPM_PRE_PMD:
> > 		...
> > 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> > 			...
> > =>			source->active--;
> > 			...
> > 		}
> > 
> > This patch always counts up when SND_SOC_DAPM_PRE_PMD.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > Mark, Liam
> > 
> > I think this is bug, but I can't confirm it,
> > because my driver need to have .startup.
> > Thus, I added [RFC] on this patch.
> > I'm happy if someone can confirm it.

Right, seems a bug to me!

> This looks like a bug since the initial Intel contribution in 2015.
> 9b8ef9f6b3fc ('ASoC: dapm: Add startup & shutdown for dai_links') already
> has this imbalance.

Well yes this would be seen if someone has a dai_link without the
startup and shutdown calls (which is not mandatory). Agreed that it was
a miss to not put counters in right places.
> 
> I don't have a clue why this is not symmetric or not done as suggested by
> Morimoto-san. Vinod, any idea?

Since while testing we always had the calls and never run in imbalance,
but we should have done better!

I think you should be able to test it on Intel platforms with dai_links
and removing the optional calls.

The change looks fine to be

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> >   sound/soc/soc-dapm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > index c864502..147ad9d 100644
> > --- a/sound/soc/soc-dapm.c
> > +++ b/sound/soc/soc-dapm.c
> > @@ -3828,8 +3828,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
> >   						ret);
> >   					goto out;
> >   				}
> > -				source->active++;
> >   			}
> > +			source->active++;
> >   			ret = soc_dai_hw_params(&substream, params, source);
> >   			if (ret < 0)
> >   				goto out;
> > @@ -3850,8 +3850,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
> >   						ret);
> >   					goto out;
> >   				}
> > -				sink->active++;
> >   			}
> > +			sink->active++;
> >   			ret = soc_dai_hw_params(&substream, params, sink);
> >   			if (ret < 0)
> >   				goto out;
> > 

-- 
~Vinod
