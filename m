From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Thu, 5 May 2011 09:17:59 +0100
Message-ID: <20110505081759.GD11744@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1981810393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:18:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:21:48AM -0500, Ricardo Neri wrote:

> +#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> +	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)

Why is this conditional...

>  	platform_device_register(&omap_mcbsp1);
>  	platform_device_register(&omap_mcbsp2);
>  	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {

...but this not?
