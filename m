From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 09/17] ASoC: fsl: separate SSI and DMA
	Kconfig options
Date: Wed, 7 Mar 2012 14:20:29 -0600
Message-ID: <4F57C30D.3000101@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe002.messaging.microsoft.com [213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 10B6810B966
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 21:20:45 +0100 (CET)
In-Reply-To: <1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> The fsl_ssi driver will possibly be shared between Freescale PowerPC
> and ARM/IMX families, so give it a separate Kconfig option.  Then
> fsl_ssi driver can possibly be selected independently from selecting
> PowerPC DMA based PCM driver.

This patch is going to require an update to the defconfigs, because by
default, it sets audio as disabled.

menuconfig SND_POWERPC_SOC
	tristate "SoC Audio for Freescale PowerPC CPUs"
	depends on FSL_SOC
	help
	  Say Y or M if you want to add support for codecs attached to
	  the PowerPC CPUs.

The P1022DS uses mpc85xx_smp_defconfig and mpc85xx_defconfig.  The
MPC8610HPCD uses mpc8610_hpcd_defconfig.

-- 
Timur Tabi
Linux kernel developer at Freescale
