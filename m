From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Thu, 3 Jul 2008 10:30:00 -0600
Message-ID: <20080703163000.GI2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020819sdb6f442q75dc7f10f9f605a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AF2D24945
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 18:30:35 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so569765pyi.36
	for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2008 09:30:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910807020819sdb6f442q75dc7f10f9f605a5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2008 at 11:19:18AM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +               /* Due to errata in the i2s mode; need to line up enabling
> >  +                * the transmitter with a transition on the frame sync
> >  +                * line */
> >  +
> >  +               spin_lock_irqsave(&psc_i2s->lock, flags);
> >  +               /* first make sure it is low */
> >  +               while ((in_8(&regs->ipcr_acr.ipcr) & 0x80) != 0);
> 
> Could this be moved to the front of the routine, to increase parallelism?
> 
> Once you detect the 0, it will be a fixed interval before the 1
> happens. Might as well overlap the computations.
> 

Good point.  I'll try this out and see if it remains stable.  If this
gets done wrong, then left and right channels will often get swapped.

g.
