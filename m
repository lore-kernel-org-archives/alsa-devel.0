From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Emulated IEC958 Card
Date: Fri, 17 Sep 2010 13:47:02 +0100
Message-ID: <20100917124702.GE4322@rakim.wolfsonmicro.main>
References: <AANLkTi=52wHCZZNSBitaMO+O6--JLHg7nmtNOVYQ6cof@mail.gmail.com>
	<AANLkTi=oECj18_gWM-16YTHrCOE-=nTnG9L0CummTdvh@mail.gmail.com>
	<20100917122724.GA29739@sirena.org.uk>
	<AANLkTim3+i3zFC=G6tZyBf_wQf9C2xy2K0SYb5jfXF=j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E70D5103952
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 14:47:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim3+i3zFC=G6tZyBf_wQf9C2xy2K0SYb5jfXF=j@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, yadi brar <yadi.brar01@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 09:42:46PM +0900, Jassi Brar wrote:
> On Fri, Sep 17, 2010 at 9:27 PM, Mark Brown

> > The idea of having a full IEC958 emulation layer that just needs a
> > generic serial port or shifter accessed through some standard interface
> > seems entirely sensible. =A0This isn't so different to what things like
> > the McBSP, PXA SSP or FSL SSI ports do.

> Yup, I knew those features but am unaware of any situation where they dri=
ve out
> IEC958 - they just run I2S, SPI, TDM (?)

Me either, I just meant that this is a well known model for structuring
this sort of hardware and software so it should be a good model to
follow.

> Also, IMO, it would make more sense to implement it as a Virtual card
> independent
> of ASoC(outside of linux/sound/soc/), with number of devices equalling
> the number
> of shifters registered.

I agree, though it would be nice to have some facility for implementing
an interface between the two since you can get IEC958 I/O on ASoC
CODECs.  I don't think that's needed at first pass, but it may come up
at some point.
