From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Thu, 11 Jun 2009 17:13:21 +0200
Message-ID: <20090611151321.GW29236@buzzloop.caiaq.de>
References: <74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<20090611090045.GA26509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E679D103851
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 17:13:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090611090045.GA26509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2009 at 10:00:45AM +0100, Mark Brown wrote:
> > Second, is enveloping needed at all? The patch you sent supports 32bits
> > frames for 2*16bits samples or 64bits frames for 2*32bits samples using
> > FSRT.
> 
> There are apparently devices that require 64fs BCLK with I2S even though
> they only handle sample sizes up to 16 bits (IIRC Daniel Mack was
> working with one). 

Exactly.

> This is pretty much TDM mode with 2 slots and only
> the first one active.

I'll try the patches you applied and see if it still works. I must admit
I lost track in this thread.

Daniel
