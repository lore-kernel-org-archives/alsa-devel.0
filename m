From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 1/2] ASoC: wm9713: convert to regmap
Date: Wed, 28 Oct 2015 21:34:33 +0100
Message-ID: <87io5qka06.fsf@belgarion.home>
References: <1445983102-15490-1-git-send-email-robert.jarzmik@free.fr>
	<20151028124351.GK10520@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028124351.GK10520@ck-lbox> (Charles Keepax's message of
	"Wed, 28 Oct 2015 12:43:51 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:

>> @@ -1158,6 +1199,9 @@ static int wm9713_soc_suspend(struct snd_soc_codec *codec)
>>  {
>>  	u16 reg;
>>  
>> +	snd_soc_cache_sync(codec);
>
> There doesn't seem to be much point in syncing the cache at the
> start of a suspend, in theory I would expect the cache to be in
> sync at this point anyway.
> I think you are thinking of this wrong, cache_sync does not
> ensure all previous writes have been commited, as I explained
> in my last email it literally writes the cache to the hardware,
> suspend usually turns the hardware off. So why write all the
> registers to the hardware just before turning it off.
Indeed, I'll remove it.

>> +	regcache_cache_bypass(codec->component.regmap, true);
>
> Why is the necessary? I can't see an obvious sign that these
> writes bypass the cache in the non-regmap version, am I missing
> something?
This is because to mimic the previous behavior, the next 4 writes
(AC97_EXTENDED_MID, AC97_EXTENDED_MSTATUS, AC97_POWERDOWN * 2) should hit the
hardware but not the cache (hence the bypass), but see below for the follow-up
of my thinking.

> Also if this is necessary I would quite like it to be
> accompanied by a comment in the code to explain why it is safe to
> do this here. Regarding the inherent dangers of cache bypass I
> explained in my last email.
Well, once suspended I supposed no access should be done before the resume
function is called, hence the "safe" part.

>>  	/* Disable everything except touchpanel - that will be handled
>>  	 * by the touch driver and left disabled if touch is not in
>>  	 * use. */
>> @@ -1173,14 +1217,14 @@ static int wm9713_soc_suspend(struct snd_soc_codec *codec)
>
> I would have expected to see the cache being put into cache only
> mode at some point during suspend, am I missing something here as
> well?
Why ? Once suspended, why would you expect an access to be done to the regmap ?
What is the case this "cache only" protects us from ?

> Again this feels like you are getting confused on the
> functionality of the API, bypassing the cache makes all
> reads/writes go to the hardware, suspend normally turns the
> hardware off. Directing all reads/writes to go to the hardware in
> a function that normally turns the hardware off looks odd.
Yes, I must certainly misunderstand something.
Once again I must understand first why you expect accesses to be done after a
suspend function was called ...

>> +	if (ret == 0)
>> +		regcache_mark_dirty(codec->component.regmap);
>> +
>> +	snd_soc_cache_sync(codec);
>
> Probably best to have both the mark_dirty and the cache_sync in
> the if. Whilst the cache sync is a no-op if it hasn't been marked
> as dirty, will just be a bit clearer this is indentical to the
> pre-regmap code and more likely to remain that way under future
> changes.
I must admit I was expecting that the 4 registers I wrote directly to hardware
in bypass mode were marked as "dirty", and this sync() would restore them ...

Anyway, I have another idea to simplify the code greatly, it's only I'm not sure
if my thinking is right. The idea is that these 3 registers (AC97_EXTENDED_MID,
AC97_EXTENDED_MSTATUS, AC97_POWERDOWN) should never land in the regmap
cache. What I think is that because they are in regmap_ac97_default_volatile(),
they already have this property. Therefore, there is no need to do the bypass
thing, and I could end up with :

static int wm9713_soc_suspend(struct snd_soc_codec *codec)
{
	/* Disable everything except touchpanel - that will be handled
	 * by the touch driver and left disabled if touch is not in
	 * use. */
	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
				 0x7fff);
	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);

        /*
         * RJK: still need to be convinced why this is necessary for this
         *      next line
         */
        regcache_cache_only(codec->regmap, true);

	return 0;
}

static int wm9713_soc_resume(struct snd_soc_codec *codec)
{
	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
	int ret;

        /*
         * RJK: still need to be convinced why this is necessary for this
         *      next line
         */
        regcache_cache_only(codec->regmap, false);

	ret = snd_ac97_reset(wm9713->ac97, true, WM9713_VENDOR_ID,
		WM9713_VENDOR_ID_MASK);
	if (ret < 0)
		return ret;

	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);

	/* do we need to re-start the PLL ? */
	if (wm9713->pll_in)
		wm9713_set_pll(codec, 0, wm9713->pll_in, 0);

	/* only synchronise the codec if warm reset failed */
	if (ret == 0) {
		regcache_mark_dirty(codec->component.regmap);
		snd_soc_cache_sync(codec);
	}

	return ret;
}

Thanks for your reviews.

-- 
Robert
