From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Correcting the config options	in
	soc/omap/Makefile
Date: Wed, 18 Nov 2009 13:47:40 +0000
Message-ID: <20091118134740.GE698@sirena.org.uk>
References: <1258547939-13450-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DDFD10395D
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 14:47:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258547939-13450-1-git-send-email-anuj.aggarwal@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2009 at 06:08:59PM +0530, Anuj Aggarwal wrote:

> -obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
> -obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
> +obj-$(CONFIG_SND_SOC_OMAP_OMAP3EVM) += snd-soc-omap3evm.o

Actually, shouldn't the OMAP3EVM one be CONFIG_SND_OMAP_SOC_OMAP3EVM?
I'll back this out for now.
