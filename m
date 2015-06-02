From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7 1/4] ASoC: arizona: Export functions to control
	subsystem DVFS
Date: Tue, 2 Jun 2015 11:32:41 +0100
Message-ID: <20150602103232.GA11622@opensource.wolfsonmicro.com>
References: <1433163891-10084-1-git-send-email-rf@opensource.wolfsonmicro.com> <20150601161047.GC14071@sirena.org.uk> <20150601162241.GA13681@opensource.wolfsonmicro.com> <20150601163604.GE14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150601163604.GE14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 01, 2015 at 05:36:04PM +0100, Mark Brown wrote:
> On Mon, Jun 01, 2015 at 05:22:51PM +0100, Richard Fitzgerald wrote:
> > On Mon, Jun 01, 2015 at 05:10:47PM +0100, Mark Brown wrote:
> 
> > > > +		if (priv->dvfs_reqs)
> > > > +			ret = arizona_dvfs_disable(codec);
> 
> > > Are you sure that the function shouldn't check for requests?  It seems
> > > like every caller is repeating the same check.
> 
> > Sorry, I don't understand your comment here. When SYSCLK is disabled
> > we need to disable DVFS so that the codec can't go into suspend in the
> > illegal state of DVFS enabled but insifficient DCVDD. However, if
> > dvfs_reqs==0 DVFS is already disabled so we can save some time.
> 
> Sure, but you repeat the same tests for dvfs_reqs at every call site
> which suggests it should be factored into the functions.

I don't. There are two cases that call them if (!dvfs_reqs) and two
that call them if (dvfs_reqs)
