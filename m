From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 4/7] ASoC: Intel: kbl: Enable mclk and
 ssp sclk early
Date: Wed, 6 Dec 2017 17:25:07 +0530
Message-ID: <20171206115506.GR32417@localhost>
References: <1511352592-4006-1-git-send-email-sriramx.periyasamy@intel.com>
 <1511352592-4006-5-git-send-email-sriramx.periyasamy@intel.com>
 <20171205233326.GD4283@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C8B4266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 12:51:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171205233326.GD4283@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Harsha Priya <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, mturquette@baylibre.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 05, 2017 at 03:33:26PM -0800, Stephen Boyd wrote:
> On 11/22, Sriram Periyasamy wrote:

> > +static int platform_clock_control(struct snd_soc_dapm_widget *w,
> > +			struct snd_kcontrol *k, int  event)
> > +{
> > +	struct snd_soc_dapm_context *dapm = w->dapm;
> > +	struct snd_soc_card *card = dapm->card;
> > +	struct kbl_rt5663_private *priv = snd_soc_card_get_drvdata(card);
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * MCLK/SCLK need to be ON early for a successful synchronization of
> > +	 * codec internal clock. And the clocks are turned off during
> > +	 * POST_PMD after the stream is stopped.
> > +	 */
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		if (__clk_is_enabled(priv->mclk))
> 
> Why do you need to use this in your consumer driver? Do you not
> know if the clk is on at boot time and then you need to make sure
> you don't call clk_set_rate() on an already enabled clk? If so,
> why can't the provider driver for mclk take care of that and do
> nothing if the clk is enabled already and clk_set_rate() is
> called with the same rate as what's in the hardware?

yes makes sense, we will move the check of __clk_is_enabled() in the
provider driver and let that return success if it is already at same rate
etc and is enabled.

-- 
~Vinod
