From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2.6.30] ASoC: remove stand-alone
	mode	support from CS4270 codec driver
Date: Fri, 23 Jan 2009 14:02:51 +0000
Message-ID: <20090123140250.GA32689@rakim.wolfsonmicro.main>
References: <1232670219-16780-1-git-send-email-timur@freescale.com>
	<s5hy6x2ikid.wl%tiwai@suse.de> <4979CD86.3080104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1200E24425
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 15:02:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4979CD86.3080104@freescale.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2009 at 08:00:38AM -0600, Timur Tabi wrote:

> I considered that, but then I saw this:

> config SND_SOC_TLV320AIC23
> 	tristate
> 	depends on I2C

> config SND_OMAP_SOC_OSK5912
> 	tristate "SoC Audio support for omap osk5912"
> 	depends on SND_OMAP_SOC && MACH_OMAP_OSK
> 	select SND_OMAP_SOC_MCBSP
> 	select SND_SOC_TLV320AIC23
> 	help
> 	  Say Y if you want to add support for SoC audio on osk5912.

> So I'm just doing the same thing that the OSK5912 Kconfig is doing.

That's broken too, will fix.
