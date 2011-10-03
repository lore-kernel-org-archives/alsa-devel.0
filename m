From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Mon, 3 Oct 2011 14:45:27 +0100
Message-ID: <20111003134527.GF11710@n2100.arm.linux.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D9B192413A
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 15:45:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111002204106.GB5811@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Dmitry Artamonow <mad_soft@inbox.ru>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 09:41:07PM +0100, Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> > This driver only builds correctly on platforms that use
> > GPIOLIB. Disable it otherwise.
> 
> No, gpiolib is one implementation of the GPIO API but if platforms want
> to go and define their own that's currently OK (personally I think at
> this point we should just be converting all the stragglers over to
> gpiolib).  As things stand we shouldn't have dependencies on a
> particular implementation of the API.

Then it should depend on GENERIC_GPIO (not to be confused with GPIO_GENERIC,
the generic gpiolib driver), which is the symbol meaning that the GPIO API
is provided by something.
