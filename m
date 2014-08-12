Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 73519261A90
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 08:27:53 +0200 (CEST)
Date: Tue, 12 Aug 2014 11:36:09 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140812060601.GA1115@vinod.koul@linux.intel.com>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140729195043.GM17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140729195043.GM17528@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Add merrifield machine driver
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Tue, Jul 29, 2014 at 08:50:43PM +0100, Mark Brown wrote:
> On Thu, Jul 17, 2014 at 05:43:45PM +0530, Subhransu S. Prusty wrote:
> 
> > +	default n
> 
> This is the standard Kconfig behaviour - no need to specify it (other
> drivers don't...).
Removed.
> 
> > +static int mrfld_8958_hw_params(struct snd_pcm_substream *substream,
> > +			   struct snd_pcm_hw_params *params)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +
> > +	if (!strcmp(codec_dai->name, "wm8994-aif1"))
> > +		return mrfld_wm8958_set_clk(codec_dai);
> > +	return 0;
> > +}
> 
> It's much clearer to define separate operations for each DAI, there's no
> need for the string matching (especially given that there's nothing to
> do for other DAIs).
> 
Don't need the comparison. Removed
> > +	/*
> > +	 * Machine uses 2 DMICs, other configs may use more so change below
> > +	 * accordingly
> > +	 */
> > +	{ "DMIC1DAT", NULL, "DMIC" },
> > +	{ "DMIC2DAT", NULL, "DMIC" },
> > +	/*{ "DMIC3DAT", NULL, "DMIC" },*/
> > +	/*{ "DMIC4DAT", NULL, "DMIC" },*/
> 
> Remove commented out code.
> 
Done
> > +	/* Force enable VMID to avoid cold latency constraints */
> > +	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
> > +	snd_soc_dapm_sync(&card->dapm);
> 
> This looks like you're open coding a version of wm8994_vmid_mode().
> Though that might need some tuning for systems that really have no
> single ended outputs.
> 
VMID has a larget settling time. Keep it ON here to avoid the delay. Any
better way of doing this?
> > +	/*
> > +	 * Micbias1 is always off, so for pm optimizations make sure the micbias1
> > +	 * discharge bit is set to floating to avoid discharge in disable state
> > +	 */
> > +	snd_soc_update_bits(codec, WM8958_MICBIAS1, WM8958_MICB1_DISCH, 0);
> 
> Don't write directly to CODEC registers, provide a way of configuring
> this in the CODEC either via platform data or some API.  That way
> nothing else is writing to the CODEC register map without the driver for
> the CODEC knowing about it.
> 
Yes it can be given through the pdata. Removed.
> > +static void snd_mrfld_8958_complete(struct device *dev)
> > +{
> > +	struct snd_soc_card *card = dev_get_drvdata(dev);
> > +	struct snd_soc_codec *codec = card->rtd[CODEC_BE].codec;
> > +	struct snd_soc_dapm_context *dapm;
> > +
> > +	pr_debug("In %s\n", __func__);
> > +
> > +	pr_debug("found codec %s\n", codec->component.name);
> > +	dapm = &codec->dapm;
> > +
> > +	snd_soc_dapm_force_enable_pin(dapm, "VMID");
> > +	snd_soc_dapm_sync(dapm);
> > +
> > +	snd_soc_resume(dev);
> > +}
> 
> Doing the manual fiddling before rather than after resuming the core
> seems...  concerning, I'd expect this to be done either in one of the
> ASoC suspend/resume callbacks or at least after calling snd_soc_resume()
> - doing it before seems likely to trigger or cause bugs.
Complete callback is called only after resume. 
> 
> > +static int snd_mrfld_8958_poweroff(struct device *dev)
> > +{
> > +	pr_debug("In %s\n", __func__);
> > +	snd_soc_poweroff(dev);
> > +	return 0;
> > +}
> 
> Remove this, just use the core function directly.
Removed.
> 
> > +	platform_set_drvdata(pdev, &snd_soc_card_mrfld);
> > +	pr_info("%s successful\n", __func__);
> 
> This print has no content, remove it or at the very least downgrade it
> to debug level.
Done



-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
