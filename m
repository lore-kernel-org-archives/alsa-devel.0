From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: DMA Platform driver for i.mx27
Date: Wed, 15 Apr 2009 10:43:01 +0100
Message-ID: <20090415094301.GC29399@sirena.org.uk>
References: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
	<20090414204243.GB6902@sirena.org.uk>
	<eedb5540904150210y68f08597p9f6c032ca17faa27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BEE024442
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 11:43:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540904150210y68f08597p9f6c032ca17faa27@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 11:10:43AM +0200, javier Martin wrote:
> 2009/4/14 Mark Brown <broonie@sirena.org.uk>

> > Replace this with use of the standard pr_dbg() macro.

> Do you mean that I must do:

> Or that I must use a pr_dbg macro defined elsewhere (I don't find it)?

pr_dbg() is defined in some standard kernel header that gets included
everywhere - you shouldn't need to define it yourself.

> Yes, you are right. I was aware of this issue. But current dai "imx-ssi.c"
> only exports dma data for the SDMA API used in i.mx31. So I provisionally
> use this trick untill I fix that in the SSI.

That's fine for development.

> > This will free both TX and RX DMA channels but you only allocated one of
> > them when the device is opened.

> Man, I missed that, thanks.
> Do you think this could be related to the problem of not being able of
> having both directions working properly?

If things are going wrong when you free a stream - if it's at other
times it's less likely.
