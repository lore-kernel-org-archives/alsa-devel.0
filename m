From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Fri, 12 Sep 2014 11:33:24 -0700
Message-ID: <20140912183324.GA2738@Alpha>
References: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, timur@tabi.org
Cc: Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, mpa@pengutronix.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 12, 2014 at 06:35:15PM +0800, Shengjiu Wang wrote:
> Check if ipg clock is in clock-names property, then we can move the
> ipg clock enable and disable operation to startup and shutdown, that
> is only enable ipg clock when ssi is working and keep clock is disabled
> when ssi is in idle.
> But when the checking is failed, remain the clock control as before.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

The patch looks fine to me. I tested the has_ipg_clk_name == true
case, and it works fine. As long as there's no further objection,
I can give an Acked-by. (I think Timur and Markus may like to have
a test as well.)

Thank you
Nicolin
