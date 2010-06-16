From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver [File 1/3]
Date: Wed, 16 Jun 2010 10:35:15 +0100
Message-ID: <20100616093514.GO14510@rakim.wolfsonmicro.main>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002913.GC7759@www.longlandclan.yi.org>
	<20100615142050.GH14510@rakim.wolfsonmicro.main>
	<20100615224622.GI7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A11852413F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 11:35:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100615224622.GI7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 16, 2010 at 08:46:23AM +1000, Stuart Longland wrote:
> On Tue, Jun 15, 2010 at 03:20:50PM +0100, Mark Brown wrote:

> > scripts/checkpatch.pl is your friend.

> I take it this checks for coding style?  I'll have a look.

Coding style and other things - anything that's amenable to automatic
checking.

> Yep, will get rid of it then.  I wasn't quite sure what it was doing, or
> what was needed.  I'm undecided as to whether I should use this to power
> the PLL down, or whether that'd be better done elsewhere.

The PLL can probably be handled as a supply to other components.

> I'm giving some thought to handling the bit and word clocks -- and think
> since this is related, we can do something about the PLL in the same
> place.

If you need to explicitly control them either the hw_params or using a
supply for the DAC/ADC might work.

> > > #else
> > > static inline void aic3204_i2c_init(void) { }
> > > static inline void aic3204_i2c_exit(void) { }
> > > #endif

> > Not needed unless you have multiple buses.

> The TLV320AIC3204 is a dual I=B2C/SPI device, if you tie one of its pins
> to Vdd, it runs I=B2C, if you tie that pin to Vss, it runs SPI.

I'd be tempted to skip the ifdefs until SPI is actually implemented
since the driver is useless otherwise.
