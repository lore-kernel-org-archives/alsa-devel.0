From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 9 Sep 2014 13:27:10 -0700
Message-ID: <20140909202710.GB5224@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada>
 <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada>
 <540F5D29.7040309@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540F5D29.7040309@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpa@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 09, 2014 at 03:03:53PM -0500, Timur Tabi wrote:
> On 09/09/2014 02:59 PM, Nicolin Chen wrote:
> >+	/*
> >+	 * Initially mark the clock to NULL for all platforms so that later
> >+	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
> >+	 */
> >+	ssi_private->clk = NULL;
> 
> According to Mark, NULL is a valid clock, so this should be instead:
> 
> 	ssi_private->clk = PTR_ERR(-EINVAL);
> 
> although that doesn't sit well with me.

I guess Mark's comment is merely against the check for clk validation
because if talking about clk validation, we should check IS_ERR(clk)
rather than check !=NULL directly.

However, my approach doesn't need any check. The open() or pm_resume()
can just call clk_prepare_enable() directly. The __clk_enable() will
then handle the 'clk == NULL' case:

static int __clk_enable(struct clk *clk)
{
	int ret = 0;

	if (!clk)
		return 0;
