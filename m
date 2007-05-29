From: Timur Tabi <timur@freescale.com>
Subject: Re: Question on snd_soc_dai_link
Date: Tue, 29 May 2007 09:36:03 -0500
Message-ID: <465C3A53.10902@freescale.com>
References: <46575B3E.2020603@freescale.com>	
	<1180354777.5816.39.camel@a10072.wolfsonmicro.main>	
	<465B83B4.4000801@freescale.com>
	<1180448356.5816.145.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 07A2D24392
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 16:34:39 +0200 (CEST)
In-Reply-To: <1180448356.5816.145.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> This maps the WM8731 codec to an imaginary PowerPC 5200 based machine
> using PSC3 for I2S audio. It would be preferable to only probe the
> parent device and not the children, although I'm not sure if this is
> possible using this model. ASoC works on other SoC by being a platform
> device.

Yeah, getting a cross-platform driver to work on PowerPC and non-PowerPC architectures is ... difficult.

> 
> Please let me know if I'm way off here. The device tree looks like an
> elegant solution for machine initialisation/description.

I'm going to study this and run it by others in my department (we handle all the Linux architectural issues for Freescale SOCs).  I can tell you that you're very close, but it will require some tweaks.  Off the top of my head, I see a few problems:

1) The I2C addresses are specified in a separate I2C node
2) I don't know much about the 5200, but on my part, the DMA operations are provided by the I2S device.  We don't use the generic DMA engine.
3) The register mapping for the I2S device normally occurs inside the SOC node, not here.  We'd probably need to use some kind of cross-link to represent that.
