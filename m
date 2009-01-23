From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 2.6.30] ASoC: remove stand-alone mode
 support from CS4270 codec driver
Date: Fri, 23 Jan 2009 08:00:38 -0600
Message-ID: <4979CD86.3080104@freescale.com>
References: <1232670219-16780-1-git-send-email-timur@freescale.com>
	<s5hy6x2ikid.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A65C524421
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 15:01:00 +0100 (CET)
In-Reply-To: <s5hy6x2ikid.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> This "depends" doesn't work because CONFIG_SND_SOC_CS4270 is selected
> usually by others.  The reverse-selection ignores the depends of the
> target item.

I considered that, but then I saw this:

config SND_SOC_TLV320AIC23
	tristate
	depends on I2C

and

config SND_OMAP_SOC_OSK5912
	tristate "SoC Audio support for omap osk5912"
	depends on SND_OMAP_SOC && MACH_OMAP_OSK
	select SND_OMAP_SOC_MCBSP
	select SND_SOC_TLV320AIC23
	help
	  Say Y if you want to add support for SoC audio on osk5912.

So I'm just doing the same thing that the OSK5912 Kconfig is doing.

-- 
Timur Tabi
Linux kernel developer at Freescale
