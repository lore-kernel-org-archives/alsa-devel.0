From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Fri, 6 Nov 2015 11:11:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.140])
 by alsa0.perex.cz (Postfix) with ESMTP id D385A26040E
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 12:11:41 +0100 (CET)
In-Reply-To: <20151105152736.GO18409@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On November 5, 2015 15:28, Mark Brown wrote:

> > +/* ALC */
> > +static void da7218_alc_calib(struct snd_soc_codec *codec)
> > +{
> > +	struct da7218_priv *da7218 = snd_soc_codec_get_drvdata(codec);
> > +	u8 calib_ctrl;
> > +	int i = 0;
> > +	bool calibrated = false;
> > +
> > +	/* Bypass cache so it saves current settings */
> > +	regcache_cache_bypass(da7218->regmap, true);
> 
> What ensures that nothing else is running at the same time this is?

Is a fair point. Originally I was saving the state of registers then
re-instating them at the end, which worked fine, but then was trying to be
clever and tidy things up by bypassing the cache instead. Will revert back to
the previous method.

> 
> > +static int da7218_mic_lvl_det_sw_put(struct snd_kcontrol *kcontrol,
> > +				     struct snd_ctl_elem_value *ucontrol)
> > +{
> 
> Why is this a user visible control?

I can envisage in a system you may want to choose which capture channels can
trigger level detection (if any), and this may change depending on the use-case
at the time, so having it as a control makes sense to me.

> 
> > +	/* Default all mixers off */
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_1L, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_1R, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_2L, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTDAI_2R, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTFILT_1L, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_OUTFILT_1R, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_ST_OUTFILT_1L, 0);
> > +	snd_soc_write(codec, DA7218_DROUTING_ST_OUTFILT_1R, 0);
> 
> We generally just use the device defaults, why change them?

I figured it made more sense to have the device start with audio routes disabled
but I can remove this as it's really not essential.
