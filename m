From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8962: Enable SYSCLK provisonally
	before	fetching generated DSPCLK_DIV
Date: Thu, 5 Dec 2013 14:14:21 +0000
Message-ID: <20131205141421.GF23979@opensource.wolfsonmicro.com>
References: <1386148936-15899-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3352D261A78
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:21:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1386148936-15899-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 04, 2013 at 05:22:16PM +0800, Nicolin Chen wrote:
> DSPCLK_DIV can be only generated correctly after enabling SYSCLK. But if the
> current bias_level hasn't reached SND_SOC_BIAS_ON, DAPM won't enable SYSCLK,
> which would cause the calculation result from DSPCLK_DIV invalid since bit
> DSPCLK_DIV will be finally turned to its true value after DAPM enables SYSCLK
> while the driver won't calculate it again for the current instance. In this
> circumstance, a playback which needs non-zero DSPCLK_DIV would be distorted
> due to unexpected clock frequency resulted from an invalid DSPCLK_DIV value.
> 
> So this patch provisionally enables the SYSCLK to get a valid DSPCLK_DIV for
> calculation and then disables it afterward.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

It feels like there should be a neater way to handle this, but I
can't really see what that might be right now. So I think this
looks fine for now and hopefully I can find some time to look at
it in more detail soon.

Thanks,
Charles
