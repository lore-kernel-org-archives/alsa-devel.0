From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SH7760 ASoC support
Date: Thu, 10 May 2007 14:31:52 +0100
Message-ID: <1178803912.10518.90.camel@a10072.wolfsonmicro.main>
References: <20070510120833.GA9539@roarinelk.homelinux.net>
	<20070510125817.GC18534@linux-sh.org>
	<20070510130739.GA9903@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BF842438F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:31:54 +0200 (CEST)
In-Reply-To: <20070510130739.GA9903@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>, Paul Mundt <lethal@linux-sh.org>
Cc: alsa-devel@alsa-project.org, linuxsh-dev@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-10 at 15:07 +0200, Manuel Lauss wrote:
> On Thu, May 10, 2007 at 09:58:17PM +0900, Paul Mundt wrote:
> > On Thu, May 10, 2007 at 02:08:33PM +0200, Manuel Lauss wrote:
> > > +##
> > > +## Audio unit modules
> > > +##
> > > +
> > > +config SND_SOC_SH4_HAC
> > > +	select AC97_BUS
> > > +	select SND_SOC_AC97_BUS
> > > +	select SND_AC97_CODEC
> > > +	tristate
> > > +
> > > +config SND_SOC_SH4_SSI
> > > +	tristate
> > > +
> > This might seem like a silly question, but how are these two supposed to
> > be enabled? At the very least you should have some dependencies on the
> > CPU subtypes that support these blocks.
> > 
> > > +
> > > +
> > > +##
> > > +## Boards
> > > +##
> > > +
> > Or are you expecting that the board-specific code will simply select
> > these?
> 
> That was the idea; the other ASoC boards do similar things.

Fwiw, the board or machine driver (when selected) currently selects it's
audio interface driver and DMA driver. The board/machine driver does
however depend on the selected MACH_MACHINE (e.g. MACH_POODLE for Sharp
Poodle) so it only exposes a single y,m,n Kconfig selection for audio as
it's completely platform specific.

The ASoC git tree dev branch does the opposite, as everything can be
selected for quicker build/debug.

Liam
