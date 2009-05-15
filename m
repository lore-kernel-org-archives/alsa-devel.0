From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Sat, 16 May 2009 00:12:02 +0900 (JST)
Message-ID: <20090516.001202.173372394.anemo@mba.ocn.ne.jp>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20090514185945.GO28291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id E143A103991
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 17:12:06 +0200 (CEST)
In-Reply-To: <20090514185945.GO28291@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 May 2009 19:59:46 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> This all looks basically fine - just a few comments below, the main one
> being the way you're registering things.

Thank you for quick review!

> > +#define txx9aclc_ac97_suspend	NULL
> > +#define txx9aclc_ac97_resume	NULL
> > +#endif
> 
> Just remove all this if there's no implementation.

OK.  I will do.

> Ideally you'd be registering a platform device in your arch code and
> then the DAI would only be registered when the device is probed.  This
> (and similar stuff for the DMA) would mean that...
...
> ...all this resource stuff wouldn't need to be done by the machine
> driver, it'd be done by your DAI and DMA drivers.  That means less
> duplication of code for multiple machines both in the machine driver and
> in registering the resources along with the platform device.

OK, then I will move irq/mem resource stuff to the DAI driver and dma
resource stuff to the DMA driver.

I placed them in the machine driver because both DAI and DMA drivers
need the mem resource.  I can move the mem resource stuff into the DAI
driver since the DAI driver will be probed before the DMA driver.

OTOH, I want to keep arch code as is.  There are some TXx9 SoC
variations and they can have different baseaddr/irq/dma.  I want to
leave these details in arch code and make ASoC drivers generic as
possible.

---
Atsushi Nemoto
