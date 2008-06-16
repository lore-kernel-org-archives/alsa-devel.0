From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 18:03:26 +0100
Message-ID: <20080616170325.GD8544@sirena.org.uk>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<48568873.3040906@freescale.com>
	<20080616154529.GA8544@sirena.org.uk>
	<48568B87.2000408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E44A0243ED
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 19:03:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48568B87.2000408@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2008 at 10:49:27AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > But wouldn't it now be legal to represent the machine driver as a device
> > in its own right, even if it is connected via GPIOs?

> I'm not sure I understand that, so let me say this:

> When a driver wants to be probed, it creates a list that describes the kind of
> nodes it wants to be probed on.  Typically, the list includes the contents of
> the "compatible" property.  The kernel then scans the device tree, and calls the
> driver for each matching node.

Right, but you could not then idiomatically have a device tree entry
saying something to the effect of "This board has a Frobnitz 2000 with
control line 1 connected to GPIO4 and control line 2 connected to GPIO5"
which would register the presence of this other device (in the same way
as you have an entry for an I2C device)?
