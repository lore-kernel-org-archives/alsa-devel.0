From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 5/5] ALSA - hda: Add support for link
 audio time reporting
Date: Thu, 4 Aug 2016 07:30:10 +0530
Message-ID: <20160804020010.GZ9681@localhost>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
 <1470240374-20018-6-git-send-email-vinod.koul@intel.com>
 <s5hh9b19630.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1ED6265294
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 03:52:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hh9b19630.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 03, 2016 at 06:21:07PM +0200, Takashi Iwai wrote:
> > +{
> > +	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)ctx;
> 
> Superfluous cast.

ok

> > +		dma_select = (direction << GTSCC_CDMAS_DMA_DIR_SHIFT) |
> > +					(azx_dev->core.stream_tag - 1);
> > +		_snd_hdac_chip_write(l, azx_bus(chip), AZX_REG_GTSCC,
> > +						dma_select);
> 
> You can use
> 		snd_hdac_chip_writel(azx_bus(chip), GTSCC, dma_select);
> 
> The use of _snd_hdac_chip_write() is for non-constant registers.  When
> you pass AZX_REG_XXX, you can use the standard macro.  For example:

Yes I remeber that. I did see this earlier but missed to update :(

> > +		/* Enable the capture */
> > +		_snd_hdac_chip_write(l, azx_bus(chip), AZX_REG_GTSCC,
> > +				     _snd_hdac_chip_read(l, azx_bus(chip),
> > +					AZX_REG_GTSCC) | GTSCC_TSCCI_MASK);
> 
> This can be simplified with snd_hdac_chip_updatel().

ok


> > +	if (retry_count == HDA_MAX_CYCLE_READ_RETRY) {
> > +		dev_err(chip->card->dev, "Error in WALFCC cycle count\n");
> 
> Hrm, this has a danger to spew huge amount of error messages, since
> this gets called so often.

print once or rate limit?


> > -	} else
> > +	} else if ((runtime->hw.info &
> > +			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME) &&
> > +			(audio_tstamp_config->type_requested ==
> > +			SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED)) {
> 
> The indentation is hard to follow here...

will fix

> 
> > +
> > +		azx_get_crosststamp(substream, &xtstamp);
> 
> No error check?

yes will add

-- 
~Vinod
