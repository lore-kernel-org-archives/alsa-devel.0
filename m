From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 08:27:06 +0100
Message-ID: <20090429072706.GA31566@n2100.arm.linux.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id E5439244FE
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 09:27:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1240959968.30410.1.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 08:06:08PM -0300, Daniel Ribeiro wrote:
> Em Ter, 2009-04-28 =E0s 23:20 +0100, Russell King - ARM Linux escreveu:
> > On Thu, Apr 23, 2009 at 01:06:12PM +0800, Eric Miao wrote:
> > > Actually, due to the number of possible SSP configurations, it's quit=
e a
> > > difficult job to maintain an API that can be well re-used. The guidel=
ine
> > > here is to keep only a list of SSP devices and their basic informatio=
n,
> > > and it's up to the user driver (like SPI or Audio SSP) to configure t=
he
> > > SSP in a desired way.
> > =

> > Hmm, the LX battery driver uses this API for its rudimentary battery
> > communication channel with the PCON.
> > =

> > What are you suggesting as the replacement API?  Direct register access?
> =

> The SPI subsystem?

Can the SPI system cope with the other chip being the master of the
interface.  In other words, can SPI sit around primed for a transfer,
and notify the user of SPI that new data has arrived?

If not, the SPI subsystem is totally unsuitable for this.
