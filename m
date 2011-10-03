From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Mon, 3 Oct 2011 17:34:41 +0100
Message-ID: <20111003163441.GH23811@sirena.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1343003.MpQlxoEPa6@wuerfel>
	<20111003152002.GP3731@opensource.wolfsonmicro.com>
	<9353092.2X2OeIUYGE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01DE12448E
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 18:34:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9353092.2X2OeIUYGE@wuerfel>
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dmitry Artamonow <mad_soft@inbox.ru>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 06:19:48PM +0200, Arnd Bergmann wrote:

> When the GPIO API is stubbed out, the definition of struct gpio
> is empty, so you cannot access the members, which seems to be
> intentional behavior.

That doesn't seem terribly helpful, it means drivers either need to
ifdef or not use the bulk functions.

>  struct device;
> -struct gpio;
> +struct gpio {
> +       unsigned        gpio;
> +       unsigned long   flags;
> +       const char      *label;
> +};

This looks much more sensible to me.

>  	select SND_SOC_WL1273 if MFD_WL1273_CORE
> -	select SND_SOC_WM1250_EV1 if I2C
> +	select SND_SOC_WM1250_EV1 if I2C && GENERIC_GPIO

Or ifdefs in the driver.
