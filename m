From: Szabolcs Erki <szabolcs@szabolcserki.com>
Subject: Re: Developing and cross-compiling an ASoC driver
Date: Thu, 22 Oct 2009 17:05:02 +0200
Message-ID: <836444322.20091022170502@szabolcserki.com>
References: <1608652916.20091022160818@szabolcserki.com>
	<20091022142148.GE3776@sirena.org.uk>
	<786228398.20091022164034@szabolcserki.com>
	<20091022145258.GA14571@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B94824403
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:05:07 +0200 (CEST)
In-Reply-To: <20091022145258.GA14571@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Please don't top post, it breaks the flow of discussion and removes
> context from your reply.
Ok.

>> Ok, so ASoC is totally platform-independent, there is no patch to be
>> applied against ASoC in order to make it feasible for the target. Is

> ASoC itself is platform independant.  It does require drivers for the
> CPU, CODEC and board that it is to be used with.  You mentioned that you
> are using an Atmel processor which does have CPU side support in current
> Linux versions though the ADC you mentioned doesn't.

>> it correct? In this case I have to compile it in the kernel, using the
>> gcc-arm-elf cross compiler. How to do that? Hard copy the files and
>> hacking makefiles together?
>> Because the descriptions I found applied to installing ASoC on a desktop environment, like
>> Ubuntu.

> ASoC is part of the standard Linux kernel, just build the kernel as you
Good to know. I'm going to look deeper into the kernel config.

> would normally.  As I said in my previous mail people working with the
> same embedded Linux distribution as you are would be the best people to
> ask about this, it is not at all ASoC or ALSA specific.

Ok, I will ask them. But I still hope that someone in the ALSA list faced
the same problem.

Szabolcs
