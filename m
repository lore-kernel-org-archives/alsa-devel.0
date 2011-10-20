From: David Jander <david.jander@protonic.nl>
Subject: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 12:23:17 +0200
Message-ID: <20111020122317.6c705289@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 988B524730
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 12:23:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jon Smirl <jonsmirl@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


Hi all,

I am writing a AC97 ASoC driver for the MPC5121e SoC from Freescale. This SoC
has almost the same PSC (Programmable Serial Controllers) as the MPC5200B, for
which there already is an AC97 driver: sound/soc/fsl/mpc5200-ac97.c, so I'd
like to extend that one to also support the MPC5121e.
This driver is supposed to work together with a second part, implementing the
actual PCM driver: sound/soc/fsl/mpc5200_dma.c.
Both drivers register themselves via platform_driver_register() in a regular
module init function.
The problem is, they do share the same driver data struct!
So psc_ac97_of_probe() starts off calling 

	psc_dma = dev_get_drvdata(&op->dev);

right ahead and accessing it without checking. The DMA part of the driver does
indeed create this struct psc_dma and calls dev_set_drvdata() on it at the end
of the probe function. So obviously, it is supposed that the DMA driver
somehow gets probed before the PSC driver, but I can't see where this is
enforced. AFAIK, the order is fairly random, so it could be the other way
around.... and indeed, in my case it is.
Unfortunately I don't have MPC5200 hardware with AC97 to test this out, but
only a MPC5121e based board. If I mimic this on the MPC5121e, it won't work,
because the PSC driver gets probed first and obviously crashes with a
NULL-pointer dereference in the next line of code!

If this is supposed to be broken, I'd like to fix it of course, but:

1.- I can't test it on a MPC5200B, so therefor I need help.
2.- Simply turning the dev_get/set_drvdata and chip initialization order
around does work in my case, but doesn't seem a robust solution to me. Any
idea how this should be handled?

Best regards,

-- 
David Jander
Protonic Holland.
