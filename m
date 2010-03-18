From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
 codec driver to ad193x supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 16:20:17 +0000
Message-ID: <20100318162017.GA6142@rakim.wolfsonmicro.main>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
	<20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16A3A10387B
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 17:20:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 11:57:43AM -0400, Mike Frysinger wrote:

> i'm not suggesting the ASoC codecs shouldnt use the same style across
> the board (and thus we shouldnt change the AD193x driver), just
> pointing out your basic premise here is invalid and that there are
> pros/cons to each method and that they're independent of the
> subsystem.  you simply selected a different solution.

My point is that the fact that the input subsystem has made a choice is
pretty much irrelevant for ASoC, which has different considerations and
therefore made a different choice.  Barry had simply said there had been
a big discussion and this is what had been agreed, but that discussion
was held for the input subsystem and when the equivalent discussion was
held for ASoC a different conclusion was reached.

The subsystem dependency here come from the fact that ASoC has machine
drivers and relies on them selecting the CODEC drivers to get them built
in the first place so if you're trying to change something like this
you'll most likely not only have to rebuild your kernel but also have to
write code.  This isn't something that the input layer has (input layer
drivers are pretty much standalone, usually only need platform data
for any per machine hookup and for I2C and SPI can even be registered
from user space IIRC) and it changes the considerations noticably.
