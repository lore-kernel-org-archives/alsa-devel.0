From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 33/34] ARM: imx: remove header file
	mach/irqs.h
Date: Mon, 17 Sep 2012 07:46:40 -0400
Message-ID: <20120917114640.GH5401@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD3EC26506D
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 13:46:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 17, 2012 at 01:35:02PM +0800, Shawn Guo wrote:
> The only mach/irqs.h user outside arch/arm/mach-imx is
> sound/soc/fsl/imx-pcm-fiq.c, which refers to mxc_set_irq_fiq().
> Though moving the declaration into imx-pcm-fiq.c will result in
> the checkpatch below, let's do it to gain the multi-platform support
> for mach-imx.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
