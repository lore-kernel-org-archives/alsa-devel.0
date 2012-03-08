From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 09/17] ASoC: fsl: separate SSI and DMA
	Kconfig options
Date: Thu, 8 Mar 2012 21:08:35 +0800
Message-ID: <20120308130832.GD2499@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
	<4F57C30D.3000101@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2122810BAA2
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:08:51 +0100 (CET)
Received: by iakh37 with SMTP id h37so810906iak.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 05:08:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F57C30D.3000101@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 07, 2012 at 02:20:29PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > The fsl_ssi driver will possibly be shared between Freescale PowerPC
> > and ARM/IMX families, so give it a separate Kconfig option.  Then
> > fsl_ssi driver can possibly be selected independently from selecting
> > PowerPC DMA based PCM driver.
> 
> This patch is going to require an update to the defconfigs, because by
> default, it sets audio as disabled.
> 
I guess you meant the next patch (#10) require an update, since
SND_POWERPC_SOC is introduced in that patch.

Regards,
Shawn

> menuconfig SND_POWERPC_SOC
> 	tristate "SoC Audio for Freescale PowerPC CPUs"
> 	depends on FSL_SOC
> 	help
> 	  Say Y or M if you want to add support for codecs attached to
> 	  the PowerPC CPUs.
> 
> The P1022DS uses mpc85xx_smp_defconfig and mpc85xx_defconfig.  The
> MPC8610HPCD uses mpc8610_hpcd_defconfig.
