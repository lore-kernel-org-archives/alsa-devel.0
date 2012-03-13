From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Triple implementation of WM8766 and quadruple
	WM8776!
Date: Tue, 13 Mar 2012 10:46:30 +0100
Message-ID: <4F5F1776.4020904@ladisch.de>
References: <201203122241.12234.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F357310413B
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 10:43:23 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A75C8210D8
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 05:43:20 -0400 (EDT)
In-Reply-To: <201203122241.12234.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ondrej Zary wrote:
> I'm trying do implement support for Philips PSC724 Ultimate Edge card, which
> is based on VT1722 + WM8776 + WM8766 chips. Found that the best file to base
> my work on is sound/pci/ice1712/se.c (as SE-200PCI card contains both WM8776
> and WM8766 chips).
>
> While doing this, found that there are three implementations of WM8766 codec
> control, two of them in the same driver(!):
> sound/pci/ice1712/se.c
> sound/pci/ice1712/prodigy_hifi.c
> sound/pci/oxygen/xonar_wm87x6.c (+sound/pci/oxygen/wm8766.h)
>
> And WM8776 status is even worse, there are four implementations, again two
> being in the same driver:
> sound/pci/ice1712/se.c
> sound/pci/ice1712/maya44.c
> sound/pci/oxygen/xonar_wm87x6.c (+sound/pci/oxygen/wm8776.h)
> sound/soc/codecs/wm8776.c (this one being official and stand-alone module but
> it does not seem to be usable as a part of sound card driver)

The ALSA SoC framework differentiates between three kinds of drivers:
codec, platform (controllers like the VT1722), and machine (in your
case, the wiring on the PSC724).  When I wrote the oxygen driver,
I didn't use ASoC because it didn't support multiple codecs per card
at that time (now it does).

I'd suggest to use ASoC, except that ice1724 is not an ASoC platform
driver, so you'd have to duplicate it.

All the non-ASoC drivers mix codec and machine drivers in the same file.
In the long term, ice1712 and oxygen should be converted to use ASoC,
but that would be a lot of effort if regressions are to be avoided.

I'd suggest to move the common parts of the three ice1712 drivers into
separate files.  You could make the interface of those files similar to
ASoC codec drivers to make later porting easier.


Regards,
Clemens
