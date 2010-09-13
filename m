From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Binding multiple registers to an enum
Date: Mon, 13 Sep 2010 09:43:07 +0100
Message-ID: <20100913084307.GC16606@rakim.wolfsonmicro.main>
References: <20100912233151.GU14056@atomos.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5CEA245E1
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 10:43:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100912233151.GU14056@atomos.longlandclan.yi.org>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2010 at 09:31:51AM +1000, Stuart Longland wrote:

> I've tried lying to DAPM and telling it these bits control PGAs on the
> inputs themselves... but it gets the wrong idea about which ones need to
> be turned on.  Perhaps I should investigate that ... but the idea of
> using PGA controls doesn't seem quite right.

It would be helpful if you could be a bit more specific about what the
registers look like and what the problems you are encountering are.
Since what you're saying is so generic and non-specific it's hard to
really say anything concrete.  Possibly what you want to do is have an
event on the widgets for the mixers which does the appropriate setup?

> I've looked at SOC_ENUM_EXT, which would do what I want (I already use
> this to keep ADC OSR and DAC OSR settings in sync) however, these
> controls have implications for signal routing, and therefore DAPM needs
> to know about them, so really it'd be a SOC_DAPM_ENUM_EXT control I'd be
> after.  I can't see such a thing however... how does one go about doing
> this?

The easiest thing is to look at the git logs and see how similar things
were added then do the equivalent thing.  That'll show all the areas
that need updating.
