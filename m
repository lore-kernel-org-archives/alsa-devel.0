From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for
	imx-pcm-fiq
Date: Sun, 14 Apr 2013 09:53:57 -0500
Message-ID: <516AC305.2000800@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id 50A8F2615F5
 for <alsa-devel@alsa-project.org>; Sun, 14 Apr 2013 16:54:00 +0200 (CEST)
In-Reply-To: <20130414141015.GC27394@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> In general, imx27 does support SSI with DMA, for example
> MACH_IMX27_VISSTRIM_M10 does use SSI with DMA. But there are special
> boards like Eukrea TLV320 and phycore-ac97 that have to use FIQ instead.
> All of them have a imx27 chip.

Why is the decision to use FIQ board-specific?  All of the hardware is 
inside the SoC itself.  How could a board make using DMA impossible?

-- 
Timur Tabi
