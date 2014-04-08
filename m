From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix Bit Clock Polarity configurations
Date: Tue, 8 Apr 2014 19:07:40 +0800
Message-ID: <20140408110738.GA10745@MrMyself>
References: <1396595387-4371-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140404100532.GN14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140404100532.GN14763@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 04, 2014 at 11:05:32AM +0100, Mark Brown wrote:
> On Fri, Apr 04, 2014 at 03:09:47PM +0800, Nicolin Chen wrote:
> > The BCP bit in TCR4/RCR4 register rules as followings:
> >   0 Bit clock is active high with drive outputs on rising edge
> >     and sample inputs on falling edge.
> >   1 Bit clock is active low with drive outputs on falling edge
> >     and sample inputs on rising edge.
> 
> Applied, thanks.

Sir, I can't find this patch on any of the remote branches: for-next,
topic/fsl-sai and fix/fsl-sai. Where could I find it?

Thank you,
Nicolin
