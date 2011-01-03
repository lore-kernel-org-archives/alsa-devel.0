From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC sst: Add msic codec driver
Date: Mon, 3 Jan 2011 11:00:04 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C10F2BD7@bgsmsx502.gar.corp.intel.com>
References: <1293707551-8308-1-git-send-email-vinod.koul@intel.com>
	<20110102133322.GC4935@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B246103862
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 06:32:00 +0100 (CET)
In-Reply-To: <20110102133322.GC4935@opensource.wolfsonmicro.com>
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
> > This patch adds the msic asoc codec driver. This driver currently supports
> only playback.
> > Capture and jack detection to be added later
> 
> This looks mostly OK, but you probably want to run it through
> checkpatch.pl.  For quite a few of the debug prints you've got here
> you're replicating stuff that's in the core as standard - if you turn on
> debug logs from the core you should get equivalent logging.
Yes we have run checkpatch. Currently yes we have quite a few logs, we will
remove them later when we add the capture, jack detection etc. It would be
nice to have these logs on.

> Some more specific issues below:
> 
> > +	switch (params_format(params)) {
> > +	case SNDRV_PCM_FORMAT_S16_LE:
> > +		format = 3;
> > +		break;
> > +
> > +	case SNDRV_PCM_FORMAT_S24_LE:
> > +		format = 0;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	snd_soc_update_bits(dai->codec, MSIC_PCM2C2, BIT(4)|BIT(5), format);
> 
> This won't work - both the mask and value for snd_soc_update_bits() are
> bitmasks so I'd expect the format for S16 to be 0x18 with that bitmask.
> 
> > +	snd_soc_update_bits(dai->codec, MSIC_PCM1C1, BIT(7), rate);
Will fix

> Similarly here.
> 
> > +	/*PCM interface */
> > +	msic_write(codec, MSIC_PCM2RXSLOT01, 0x10);
> > +	msic_write(codec, MSIC_PCM2RXSLOT23, 0x32);
> > +	msic_write(codec, MSIC_PCM2RXSLOT45, 0x54);
> 
> For these it'd be better if you could provide some comments explaining
> what the configuration that's being set is.  It's hard to tell if this
> is stuff that should be managed by the driver or not.
Sure


> 
> > +static struct platform_driver intelmid_codec_driver = {
> > +	.driver		= {
> > +		.name		= "mid-msic-codec",
> 
> > +MODULE_ALIAS("msic-codec");
> 
> This should be platform:mid-msic-codec.
Okay

~Vinod
