From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Thu, 1 Jul 2010 21:01:51 +0100
Message-ID: <20100701200150.GG17698@sirena.org.uk>
References: <1277407467.3100.579.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0072432C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 22:01:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277407467.3100.579.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 24, 2010 at 08:24:27PM +0100, Liam Girdwood wrote:
> ASoC is now coming up to it's 5th birthday and is beginning to show it's
> age a little when it comes to supporting the next generation of smart
> phones and multimedia devices with it's current single CODEC and single
> DMA platform design.

I've done a bit of very light testing here.

One issue I noticed is that most existing platforms don't have a driver
registered for the DMA yet and the devices aren't being added when the
driver is.  I'm thinking that this could be fixed by adding registration
of the devices in the driver files where the device is being added for
the first time - we can then transition the registrations into the arch
code properly later without having to block the merge.  Does that sound
sane to you?

Other than that I don't think I noticed anything that hasn't previously
been reported.
