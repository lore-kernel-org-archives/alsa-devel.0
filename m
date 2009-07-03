From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix wm8753 register cache size and
	initialization
Date: Fri, 3 Jul 2009 11:35:18 +0100
Message-ID: <20090703103517.GE29130@rakim.wolfsonmicro.main>
References: <1246574768-11447-1-git-send-email-lars@metafoo.de>
	<20090703093250.GA29130@rakim.wolfsonmicro.main>
	<4A4DDA51.3070401@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5053F2480D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 12:35:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A4DDA51.3070401@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2009 at 12:15:45PM +0200, Lars-Peter Clausen wrote:
> Mark Brown wrote:

> >Only 62 of the registers are cached - please see the register cache
> >access code.

> Yes. Thats the problem. The register cache holds place for 62
> elements where as there are 63 register which should be cached.
> In the register cache access code you subtract one from the
> registers index to get it's index in the register cache array, so
> the last register has the index 62. Which means it is the 63th
> element of the array and thus the array has to consist of 63
> elements.

OK, that makes sense.  I will apply your patch with a rewritten commit
message which explains the issue - the problem is not that there is one
less register in the cache than is in use, it's that there is one less
register in the cache than is *cached*.  As I say the code deliberately
doesn't cache one of the registers.

> >I'm not 100% sure what you mean here but I suspect you're misreading the
> >register cache access code?

> The register cache access code uses one-based indexing so the first

Right, that makes sense with the above.
