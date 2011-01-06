From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC sst v2: Add sn95031 codec driver
Date: Thu, 6 Jan 2011 12:17:04 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119C32E@bgsmsx502.gar.corp.intel.com>
References: <1294152367-8883-1-git-send-email-vinod.koul@intel.com>
	<20110105235652.GB5770@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 11ECF24443
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 07:47:19 +0100 (CET)
In-Reply-To: <20110105235652.GB5770@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> 
> A few comments below; depending on what Liam feels I think we can
> possibly merge this as-is on the basis that it's going to get future
> updates.
Thanks Mark,
As we had communicated back in Nov that we are committed to asoc porting.
We will continue to submit patches for fixing these as well as adding new
features and codecs.

Liam, please let us know your comments or if you are okay with this.
> 
> > +	/* PCM interface config
> > +	 * This sets the pcm rx slot conguration to max 6 slots
> > +	 * for max 4 dais (2 stereo and 2 mono)
> > +	 */
> > +	snd_soc_write(codec, SN95031_PCM2RXSLOT01, 0x10);
> > +	snd_soc_write(codec, SN95031_PCM2RXSLOT23, 0x32);
> > +	snd_soc_write(codec, SN95031_PCM2RXSLOT45, 0x54);
> > +	/* pcm port setting
> > +	 * This sets the pcm port to slave and clock at 19.2Mhz which
> > +	 * can support 6slots, sampling rate set per stream in hw-params
> > +	 */
> > +	snd_soc_write(codec, SN95031_PCM1C1, 0x00);
> > +	snd_soc_write(codec, SN95031_PCM2C1, 0x01);
> > +	snd_soc_write(codec, SN95031_PCM2C2, 0x0A);
> > +	snd_soc_write(codec, SN95031_HSMIXER, BIT(0)|BIT(4));
> 
> This stuff should all be dynamically configured at runtime - the clocks
> should be being managed with set_sysclk() and the slot configuration
> with the TDM API or dynamic routing depending on what the actual control
> is.
> 
> I guess this is OK for now, though.
Since we have single PCM port and TDM slots. For all DAIs it needs to be single
configuration and not changed while one is running.
 
> > +	/* soft mute ramp time */
> > +	snd_soc_write(codec, SN95031_SOFTMUTE, 0x3);
> 
> Ideally this should be user controllable.
I will send a patch later for this

> 
> > +	/* dac mode and lineout workaround */
> > +	snd_soc_write(codec, SN95031_SSR2, 0x10);
> > +	snd_soc_write(codec, SN95031_SSR3, 0x40);
> 
> DAC mode?
DAC performance mode, yes ideally it should be in controls
Will add next...

> 
> > +struct snd_soc_codec_driver sn95031_codec = {
> > +	.probe =	sn95031_codec_probe,
> > +	.remove =	sn95031_codec_remove,
> > +	.read		= sn95031_read,
> > +	.write		= sn95031_write,
> > +	.set_bias_level	= sn95031_set_vaud_bias,
> > +};
> 
> The formatting of the = should be consistent here.
> 
> > +MODULE_DESCRIPTION("ASoC Intel(R) SN95031 codec driver");
> 
> I thought you said this was a TI chip?  For example...
> 
> > + *  sn95031.h - TI sn95031 Codec driver
My bad missed it, will fix it in next patch.

~Vinod
