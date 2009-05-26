From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V5 3/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 09:09:43 -0500
Message-ID: <4A1BF827.6010409@freescale.com>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123410.17472.15251.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E93721038D1
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 16:10:04 +0200 (CEST)
In-Reply-To: <20090526123410.17472.15251.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> +static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +	int rc;
> +	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
> +
> +	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
> +	spin_event_timeout(0, 3, 0, rc);

I still think you should use udelay() here.  spin_event_timeout(<constant>) will just reduce to a udelay() call anyway.  In addition, there's no "event" that you're waiting for.

-- 
Timur Tabi
Linux kernel developer at Freescale
