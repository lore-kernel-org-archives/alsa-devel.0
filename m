From: Richard Zhao <richard.zhao@linaro.org>
Subject: Re: [PATCH v2 8/9] ASoC: imx: add dt support for audmux-v2
Date: Thu, 2 Feb 2012 22:02:15 +0800
Message-ID: <20120202140212.GC3015@richard-laptop>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
 <20120202121020.GD7428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120202121020.GD7428@opensource.wolfsonmicro.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, kernel@pengutronix.de, eric.miao@linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 02, 2012 at 12:10:20PM +0000, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 10:12:07AM +0800, Richard Zhao wrote:
> 
> > +Required properties:
> > +- compatible : "fsl,imx31-audmux".
> > +
> > +Example:
> > +
> > +audmux@021d8000 {
> > +	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
> > +	reg = <0x021d8000 0x4000>;
> 
> It's kind of obvious what it is but you should really document the reg
> property for completeness.
Right.

Thanks
Richard

