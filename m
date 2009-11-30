From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Mon, 30 Nov 2009 16:12:09 +0000
Message-ID: <20091130161209.GD18944@rakim.wolfsonmicro.main>
References: <20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
	<4B11A19D.4070301@freescale.com>
	<20091129004433.GZ14091@buzzloop.caiaq.de>
	<5610599F537DD74A8D1F5CC946A7507303478C40@az33exm25.fsl.freescale.net>
	<20091130120158.GD10968@rakim.wolfsonmicro.main>
	<20091130123617.GG14091@buzzloop.caiaq.de>
	<20091130155742.GI14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3E5B2434F
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 17:12:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091130155742.GI14091@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Tabi Timur-B04825 <B04825@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 04:57:42PM +0100, Daniel Mack wrote:

> The current aproach does not work reliably, unfortunately. It turns out
> that the codec necessarily needs its analogue supply to maintain its
> state. For all other operations (iow, any of the volatges not applied),
> it has to be held in reset mode. I did that manually by driving the GPIO
> directly before, but with the current regulator framework support,
> that's not possible anymore.

This is one of the reasons why your previous code looked suspect to me,
actually - since the CODEC driver had no idea that you'd suspended the
device it'd do things like try to write volume updates to the device
while you were keeping the power off.

> Hence, we can only power down the codec when we're in system suspend,

When runtime PM hits in 2.6.33 I intend to try to enable support for it
in ASoC, it's relatively straightforward I think.  Unfortunately it'll
end up depending on the platform bus on the relevant platform being
capable of runtime pm but that should become more widely supported as
things progress.

Given this I would suggest doing the same thing the other drivers are
doing and only turning things off when the device is suspended (either
via the explicit functions or via set_bias_level()) and then let the
ASoC core deal with actually doing the suspend - it's probably less
hassle for you that way.  Converting to use the shared register I/O code
in soc-cache.c might also help here.

> which is a pitty. But even for that, we should still drive the RESET
> signal low. Can we make the GPIO pin number available to the codec
> driver?

Of course, use platform data.
