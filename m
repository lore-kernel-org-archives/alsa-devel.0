From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Tue, 12 Dec 2017 16:51:35 -0600
Message-ID: <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f182.google.com (mail-ot0-f182.google.com
 [74.125.82.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 6857C2677B8
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 23:51:39 +0100 (CET)
Received: by mail-ot0-f182.google.com with SMTP id v21so435292oth.6
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 14:51:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 12, 2017 at 03:31:16PM -0600, Steven Eckhoff wrote:
> On Tue, Dec 12, 2017 at 04:32:54PM +0000, Mark Brown wrote:
> > On Mon, Dec 11, 2017 at 01:54:25PM -0600, Steven Eckhoff wrote:
> > > Currently there is no support for the TSCS42xx audio CODEC.
> > > 
> > > Add support for it.
> > > 
> > > v5 attempts to address all issues raised in the previous reviews.
> > > 
> > > Thank you to everyone who has invested their time reviewing these
> > > patches.
> > 
> > Please add inter-version changelogs and commentary like this after --- 
> > as covered in SubmittingPatches - this lets tools know they don't need
> > to end up in git.
> > 
> Again I apologize. I will fix this. I will also go over the document to
> make sure nothing else gets messed up. Also thank you for the time you
> have spent reviewing the numerous versions of this patch.
> 
> > > +  - compatible : "tscs:tscs42xx"
> > 
> > Compatible strings should be for specific devices, they may all be
> > treated identically by software now but may not be in future.
> > 
> Okay, this will be fixed in the next version.
> 
> > > +		do {
> > > +			ret = snd_soc_read(codec, R_DACCRSTAT);
> > > +			if (ret < 0) {
> > > +				dev_err(codec->dev,
> > > +					"Failed to read stat (%d)\n", ret);
> > > +				return ret;
> > > +			}
> > > +		} while (ret);
> > 
> > There should be some sort of upper bound on how many times we'll try to
> > wait for this in case the hardware fails somehow.
> > 
> I totally agree. Most of the time the DACCRSTAT should be cleared before
> the next iteration starts, so I will sleep it 20ms if it isn't
> cleared by then and error if it hasn't cleared after 20ms.
> 
> > > +static int tscs42xx_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
> > > +{
> > > +	struct snd_soc_codec *codec = dai->codec;
> > > +	int ret;
> > > +
> > > +	if (mute)
> > > +		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > +			ret = dac_mute(codec);
> > > +		else
> > > +			ret = adc_mute(codec);
> > > +	else
> > > +		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > +			ret = dac_unmute(codec);
> > > +		else
> > > +			ret = adc_unmute(codec);
> > > +
> > > +	return ret;
> > > +}
> > 
> > All these mute functions also shut down the PLLs which since...
> > 
> This is a bit funky since it looks like if you unmuted the dac and then
> muted the adc that the PLLs would be powered off on the playback stream,
> but the logic in the chip is a bit funky in that it wont allow this unless
> the playback interface is also powered off.
> 
> This should definitely be fixed since it is confusing. The PLL
> powered up/down stuff will be removed from the mute functions in the
> next version.
> 
> What are your thoughts on turning the PLL into a DAPM widget and using
> the event callback to power up/down the PLLs? I have tested this and it
> seems to work fine.
> 
> > > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > > +	case SND_SOC_DAIFMT_CBM_CFM:
> > > +		ret = snd_soc_update_bits(codec, R_AIC1, RM_AIC1_MS,
> > > +				RV_AIC1_MS_MASTER);
> > > +		if (ret < 0)
> > > +			dev_err(codec->dev,
> > > +				"Failed to set codec DAI master (%d)\n", ret);
> > > +		else
> > > +			ret = 0;
> > > +		break;
> > > +	default:
> > 
> > ...we only support the CODEC being the clock master seems like it might
> > mean we stop clocking the DAI?  If that's the case it's better to just
> > not have the mute control and allow the user to just control these as
> > normal mutes.
> > 
> I am going to put slave mode support in, but I may need some time to
> test how it works.
> 
Okay I had to refresh my memory on why slave was not being supported.
Our slave mode needs the audio clocks to stay active to avoid pops. This
has something to do with how the charge pump is setup. In master mode
this is not an issue. I will keep the slave mode support out of the next
version.

Also I am not sure what you mean with the mute controls. Could you
elaborate more on this?

> > > +static int tscs42xx_probe(struct snd_soc_codec *codec)
> > > +{
> > > +	int i;
> > > +	int ret;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(r_inits); ++i) {
> > > +		ret = snd_soc_write(codec, r_inits[i].reg, r_inits[i].def);
> > > +		if (ret < 0) {
> > > +			dev_err(codec->dev,
> > > +				"Failed to write codec defaults (%d)\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > 
> > I'd expect the driver to just reset the CODEC (it appears to have that
> > feature) and the regmap.
> > 
> These init values were meant to be driver defaults that differed from
> the device defaults. In hindsight this was a bad idea. I am removing
> them in the next revision and will have the machine driver setup the
> codec appropriately.
> 
> > > +static int tscs42xx_remove(struct snd_soc_codec *codec)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > Just remove empty functions.
> > 
> Next revision will have this removed.
> 
> > > +static const struct i2c_device_id tscs42xx_i2c_id[] = {
> > > +	{ "tscs42xx", 0 },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, tscs42xx_i2c_id);
> > 
> > I2C IDs are better as explicit part numbers too like compatible
> > strings.
> I will update this in the next version.
> 
