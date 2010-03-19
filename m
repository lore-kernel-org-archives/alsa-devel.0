From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
 codec driver to ad193x supporting ad1936/7/8/9
Date: Fri, 19 Mar 2010 12:24:22 +0000
Message-ID: <20100319122422.GE23306@rakim.wolfsonmicro.main>
References: <1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
	<20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
	<20100318162017.GA6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
	<20100318180516.GF6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181108y3f7f5871t81c5cd5ba0c6312d@mail.gmail.com>
	<3c17e3571003182030mc8ea095u2298f008fbcbee8e@mail.gmail.com>
	<3c17e3571003190007p61929e99y4db8f5545e777401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81FD724343
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 13:24:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3571003190007p61929e99y4db8f5545e777401@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>, yi.li@analog.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 19, 2010 at 03:07:33PM +0800, Barry Song wrote:
> It seems "git-format-patch -M" fails to detect this patch as a
> rename(maybe due to too many changed lines?), so I commit two times to
> get a readable patch and attach them.
> 1. rename ad1938 to ad193x
> 2. extend ad1938 codec driver to ad193x supporting ad1936/7/8/9

Please don't top post and please always follow the patch submission
procedure documented in Documentation/SubmittingPatches.  Even if
problems with your MUA make it difficult to submit patches without using
attachments you should always send one patch per message.  Not following
these rules makes your patches much more difficult to handle.

Since the patches aren't in line it's difficult to quote things when
commenting but a few issues:

 - Your rename patch didn't update the Makefile and Kconfig, which would
   cause build breakage if applied alone.  You should always try to
   ensure that builds work even with a partially applied patch series
   since this allows things like bisection which step through the
   history to work.

 - You've left the bus_probe() functions exported - now you've merged
   everything into one file this is no longer needed.

 - The way you've factored out the bus probe and removal functions so
   that there's no code in the individual I2C and SPI functions means
   that the register() and unregister() functions could just be squashed
   into the bus_probe() and bus_remove() functions - all that the
   register and unregister functions are is the code that's shared
   between the bus 

I've fixed the first issue by squashing the two patches together and the
last one with a patch.  The last issue isn't important, it's more for
information.
