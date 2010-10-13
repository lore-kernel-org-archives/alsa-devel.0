From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc: rename vol to volatile_register
 as appropriate
Date: Wed, 13 Oct 2010 16:11:20 +0100
Message-ID: <20101013151117.GM6424@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<1286934472.1117.129.camel@Joe-Laptop>
	<20101013082414.GD6424@rakim.wolfsonmicro.main>
	<1286971846.1117.191.camel@Joe-Laptop>
	<20101013123301.GL6424@rakim.wolfsonmicro.main>
	<1286974549.1117.254.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66B0E2441F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 17:11:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286974549.1117.254.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 05:55:48AM -0700, Joe Perches wrote:
> On Wed, 2010-10-13 at 13:33 +0100, Mark Brown wrote:

> > Are any of the contexts actually ambiguous?  I have to say I don't find
> > this useful.  If the register I/O code knows anything about volumes I'd
> > say we've probably messed up somewhere.

> Looking at the 2 register access routines where
> volatile_register/vol is used, I'd say those
> routines aren't useful at all and the checks
> should be inline instead.

If you check the code again you will notice that these functons are all
used in ops structures which presents obvious issues when trying to
replace with open coded checks.  If we remove these functions then the
core won't be able to tell if it should read registers from the hardware
or from the cache.

> This sort of wrapper routine doesn't serve
> much of a purpose to me:

>  static int wm8904_volatile_register(unsigned int reg)

I hope their usefulness is clear given the above.

> > It's used as the field name for volatility in all the
> > drivers I can remember that use a table to look volatility up in
> > register properties.

> I did a grep for vol in sound, I found the uses
> where it was for volatile and patched them.

> Are there others?  Perhaps, but I don't think so.
> Probably not in sound.  Was there some other
> subsystem you meant?  Maybe you have examples
> I missed?

You're missing the "for this" here, I believe.  To reiterate what I said
originally as far as I can remember every ASoC driver which uses a table
to look up volatility uses this naming.
