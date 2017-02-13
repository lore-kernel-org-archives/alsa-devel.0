From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk
 to the binding document for zx2967 family
Date: Mon, 13 Feb 2017 21:05:36 +0800
Message-ID: <20170213130534.GA4151@dragon>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
 <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB54266615
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 14:05:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, shawn.guo@linaro.org, mathieu.poirier@linaro.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, chen.chaokai@zte.com.cn, xie.baoyou@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, Baoyou Xie <baoyou.xie@linaro.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 09, 2017 at 04:46:45PM +0000, Mark Brown wrote:
> On Thu, Feb 09, 2017 at 11:12:57AM +0800, Baoyou Xie wrote:
> 
> > - - compatible : Must be "zte,zx296702-i2s"
> > + - compatible : Must be one of:
> > +	"zte,zx296718-i2s", "zte,zx296702-i2s"
> > +	"zte,zx296702-i2s"
> 
> You've added the new compatible twice here?

It's indeed a bit confusing.  Might be better if we add a couple of
bullet like below.

 - compatible : Must be one of:
	- "zte,zx296718-i2s", "zte,zx296702-i2s";
	- "zte,zx296702-i2s";

In this case, it's more easier for readers to understand that the first
one is for I2S device on SoC ZX296718, while it's compatible with the
I2S on ZX296702.

Shawn
