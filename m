From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 09:41:09 +0100
Message-ID: <20090429084109.GB10541@n2100.arm.linux.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
	<20090429082152.GA2628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1008724351
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 10:41:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090429082152.GA2628@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2009 at 09:21:53AM +0100, Mark Brown wrote:
> On Wed, Apr 29, 2009 at 08:27:06AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 28, 2009 at 08:06:08PM -0300, Daniel Ribeiro wrote:
> 
> > > The SPI subsystem?
> 
> > Can the SPI system cope with the other chip being the master of the
> > interface.  In other words, can SPI sit around primed for a transfer,
> > and notify the user of SPI that new data has arrived?
> 
> > If not, the SPI subsystem is totally unsuitable for this.
> 
> It's slave only at the minute - there's holes in the API someone could
> fill in but that's not happened yet.

Well, I guess someone else will have to do that; I don't spend much time
on the LX stuff, and so if it requires any time consuming work, it won't
be worth trying to get it into mainline.
