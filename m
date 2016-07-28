From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Thu, 28 Jul 2016 12:03:57 -0700
Message-ID: <20160728190356.GB4742@Asurada-Nvidia>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160728185510.GK11806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, bardliao@realtek.com, oder_chiou@realtek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 28, 2016 at 07:55:10PM +0100, Mark Brown wrote:
> > > This device seems to be used on x86 systems so we'll need to ensure that
> > > they register clocks for this.  They really should set this up using
> > > quirks keyed off DMI information or similar so it's hidden from other
> > > systems.
> 
> > Hmm..the change defines this mclk as a optional property so I'm
> > not sure how it would affect x86 systems. (Would love to refine
> 
> Ah, clk_prepare_enable() silently ignores NULL as an argument?  It is a
> bit messy to do things that way but might be the most practical thing.

At least the one in the drivers/clk/clk.c does:

660 int clk_prepare(struct clk *clk)
661 {
662         int ret;
663
664         if (!clk)
665                 return 0;
...
774 int clk_enable(struct clk *clk)
775 {
776         unsigned long flags;
777         int ret;
778
779         if (!clk)
780                 return 0;

> Hopefully they'll speak up - we're in the merge window anyway so it'll
> be just over a week before this can go into -next.

I see. Let's wait then.

Thanks
Nicolin
