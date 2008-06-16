From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 16:45:31 +0100
Message-ID: <20080616154529.GA8544@sirena.org.uk>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<48568873.3040906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C5CBC24395
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:45:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48568873.3040906@freescale.com>
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

On Mon, Jun 16, 2008 at 10:36:19AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > OOI, I guess that if there were some visible control on the board (eg, a
> > few controls via GPIO) then this would be less of an issue since there
> > would be real hardware for the machine/fabric driver to control?

> Probably not, because the GPIO node in the device tree would be owned by the
> GPIO driver.  I don't think there's a way to have the fabric driver probed from
> the device tree.  It could be probed manually from the arch/powerpc platform driver.

But wouldn't it now be legal to represent the machine driver as a device
in its own right, even if it is connected via GPIOs?
