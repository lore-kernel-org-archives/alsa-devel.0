From: Li Xu <li.xu@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs43130: Add support for CS43130
	codec
Date: Fri, 18 Aug 2017 10:30:17 -0500
Message-ID: <c97858b7-67f8-4071-9aec-d09663989a37@EX4.ad.cirrus.com>
References: <f5ea5455-b359-4f55-bf73-ee69a7c5d54d@EX3.ad.cirrus.com>
 <20170809161101.iab74ibtcjat4q3v@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EE38D2669F3
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 17:28:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170809161101.iab74ibtcjat4q3v@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, brian.austin@cirrus.com, tiwai@suse.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 09, 2017 at 05:11:01PM +0100, Mark Brown wrote:
> On Wed, Aug 09, 2017 at 10:00:21AM -0500, Li Xu wrote:
> 
> > +	if (cs43130->dev_id == CS43131_CHIP_ID ||
> > +	    cs43130->dev_id == CS43198_CHIP_ID) {
> > +		if (val >= 2)
> 
> Throughout the driver you're doing lots of ID checks like this with if
> statements, these are better written with switch statements so it's
> easier to add new cases in (eg, if a new chip variant gets made) and so
> that it's clear that the default case is being handled properly.
> 

Agreed.

> > +static const char * const enum_texts[] = {
> > +	"Off",
> > +	"On",
> > +};
> > +
> > +static SOC_ENUM_SINGLE_DECL(pcm_phs_enum, CS43130_PCM_FILT_OPT, 6, enum_texts);
> > +
> > +static SOC_ENUM_SINGLE_DECL(pcm_nos_enum, CS43130_PCM_FILT_OPT, 5, enum_texts);
> > +
> > +static SOC_ENUM_SINGLE_DECL(pcm_high_enum, CS43130_PCM_FILT_OPT, 1, enum_texts);
> > +
> > +static SOC_ENUM_SINGLE_DECL(pcm_dmp_enum, CS43130_PCM_FILT_OPT, 0, enum_texts);
> 
> These look like simple on/off switches, why are they enums?
> 

You are right.  Changing to SOC_SINGLE.

> > +static int cs43130_pcm_mute(struct snd_soc_dai *dai, int mute)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	struct cs43130_private *cs43130 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	if (mute) {
> > +		if (cs43130->dev_id == CS43130_CHIP_ID ||
> > +		    cs43130->dev_id == CS4399_CHIP_ID) {
> > +			regmap_multi_reg_write(cs43130->regmap, mute_seq,
> > +					       ARRAY_SIZE(mute_seq));
> > +			regmap_update_bits(cs43130->regmap,
> > +					   CS43130_PCM_PATH_CTL_1,
> > +					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
> > +			/*
> > +			 * PCM Power Down Sequence
> > +			 * According to Design, 130ms is preferred.
> > +			 */
> > +			msleep(130);
> 
> Powering down doesn't sound like muting, shouldn't this be DAPM stuff
> (especially with the very long 130ms delay)?  What is this actually
> doing at the chip level, the register names do sound like muting might
> be part of it but it looks like there's more?
> 

130ms delay is added to remove pop noise during stopping audio playback.
You are right that it is not just muting, but part of stopping audio playback.
I am moving this sequence as part of DAPM.

> > +static char *hpload_msgs[] = {
> > +	"HPLOAD_DC_L:%u\n",
> > +	"HPLOAD_DC_R:%u\n",
> > +};
> > +
> > +static char *hpload_ac_msgs[] = {
> > +	"HPLOAD_AC_L:%u:%u\n",
> > +	"HPLOAD_AC_R:%u:%u\n",
> > +};
> 
> > +	if (cs43130->ac_meas) {
> > +		for (k = 0; k < CS43130_AC_FREQ; k++) {
> > +			for (j = 0; j < ARRAY_SIZE(hpload_ac_msgs); j++) {
> 
> The loops are wrapping their iterators in the order i, k, j not i, j, k.
> 

Will fix.

> > +				ret = scnprintf(buf + i, PAGE_SIZE - i,
> > +						hpload_ac_msgs[j],
> > +						cs43130->ac_freq[k],
> > +						cs43130->hpload_ac[k][j]);
> 
> We're not using ARRAY_SIZE() for the k iteration, this whole thing feels
> risky.  In any case...
> 

OK.

> > +static DEVICE_ATTR(hpload, S_IRUGO, cs43130_show_hpload, NULL);
> 
> ...you're adding device attributes that aren't just single values (which
> is a requirement for all sysfs files).  It'd be a lot simpler and
> compliant with the sysfs ABI to just make four appropriately named files
> with the individual values in them if they exist.
> 

OK.  Seperating into 4 individual files, with each containing impedance for DC
Left, Right, and AC Left, Right.

> > +	cs43130->idle_bias_off = of_property_read_bool(np,
> > +						       "cirrus,idle-bias-off");
> 
> This should not be in the DT - either the device can reasonably power
> down when idle or it can't but that's not machine specific configuration
> and is a Linux specific implementation detail anyway.
> 

OK, removing from DT.

> > +static const struct i2c_device_id cs43130_i2c_id[] = {
> > +	{"cs43130", 0},
> > +	{}
> > +};
> 
> Since the driver supports multiple parts I'd expect to see all the parts
> individually recognized as I2C IDs, and similarly for DT compatible
> strings.  This makes it easier for people to do system integration and
> means that if it turns out we need the data it's there.

OK, adding additional IDs for I2C and DT.
