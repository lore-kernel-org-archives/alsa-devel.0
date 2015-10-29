From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/2] ASoC: wm9713: convert to regmap
Date: Thu, 29 Oct 2015 17:06:12 +0000
Message-ID: <20151029170612.GL10520@ck-lbox>
References: <1445983102-15490-1-git-send-email-robert.jarzmik@free.fr>
 <20151028124351.GK10520@ck-lbox> <87io5qka06.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8F8261643
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 18:22:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87io5qka06.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2015 at 09:34:33PM +0100, Robert Jarzmik wrote:
> Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
> >>  	/* Disable everything except touchpanel - that will be handled
> >>  	 * by the touch driver and left disabled if touch is not in
> >>  	 * use. */
> >> @@ -1173,14 +1217,14 @@ static int wm9713_soc_suspend(struct snd_soc_codec *codec)
> >
> > I would have expected to see the cache being put into cache only
> > mode at some point during suspend, am I missing something here as
> > well?
> Why ? Once suspended, why would you expect an access to be done to the regmap ?
> What is the case this "cache only" protects us from ?

Ah sorry this one is my bad, I was assuming these where the
runtime suspend/resume a closer look shows these are the system
suspend/resume. So yes it is pretty reasonable nothing will touch
the registers.

> 
> > Again this feels like you are getting confused on the
> > functionality of the API, bypassing the cache makes all
> > reads/writes go to the hardware, suspend normally turns the
> > hardware off. Directing all reads/writes to go to the hardware in
> > a function that normally turns the hardware off looks odd.
> Yes, I must certainly misunderstand something.
> Once again I must understand first why you expect accesses to be done after a
> suspend function was called ...
> 
> >> +	if (ret == 0)
> >> +		regcache_mark_dirty(codec->component.regmap);
> >> +
> >> +	snd_soc_cache_sync(codec);
> >
> > Probably best to have both the mark_dirty and the cache_sync in
> > the if. Whilst the cache sync is a no-op if it hasn't been marked
> > as dirty, will just be a bit clearer this is indentical to the
> > pre-regmap code and more likely to remain that way under future
> > changes.
> I must admit I was expecting that the 4 registers I wrote directly to hardware
> in bypass mode were marked as "dirty", and this sync() would restore them ...
> 
> Anyway, I have another idea to simplify the code greatly, it's only I'm not sure
> if my thinking is right. The idea is that these 3 registers (AC97_EXTENDED_MID,
> AC97_EXTENDED_MSTATUS, AC97_POWERDOWN) should never land in the regmap
> cache. What I think is that because they are in regmap_ac97_default_volatile(),
> they already have this property. Therefore, there is no need to do the bypass
> thing, and I could end up with :

Ah ok yes these are all volatile registers in which cause they
will bypass the naturally.

> 
> static int wm9713_soc_suspend(struct snd_soc_codec *codec)
> {
> 	/* Disable everything except touchpanel - that will be handled
> 	 * by the touch driver and left disabled if touch is not in
> 	 * use. */
> 	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
> 				 0x7fff);
> 	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
> 	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
> 	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
> 
>         /*
>          * RJK: still need to be convinced why this is necessary for this
>          *      next line
>          */
>         regcache_cache_only(codec->regmap, true);

Yes you are correct you can just drop this line.

> 
> 	return 0;
> }
> 
> static int wm9713_soc_resume(struct snd_soc_codec *codec)
> {
> 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
> 	int ret;
> 
>         /*
>          * RJK: still need to be convinced why this is necessary for this
>          *      next line
>          */
>         regcache_cache_only(codec->regmap, false);

ditto.

> 
> 	ret = snd_ac97_reset(wm9713->ac97, true, WM9713_VENDOR_ID,
> 		WM9713_VENDOR_ID_MASK);
> 	if (ret < 0)
> 		return ret;
> 
> 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
> 
> 	/* do we need to re-start the PLL ? */
> 	if (wm9713->pll_in)
> 		wm9713_set_pll(codec, 0, wm9713->pll_in, 0);
> 
> 	/* only synchronise the codec if warm reset failed */
> 	if (ret == 0) {
> 		regcache_mark_dirty(codec->component.regmap);
> 		snd_soc_cache_sync(codec);
> 	}
> 
> 	return ret;
> }
> 
> Thanks for your reviews.

Yeah that solution looks a lot more like what I was expecting.

Thanks,
Charles
