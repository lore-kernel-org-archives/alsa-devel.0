From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix wm8753 register cache size and
	initialization
Date: Fri, 3 Jul 2009 10:32:50 +0100
Message-ID: <20090703093250.GA29130@rakim.wolfsonmicro.main>
References: <1246574768-11447-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9ADE0247BE
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 11:32:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246574768-11447-1-git-send-email-lars@metafoo.de>
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

On Fri, Jul 03, 2009 at 12:46:08AM +0200, Lars-Peter Clausen wrote:

> The register cache size is of by one. There are 63 registers in use but the
> register cache size has only space for 62.

Only 62 of the registers are cached - please see the register cache
access code.

> Furthermore the codec's reg_cache_size is of by another one. Since the wm8753
> register cache uses one-based indexing we have to add one to its size.

I'm not 100% sure what you mean here but I suspect you're misreading the
register cache access code?

> Register cache initialization only copied the first sizeof(void*) elements leaving the others
> uninitialized. Fix it by using the size of the reg cache template.

This fix is good (but should use wm8753->reg_cache for the size).  I'll
fix this.
