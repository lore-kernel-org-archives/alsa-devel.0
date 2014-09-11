From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Thu, 11 Sep 2014 15:57:37 -0700
Message-ID: <20140911225737.GA13926@Alpha>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: timur@tabi.org, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 11, 2014 at 01:38:29PM +0800, Shengjiu Wang wrote:
> Move the ipg clock enable and disable operation to startup and shutdown,
> that is only enable ipg clock when ssi is working. Keep clock is disabled
> when ssi is in idle.
> otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
> so add ipg clock control for it.

It seems to be no objection so far against my last suggestion to
use regmap's mmio_clk() for named ipg clk only. So you may still
consider about that.

Anyway, I'd like to do thing in parallel. So I just simply tested
it on my side and its works fine, it may still need to be tested
by others though.

Nicolin
