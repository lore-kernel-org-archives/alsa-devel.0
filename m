From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7 1/4] ASoC: arizona: Export functions to control
	subsystem DVFS
Date: Mon, 1 Jun 2015 17:22:51 +0100
Message-ID: <20150601162241.GA13681@opensource.wolfsonmicro.com>
References: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com> <20150601161047.GC14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150601161047.GC14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 01, 2015 at 05:10:47PM +0100, Mark Brown wrote:
> On Mon, Jun 01, 2015 at 02:04:48PM +0100, Richard Fitzgerald wrote:
> 
> > +int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags)
> > +{
> > +	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
> > +	unsigned int old_reqs = priv->dvfs_reqs;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&priv->dvfs_lock);
> > +
> > +	priv->dvfs_reqs &= ~flags;
> > +
> > +	if (!priv->dvfs_cached && old_reqs && !priv->dvfs_reqs)
> > +		ret = arizona_dvfs_disable(codec);
> 
> What is the lock intended to protect here?  We read old_reqs outside the
> lock so it's possible that dvfs_reqs could change between us reading
> old_reqs and the locked section - I would have expected to see all the
> reads and updates to be in the locked section but perhaps it doesn't
> protect what I think it protects (all the DVFS-related variables).
> 

Damn, I didn't notice that assignment when I added the mutex lock.

> > +	case SND_SOC_DAPM_PRE_PMD:
> > +		/* We must ensure DVFS is disabled before the codec goes into
> > +		 * suspend so that we are never in an illegal state of DVFS
> > +		 * enabled without enough DCVDD
> > +		 */
> > +		priv->dvfs_cached = true;
> > +
> > +		if (priv->dvfs_reqs)
> > +			ret = arizona_dvfs_disable(codec);
> 
> Are you sure that the function shouldn't check for requests?  It seems
> like every caller is repeating the same check.

Sorry, I don't understand your comment here. When SYSCLK is disabled
we need to disable DVFS so that the codec can't go into suspend in the
illegal state of DVFS enabled but insifficient DCVDD. However, if
dvfs_reqs==0 DVFS is already disabled so we can save some time.
