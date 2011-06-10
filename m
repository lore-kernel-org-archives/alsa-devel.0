From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH 2/3] ASoC: Blackfin:
 Add bf5xx-adau1701 machine driver
Date: Fri, 10 Jun 2011 19:01:38 +0100
Message-ID: <20110610180137.GP26436@opensource.wolfsonmicro.com>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<1307726331-28618-2-git-send-email-lars@metafoo.de>
	<20110610173004.GJ26441@sirena.org.uk>
	<BANLkTimBJbkYJnU5vgmo+a5eerRroE1uBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66CE7103D14
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:01:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimBJbkYJnU5vgmo+a5eerRroE1uBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 01:47:34PM -0400, Mike Frysinger wrote:
> On Fri, Jun 10, 2011 at 13:30, Mark Brown wrote:

> > So, I keep on complaining about the way these drivers are just generic
> > to any random Blackfin plus CODEC combination rather than being board
> > specific. =A0It'd be good if we could improve this, even adding somethi=
ng
> > into the driver name to make it clear these are for the EVB would help.

> i know you keep complaining, but i honestly dont understand why this
> is undesirable.  connecting a codec to a Blackfin is pretty much
> always the same.  you pick a SPORT # and that's about it.

Only if you're looking at very basic boards - as soon as you start
adding any external components on the boards like speaker amps, start
handling jacks (with detection or without) or start dealing with more
flexible CODEC devices with a wider range of connection possibilities
the number of possibilities expands dramatically.

> the spi cs and i2c address could differ (so maybe make that a field
> for the platform resources), but otherwise i dont see why people
> should have to copy & paste the same code to change all of 4 bytes.

Reusing code where there's similiarities is fine - Tegra is doing that
for WM8903 based systems in a fairly tasteful fashion - but that's not
really what this stuff feels like it is doing.  For example, the SPORT
selection and reset GPIO selection should be platform data not Kconfig
options and drivers that explicitly say they're for a particular board
in Kconfig should probably say so in code also.
