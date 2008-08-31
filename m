From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH] ASoC: fix pxa2xx-i2s clk_get call
Date: Sun, 31 Aug 2008 12:05:36 +0100
Message-ID: <1220180736.6499.100.camel@odin>
References: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
	<20080830215137.GA28645@sirena.org.uk>
	<bc64b4640808301452x3acec2der2a153d0218706587@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 79A1624466
	for <alsa-devel@alsa-project.org>;
	Sun, 31 Aug 2008 13:05:42 +0200 (CEST)
In-Reply-To: <bc64b4640808301452x3acec2der2a153d0218706587@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2008-08-31 at 01:52 +0400, Dmitry wrote:
> 2008/8/31 Mark Brown <broonie@sirena.org.uk>:
> > On Sun, Aug 31, 2008 at 12:45:02AM +0400, Dmitry Baryshkov wrote:
> >> pxa2xx-isa: probe actual device and use it for clk_get call
> >> thus fixing error during startup hook
> >
> > i2s, not isa.  Other than that
> >
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >
> > and IIRC Liam acked it already as well.
> >
> 
> ... and asked to repost on alsa-devel
> 

It's best to additionally post these patches to alsa-devel for Takashi
to upstream.

Liam 
