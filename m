From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Developing and cross-compiling an ASoC driver
Date: Thu, 22 Oct 2009 15:52:58 +0100
Message-ID: <20091022145258.GA14571@rakim.wolfsonmicro.main>
References: <1608652916.20091022160818@szabolcserki.com>
	<20091022142148.GE3776@sirena.org.uk>
	<786228398.20091022164034@szabolcserki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC1102439F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:52:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <786228398.20091022164034@szabolcserki.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Szabolcs Erki <szabolcs@szabolcserki.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 22, 2009 at 04:40:34PM +0200, Szabolcs Erki wrote:

Please don't top post, it breaks the flow of discussion and removes
context from your reply.

> Ok, so ASoC is totally platform-independent, there is no patch to be
> applied against ASoC in order to make it feasible for the target. Is

ASoC itself is platform independant.  It does require drivers for the
CPU, CODEC and board that it is to be used with.  You mentioned that you
are using an Atmel processor which does have CPU side support in current
Linux versions though the ADC you mentioned doesn't.

> it correct? In this case I have to compile it in the kernel, using the
> gcc-arm-elf cross compiler. How to do that? Hard copy the files and
> hacking makefiles together?
> Because the descriptions I found applied to installing ASoC on a desktop environment, like
> Ubuntu.

ASoC is part of the standard Linux kernel, just build the kernel as you
would normally.  As I said in my previous mail people working with the
same embedded Linux distribution as you are would be the best people to
ask about this, it is not at all ASoC or ALSA specific.
