From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use SGTL5000_LINREG_VDDD_MASK
 instead of hardcoded mask value
Date: Fri, 21 Oct 2011 09:56:35 +0100
Message-ID: <20111021085635.GD3513@opensource.wolfsonmicro.com>
References: <1319107769.8866.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E83A5103AAB
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 10:56:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319107769.8866.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2011 at 06:49:29PM +0800, Axel Lin wrote:
> We have defined SGTL5000_LINREG_VDDD_MASK in sgtl5000.h,
> use it instead of hardcoded (0x1 << 4) - 1 for the mask.

Applied, thanks.
