From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate
	clock	ratio for WM8580
Date: Tue, 31 Aug 2010 11:42:32 +0100
Message-ID: <20100831104232.GB31948@sirena.org.uk>
References: <1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
	<20100816102010.GB3276@rakim.wolfsonmicro.main>
	<AANLkTinTYo6_BBSkhTt8Km-MR4wwexDS3orFJdNSiufT@mail.gmail.com>
	<20100816151958.GE3276@rakim.wolfsonmicro.main>
	<AANLkTindYfm3vh_OgF-0tt_MS+Uxii2s7Dw=Kk487RTd@mail.gmail.com>
	<20100817094605.GC18622@rakim.wolfsonmicro.main>
	<AANLkTimG-LqfTG1x++uME1DaAAysgqS=5zwjHE_o0hsR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E83D01037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 12:42:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimG-LqfTG1x++uME1DaAAysgqS=5zwjHE_o0hsR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 03:46:44PM +0900, Jassi Brar wrote:

> Ok, now that I am faced with supporting latest SMDKs that use codecs
> other than WM8580 (like wm8994), I think we'd better break the MACHINE
> driver into SMDK specific (setup CPU master, CODEC slave and
> root-clock sourced acc to option provided vai platform_data)
> and CODEC specific part.
> That will also help code reuse.

> Any opinions, before I start working on it?

If you're looking at this it'd be a good idea to look at pulling the
clocking configuration for the CPU into the CPU driver - the Samsung
CPU hardware is fairly straightforward and easy to use and it should be
possible to automate much more of the configuration, at least by
default.  At the minute there's a lot of cut'n'paste code for the
clocking configuration which could do with being shared.

In terms of the stuff that is genuinely board specific I'd need to look
at the designs and discuss the use cases with you to really comment in
too much detail.  The WM8994 is a vastly more flexible part and there's
a number of interesting things you can do with it that might result in a
noticably different clocking configuration from the machine driver,
especially around things like the analogue bypass cases and keeping the
the device active during suspend, but a lot of this depends on the
system design as a whole.
