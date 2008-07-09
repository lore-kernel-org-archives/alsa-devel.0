From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Au12x0/Au1550 PSC Audio support.
Date: Wed, 09 Jul 2008 15:55:51 +0100
Message-ID: <1215615351.4882.280.camel@localhost.localdomain>
References: <20080703100925.GA25364@roarinelk.homelinux.net>
	<s5h1w29lm20.wl%tiwai@suse.de>
	<486E4ED9.4050106@roarinelk.homelinux.net>
	<1215193016.6440.13.camel@odin> <s5htzf1vfwd.wl%tiwai@suse.de>
	<1215446996.4882.191.camel@localhost.localdomain>
	<20080707173812.GA29718@roarinelk.homelinux.net>
	<1215530007.4882.230.camel@localhost.localdomain>
	<20080708163637.GA5505@roarinelk.homelinux.net>
	<s5hhcazymnj.wl%tiwai@suse.de>
	<20080709142756.GA10984@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 825AB24417
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 16:55:52 +0200 (CEST)
In-Reply-To: <20080709142756.GA10984@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-09 at 16:27 +0200, Manuel Lauss wrote:
> Hi Takashi,
> 
> On Wed, Jul 09, 2008 at 07:48:00PM +0200, Takashi Iwai wrote:
> > Hi,
> > 
> > there are still some minor Kconfig issues:
> > 
> > > --- /dev/null
> > > +++ b/sound/soc/au1x/Kconfig
> > > @@ -0,0 +1,36 @@
> > > +menu "SoC Audio for the Alchemy/AMD/RMI Au1xxx"
> > > +	depends on SOC_AU1200 || SOC_AU1550
> > 
> > Avoid menu.  If really needed, use rather menuconfig.
> 
> Done. (Someone should do that for all others. It's annoying
> that the OMAP and Freescale SOC options are visible on Au1xxx).

I'll fix this.

Liam
