From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: DT support for Davinci ASoC platform
Date: Thu, 5 Jul 2012 15:36:45 +0000
Message-ID: <201207051536.45920.arnd@arndb.de>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
	<4FF5733E.6000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id AA06E243DD
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 17:37:19 +0200 (CEST)
In-Reply-To: <4FF5733E.6000604@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hebbar,
	Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, Daniel Mack <zonque@gmail.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 05 July 2012, Daniel Mack wrote:
> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
> > All,
> > 
> > Are there any plans or work going on for providing Device Tree Support for Davinci
> > ASoC?
> > 
> > I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
> > task.
> 
> That's good to know. But isn't there a dependency on the EDMA engine? Is
> that part ported yet?

None of the dma engines are ported yet, because the generic binding for dma
engines is still under debate. So far, all DMA channels are described using
auxdata on platforms that use DT, with the exception of exynos, but that one
will have to change once we have the common code.

	Arnd
