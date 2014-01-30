From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: fsl: imx-sgtl5000: Use
	devm_clk_get
Date: Thu, 30 Jan 2014 11:42:15 +0100
Message-ID: <1391078535.4921.5.camel@pizza.hi.pengutronix.de>
References: <1391075238-20292-1-git-send-email-p.zabel@pengutronix.de>
 <1391075238-20292-2-git-send-email-p.zabel@pengutronix.de>
 <20140130102539.GB5189@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CC6B626534C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 11:42:18 +0100 (CET)
In-Reply-To: <20140130102539.GB5189@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

Am Donnerstag, den 30.01.2014, 18:25 +0800 schrieb Nicolin Chen:
> Hi Philipp,
> 
> On Thu, Jan 30, 2014 at 10:47:18AM +0100, Philipp Zabel wrote:
> > Use managed devm_clk_get. There is no need to manually
> > call clk_put anymore.
> 
> http://comments.gmane.org/gmane.linux.alsa.devel/109093
> Fabio and Shawn have discussed this before.

thanks, I got it the wrong way around. Instead I'll have to replace the
devm_clk_get in the ssm2603 with clk_get/put.

regards
Philipp
