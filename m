From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: do not use devres on a
 foreign device
Date: Wed, 25 Sep 2013 15:17:23 +0200
Message-ID: <1380115043.4050.2.camel@pizza.hi.pengutronix.de>
References: <1380104168-29678-1-git-send-email-p.zabel@pengutronix.de>
 <20130925121428.GA21081@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E825826546E
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 15:17:35 +0200 (CEST)
In-Reply-To: <20130925121428.GA21081@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sachin Kamat <sachin.kamat@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

Am Mittwoch, den 25.09.2013, 20:14 +0800 schrieb Shawn Guo:
> On Wed, Sep 25, 2013 at 12:16:08PM +0200, Philipp Zabel wrote:
> > Calling devm_clk_get with any device pointer other than our own confuses
> > devres. Use clk_get instead. This avoids hitting the following warning in
> > the imx-sgtl5000 error path:
> > 
[...]
> 
> This is a known issue [1].  Thanks for fixing it.
>
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Shawn

thanks, I just noticed that 01984a47e21a7d36cea0d6c0933c8173391721fc
"ASoC: imx-sgtl5000: Use devm_snd_soc_register_card" in the meantime
removed imx_sgtl5000_remove. I'll add it back again and resend the patch
rebased on top of asoc/for-next.

regards
Philipp
