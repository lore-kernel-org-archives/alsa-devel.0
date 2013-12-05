From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: Enable SYSCLK provisonally
 before fetching generated DSPCLK_DIV
Date: Thu, 5 Dec 2013 22:12:37 +0800
Message-ID: <20131205141237.GB14744@MrMyself>
References: <1386148936-15899-1-git-send-email-b42378@freescale.com>
 <20131205141421.GF23979@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E710265550
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:34:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131205141421.GF23979@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 05, 2013 at 02:14:21PM +0000, Charles Keepax wrote:
> On Wed, Dec 04, 2013 at 05:22:16PM +0800, Nicolin Chen wrote:
> > DSPCLK_DIV can be only generated correctly after enabling SYSCLK. But if the
> > current bias_level hasn't reached SND_SOC_BIAS_ON, DAPM won't enable SYSCLK,
> > which would cause the calculation result from DSPCLK_DIV invalid since bit
> > DSPCLK_DIV will be finally turned to its true value after DAPM enables SYSCLK
> > while the driver won't calculate it again for the current instance. In this
> > circumstance, a playback which needs non-zero DSPCLK_DIV would be distorted
> > due to unexpected clock frequency resulted from an invalid DSPCLK_DIV value.
> > 
> > So this patch provisionally enables the SYSCLK to get a valid DSPCLK_DIV for
> > calculation and then disables it afterward.
> 
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> It feels like there should be a neater way to handle this, but I
> can't really see what that might be right now. So I think this
> looks fine for now and hopefully I can find some time to look at
> it in more detail soon.

Thanks Charles,

And I was preparing a patch for SSI and met a similar problem, after a few
reconsideration, I'm wondering if it's better to save the value of SYSCLK_ENA
and apply it after getting DSPCLK_DIV.

By doing this we can no more reply on bias_level, which looks more safer.

Best regards,
Nicolin Chen
