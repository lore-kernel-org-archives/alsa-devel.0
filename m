From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Mon, 3 Oct 2011 15:35:53 +0100
Message-ID: <20111003143553.GG23811@sirena.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
	<20111003134527.GF11710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E39D7243B7
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 16:35:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111003134527.GF11710@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Dmitry Artamonow <mad_soft@inbox.ru>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 02:45:27PM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 09:41:07PM +0100, Mark Brown wrote:

> > No, gpiolib is one implementation of the GPIO API but if platforms want
> > to go and define their own that's currently OK (personally I think at
> > this point we should just be converting all the stragglers over to
> > gpiolib).  As things stand we shouldn't have dependencies on a
> > particular implementation of the API.

> Then it should depend on GENERIC_GPIO (not to be confused with GPIO_GENERIC,
> the generic gpiolib driver), which is the symbol meaning that the GPIO API
> is provided by something.

Not for devices like this where the GPIOs are an optional thing the
driver can use, a dependency is far too strong.  Devices like that
should be able to rely on the stubs.
