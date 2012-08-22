From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp
 header into platform and audio specific
Date: Wed, 22 Aug 2012 07:06:17 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA64A1D@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
 <502E89D8.2090304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 7289E265005
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 09:06:26 +0200 (CEST)
In-Reply-To: <502E89D8.2090304@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 17, 2012 at 23:43:44, Nori, Sekhar wrote:
> Hi Gururaja,
> 
> On 8/14/2012 6:12 PM, Hebbar, Gururaja wrote:
> > Davinci McASP header & driver are shared by few OMAP platforms (like
> > TI81xx, AM335x). Splitting asp header into Davinci platform specific
> > header and Audio specific header helps to share them across platforms.
> > 
> > Audio specific defines is moved to to common
> > <linux/platform_data/davinci_asp.h> so that the header can be
> > accessed by all related platforms.
> > 
> > While here, correct the header usage (remove multiple header
> > re-definitions and unused headers) and remove platform names from
> > structures comments and enum
> > 
> > Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> This patch looks good to me. See a minor nit below.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> > diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
> > new file mode 100644
> > index 0000000..8fd5238
> > --- /dev/null
> > +++ b/arch/arm/mach-davinci/asp.h
> > @@ -0,0 +1,49 @@
> > +/*
> > + * TI DaVinci Audio definitions
> > + */
> > +#ifndef __ASM_ARCH_DAVINCI_ASP_H
> > +#define __ASM_ARCH_DAVINCI_ASP_H
> > +
> > +/* Bases of dm644x and dm355 register banks */
> > +#define DAVINCI_ASP0_BASE	0x01E02000
> > +#define DAVINCI_ASP1_BASE	0x01E04000
> > +
> > +/* Bases of dm365 register banks */
> > +#define DAVINCI_DM365_ASP0_BASE	0x01D02000
> > +
> > +/* Bases of dm646x register banks */
> > +#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
> > +#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
> 
> Can you remove usage of tabs after 'define'. I understand this is coming
> from existing code.

Ok. I have got few more comments from Mark. Will add this into it.

> 
> Thanks,
> Sekhar
> 


Regards, 
Gururaja
