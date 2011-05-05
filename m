From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/6] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Thu, 05 May 2011 14:24:11 -0500
Message-ID: <1304623451.1900.32.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
	<20110505081759.GD11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F384243B7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 21:24:05 +0200 (CEST)
In-Reply-To: <20110505081759.GD11744@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your comments!

Am Donnerstag, den 05.05.2011, 03:17 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:21:48AM -0500, Ricardo Neri wrote:
> 
> > +#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> > +	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> 
> Why is this conditional...
> 
> >  	platform_device_register(&omap_mcbsp1);
> >  	platform_device_register(&omap_mcbsp2);
> >  	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> 
> ...but this not?
The device is specific to OMAP4. I added the #if because I think the
device should be built only if HDMI audio option is selected. Also, the
rest of the devices are conditionally built with CONFIG_SND_SOC option.
Do you think I should use cpu_is_omap44xx() instead? In that case, the
hdmi-audio-dai will be built even if HDMI audio option is not selected.
