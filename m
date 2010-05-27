From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: imx-ssi.c & SND_SOC_DAIFMT_I2S
Date: Wed, 26 May 2010 21:54:39 -0400
Message-ID: <20100527015439.GA21618@opensource.wolfsonmicro.com>
References: <4BFCEB10.6000205@eukrea.com>
	<20100527005647.GC22091@sirena.org.uk>
	<4BFDC7C7.7000507@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67D8F243C2
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 03:54:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BFDC7C7.7000507@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 27, 2010 at 03:15:51AM +0200, Eric B=E9nard wrote:

> The problem on the first capture is that the SSI send the data for
> both channels on one half of the framesync's period =3D> codec outputs
> sound on only one channel.

> By setting the mode to I2S_SLAVE, the SSI send the data the way the
> codec expect it : one channel when framesync is high and one channel
> when framesync is low.

Right, this is the thing I was saying about being unable to tolerate
extra BCLKs when in I2S mode.  In general with these generic serial
ports you're much better off using one of the DSP modes, it's what they
naturally implement.

> >If I remember correctly the I2S slave mode isn't exactly I2S compliant
> >either and is actually just setting up similar settings to override
> >other registers.  I could be wrong, or this could have changed in later
> >i.MXs.

> this is what is written in the comment, but in the iMX manual (at
> least 25 & 27), there is an I2S_SLAVE mode which seems to set more
> things than what is actually done in the driver as when I enable
> this, I get a perfect sound of both channels (and recording also
> works fine).

That register is present in later i.MX CPUs too, the issue is if it
actually does what is expected robustly.
