From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Au12x0/Au1550 PSC Audio support.
Date: Mon, 07 Jul 2008 17:09:56 +0100
Message-ID: <1215446996.4882.191.camel@localhost.localdomain>
References: <20080703073309.GA24116@roarinelk.homelinux.net>
	<1215077359.4882.115.camel@localhost.localdomain>
	<20080703095344.GA24177@roarinelk.homelinux.net>
	<1215078947.4882.117.camel@localhost.localdomain>
	<20080703100925.GA25364@roarinelk.homelinux.net>
	<s5h1w29lm20.wl%tiwai@suse.de>
	<486E4ED9.4050106@roarinelk.homelinux.net>
	<1215193016.6440.13.camel@odin>  <s5htzf1vfwd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C344E2465B
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 18:09:57 +0200 (CEST)
In-Reply-To: <s5htzf1vfwd.wl%tiwai@suse.de>
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
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-07-07 at 18:05 +0200, Takashi Iwai wrote:
> At Fri, 04 Jul 2008 18:36:56 +0100,
> Liam Girdwood wrote:
> > 
> > On Fri, 2008-07-04 at 18:24 +0200, Manuel Lauss wrote:
> > > Hello Takashi,
> > > 
> > > Takashi Iwai wrote:
> > > > 
> > > > Shall I apply this one?  At a quick glance, the patch looks OK.
> > > 
> > > I certainly have no objections, but I intended to wait for ASoCv2 to hit
> > > mainline, convert the drivers to it, then (re)submit. There's still a lot
> > > to be done IMO (it has never been tested with preemption, i2s bitclk master
> > > mode is untested, ...)
> > > 
> > 
> > Please apply.
> > 
> > Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> > 
> > Btw, I've now started sending patches for v2 (although I seem to have
> > sent a little extra in the last patch ) ;)
> 
> Manuel's patch can't be applied cleanly to the latest ALSA tree.
> And I applied Liam's patches right now, so there must be more conflicts
> (e.g. snd_soc_cpu_dai replacement).
> 

My bad ;)

> Manuel, could you regenerate the patch against the following tree?
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


Manuel, I'll fix the Au1xx and resubmit with the DAI changes. I have
another pending change wrt DAI and will queue the Aux1xx after this.
 
Liam 
