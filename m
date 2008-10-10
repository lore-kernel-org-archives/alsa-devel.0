From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [topic/asoc][DON'T PUSH][PATCH 0/3] ASoC: OMAP:
 McBSP DAI driver updates
Date: Fri, 10 Oct 2008 17:31:33 +0300
Message-ID: <20081010173133.1c68fef1.jarkko.nikula@nokia.com>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
	<20081009150228.GA16095@sirena.org.uk>
	<20081009151054.GB16095@sirena.org.uk>
	<bd7b27490810091017q38aef300rfd6150d1a17bc9f6@mail.gmail.com>
	<20081009194930.GA28985@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D287C24759
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 16:33:08 +0200 (CEST)
In-Reply-To: <20081009194930.GA28985@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: Steve@alsa-project.org, alsa-devel@alsa-project.org, Sakoman <sakoman@gmail.com>, felipe.contreras@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Oct 2008 20:49:31 +0100
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> On Thu, Oct 09, 2008 at 08:17:08PM +0300, Jarkko Nikula wrote:
> 
> > Actually devconf register definitions for 2430 and 34xx, what patch 1 is
> > using, are already in mainline and new McBSP DMA port and base address
> > definitions are covered by CONFIG_ARCH_OMAPxxxx so ASoC for osk5912 should
> > still compile.
> 
> So they should be safe to push already, then?
> 
Yes it should. Compilation for OSK5912 in Takashi's tree goes fine.

make ARCH=arm omap_osk_5912_defconfig
make ARCH=arm menuconfig
+ add support for ASoC OMAP & OSK5912
make ARCH=arm CROSS_COMPILE=arm-linux-

Also support for N810 is not coming to mainline during this merge
window so only way to compile omap-mcbsp.c is to select OMAP1 based
OSK5912. Currently it's possible to compile only for same OMAP
generation processors. I.e. OMAP1, OMAP2 or OMAP3.


Jarkko
