From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Sun, 2 Oct 2011 22:27:11 +0100
Message-ID: <20111002212711.GC4506@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
	<2726393.3Oc3SrGyN4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA1DE24392
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 23:27:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2726393.3Oc3SrGyN4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 10:53:24PM +0200, Arnd Bergmann wrote:
> On Sunday 02 October 2011 21:41:07 Mark Brown wrote:

> > No, gpiolib is one implementation of the GPIO API but if platforms want
> > to go and define their own that's currently OK (personally I think at

> Thanks for the explanation!

> Is there any other symbol that I can test then?

You shouldn't be testing anything - the client side GPIO API (which is
what this driver is using) is supposed to stub itself out when not in
use so drivers should just be able to use it without worrying about
dependencies.  You didn't report the problem but I'd expect that
whatever you saw will be an issue in whatever platform you were trying
to build for (I'm guessing it hasn't provided gpio_request_one()),
though it could be a problem in the gpiolib stubs if that's being used.

> I noticed that a lot of places use 'depends on GPIOLIB' or
> '#ifdef CONFIG_GPIOLIB', are those usually wrong, too?

Checks for gpiolib in drivers providing GPIOs are sensible, if a
platform hasn't used gpiolib then it's generally not even got an
interface for drivers to provide GPIOs.

On the user side these are usually due to people making the sort of
changes you're making here due to a random build coverage issue - it
seems unfortunately common for people to just shove a dependency in
Kconfig when they run into a build coverage issue without looking at
what's going on.  For a lot of the stuff you see on PCs it's going to
make sense but for some of the "service" APIs like GPIOs that are more
commonly used only in embedded contexts the use of the API is usually
completely optional (eg, in this case the driver is controlling power
and reset lines which could easily just be strapped in the hardware with
no soft control and are supplied as optional platform data) so for many
systems the driver is going to work completely happily without doing
anything with GPIOs.

Adding dependencies to all the users needlessly restricts which systems
can use the drivers.  Adding ifdefs to the drivers is repetitive and
isn't great for legiblity, having the header stub itself out is simpler
and easier to use on the driver side.
