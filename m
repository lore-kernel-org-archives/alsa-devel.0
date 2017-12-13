From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Wed, 13 Dec 2017 00:20:39 -0600
Message-ID: <20171213062037.ti2w2rharpjji2bf@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7556E26717B
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 07:20:51 +0100 (CET)
Received: by mail-oi0-f51.google.com with SMTP id l6so863358oih.11
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 22:20:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171212225134.mmwigvfgi7fbvgyz@localhost.localdomain>
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

On Tue, Dec 12, 2017 at 04:51:35PM -0600, Steven Eckhoff wrote:

> > > > +static int tscs42xx_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
> > > > +{
> > > > +	struct snd_soc_codec *codec = dai->codec;
> > > > +	int ret;
> > > > +
> > > > +	if (mute)
> > > > +		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > > +			ret = dac_mute(codec);
> > > > +		else
> > > > +			ret = adc_mute(codec);
> > > > +	else
> > > > +		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > > > +			ret = dac_unmute(codec);
> > > > +		else
> > > > +			ret = adc_unmute(codec);
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > All these mute functions also shut down the PLLs which since...
> > > 
> > This is a bit funky since it looks like if you unmuted the dac and then
> > muted the adc that the PLLs would be powered off on the playback stream,
> > but the logic in the chip is a bit funky in that it wont allow this unless
> > the playback interface is also powered off.
> > 
> > This should definitely be fixed since it is confusing. The PLL
> > powered up/down stuff will be removed from the mute functions in the
> > next version.
> > 
> > What are your thoughts on turning the PLL into a DAPM widget and using
> > the event callback to power up/down the PLLs? I have tested this and it
> > seems to work fine.
> > 
> > > > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > > > +	case SND_SOC_DAIFMT_CBM_CFM:
> > > > +		ret = snd_soc_update_bits(codec, R_AIC1, RM_AIC1_MS,
> > > > +				RV_AIC1_MS_MASTER);
> > > > +		if (ret < 0)
> > > > +			dev_err(codec->dev,
> > > > +				"Failed to set codec DAI master (%d)\n", ret);
> > > > +		else
> > > > +			ret = 0;
> > > > +		break;
> > > > +	default:
> > > 
> > > ...we only support the CODEC being the clock master seems like it might
> > > mean we stop clocking the DAI?  If that's the case it's better to just
> > > not have the mute control and allow the user to just control these as
> > > normal mutes.
> > > 
> > I am going to put slave mode support in, but I may need some time to
> > test how it works.
> > 
> Okay I had to refresh my memory on why slave was not being supported.
> Our slave mode needs the audio clocks to stay active to avoid pops. This
> has something to do with how the charge pump is setup. In master mode
> this is not an issue. I will keep the slave mode support out of the next
> version.
> 
> Also I am not sure what you mean with the mute controls. Could you
> elaborate more on this?
> 
Okay I belive I know what this was all about. 

Were you asking why the mute functions are powering up/down the PLLs?

The answer is that is was a vestige of the very first version of the
driver where I was told I needed to power PLLs before unmuting and
muting before powering them down, which is correct I just didn't have
them in the correct callback. In the next version I have moved the
powering of the PLLs into the event call back of a DAPM supply widget.
If there is a better way I can implement that.

The previous comment on slave mode is still valid, so the next version
will only suppor the codec in master mode.

Sorry for any confusion that I may have caused.
