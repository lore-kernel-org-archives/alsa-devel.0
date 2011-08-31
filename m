From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx: Fix build warning of unused
	'card' variable
Date: Wed, 31 Aug 2011 09:48:25 +0100
Message-ID: <20110831084825.GE4926@opensource.wolfsonmicro.com>
References: <1314674922-1540-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC787103877
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 10:48:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314674922-1540-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2011 at 12:28:42AM -0300, Fabio Estevam wrote:
> Fixes the following warning:
> 
>   CC      sound/soc/imx/imx-pcm-fiq.o
> sound/soc/imx/imx-pcm-fiq.c: In function 'imx_pcm_fiq_new':
> sound/soc/imx/imx-pcm-fiq.c:243: warning: unused variable 'card'
>   CC      sound/soc/imx/imx-pcm-dma-mx2.o
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
