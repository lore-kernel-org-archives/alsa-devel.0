From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/4] ASoC: Add a new imx-ssi sound driver
Date: Mon, 11 Jan 2010 08:33:08 +0100
Message-ID: <eedb5541001102333lc865ef7jd40bee92af1da4cc@mail.gmail.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F1B824451
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 08:33:08 +0100 (CET)
Received: by ewy23 with SMTP id 23so8427558ewy.4
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 23:33:08 -0800 (PST)
In-Reply-To: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

2010/1/8 Mark Brown <broonie@opensource.wolfsonmicro.com>

> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> The old driver has the number of SSI units in the system hardcoded,
> does not make use of the device model and works only on i.MX21/27.
>
> This driver replaces it. It works in DMA mode on i.MX21/27 and using
> an FIQ handler on other systems. It also supports AC97 mode of
> the SSI units.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/plat-mxc/Makefile       |    6 +
>  arch/arm/plat-mxc/ssi-fiq-ksym.c |   20 +
>  arch/arm/plat-mxc/ssi-fiq.S      |  134 +++++++
>  sound/soc/imx/Kconfig            |   20 +-
>  sound/soc/imx/Makefile           |   12 +-
>  sound/soc/imx/imx-pcm-dma-mx2.c  |  313 ++++++++++++++++
>  sound/soc/imx/imx-pcm-fiq.c      |  277 ++++++++++++++
>  sound/soc/imx/imx-ssi.c          |  762
> ++++++++++++++++++++++++++++++++++++++
>  sound/soc/imx/imx-ssi.h          |  238 ++++++++++++
>  9 files changed, 1762 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/ssi-fiq-ksym.c
>  create mode 100644 arch/arm/plat-mxc/ssi-fiq.S
>  create mode 100644 sound/soc/imx/imx-pcm-dma-mx2.c
>  create mode 100644 sound/soc/imx/imx-pcm-fiq.c
>  create mode 100644 sound/soc/imx/imx-ssi.c
>  create mode 100644 sound/soc/imx/imx-ssi.h
>
>
Acked-by: Javier Martin <javier.martin@vista-silicon.com<lrg@slimlogic.co.uk>
>

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
