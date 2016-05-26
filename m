From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH v3 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Thu, 26 May 2016 17:34:08 -0500
Message-ID: <alpine.DEB.2.10.1605261720060.16316@phandrigan>
References: <1463172629-559-1-git-send-email-Paul.Handrigan@cirrus.com>
 <20160513222848.GW22038@sirena.org.uk>
 <alpine.DEB.2.10.1605161013100.5521@phandrigan>
 <20160516170614.GA8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D989266504
 for <alsa-devel@alsa-project.org>; Fri, 27 May 2016 00:33:05 +0200 (CEST)
In-Reply-To: <20160516170614.GA8104@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul Handrigan <paul.handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 16 May 2016, Mark Brown wrote:

> On Mon, May 16, 2016 at 10:20:24AM -0500, Paul Handrigan wrote:
> > On Fri, 13 May 2016, Mark Brown wrote:
> > > On Fri, May 13, 2016 at 03:50:28PM -0500, Paul.Handrigan@cirrus.com wrote:
> 
> > > > +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
> > > > +		/* ack the irq by reading both status registers */
> 
> > > Why do we need this...?
> 
> > The we need to keep handling the unmasked interrupts until they are
> > all cleared.  We could get another interrupt while handling the first
> > triggered interrupt, but the interrupt line could be de-asserted due to
> > the read-to-clear nature of the interrupt status registers.
> 
> This doesn't follow?  Clear to read shouldn't be affected by reading
> repeatedly, or at least I don't see that helps any problems in a
> non-racy fashion, and the interrupt subsystem will happily call the
> handler again if the interrupt reasserts during handling so new
> interrupts shouldn't be an issue either.  New interrupts are an issue
> for most devices so we really ought to have handling for that in the
> interrupt subsystem if it's needed, or possibly the usage of the
> subsystem needs to change to take advantage of preexisting handling...
> 

After taking a closer look at it, it would make sence to remove the for 
loop.  We will still need to attempt clear the unmasked interrupt status
bits since it may take a few reads to clear those bits.
