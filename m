From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Tue, 9 Sep 2014 12:59:29 -0700
Message-ID: <20140909195928.GA5224@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C1842652F4
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 21:59:43 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id hz1so8715629pad.35
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 12:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540F5706.1050303@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com, mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 09, 2014 at 02:37:42PM -0500, Timur Tabi wrote:
> On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> >make sure to have the call for imx only because it seems that
> >the other platforms do not depend on the clock.
> 
> Although I doubt anyone will every add support for clocks to PowerPC "side"
> of this driver, I would prefer to avoid IMX-specific changes. Instead, the
> code should check if a clock is available.  That's why I suggested this
> change:
> 
> -	if (ssi_private->soc->imx)
> +	if (!IS_ERR(ssi_private->clk))

Hmm.... I think the following change may be better?

probe() {
	....
+	/*
+	 * Initially mark the clock to NULL for all platforms so that later
+	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
+	 */
+	ssi_private->clk = NULL;
	.....
	fsl_ssi_imx_probe();
}

In this way, all platforms, not confined to imx any more, will be able
to call clk_prepare_enable(). Then we don't need an extra platform check
before calling it.
