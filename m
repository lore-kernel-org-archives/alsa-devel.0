From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Wed, 02 Feb 2011 16:26:51 +0300
Message-ID: <1296653211.1504.40.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward18.mail.yandex.net (forward18.mail.yandex.net
	[95.108.253.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C12EA2455E
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 14:26:54 +0100 (CET)
In-Reply-To: <20110202125327.GO12743@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, H Hartley Sweeten <hartleys@visionengravers.com>, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dear Mark, Dear Hartley,

On Wed, 2011-02-02 at 12:53 +0000, Mark Brown wrote:
> > Now Hartley suggested to move GPIO handling to platform code. This makes
> > sense, as SPI-enable will be managed automatically, and reset is also
> > more related to platform (depending on schematics, inversion and so on).
> 
> What is the advantage of this?  The GPIO management has to be done
> somewhere and replicating it in every platform seems like a complete
> waste of time.  Given that one of the GPIOs is a power control it'll
> also mean that it's not possible to manage the power dynamically at
> runtime.
> 

I think we can leave reset management in CODEC (as it will be almost the
same for all platforms), leave enable pin management in CODEC unused,
but attach enable GPIO to spi_board_info in platform to enable other SPI
devices on bus.

Hartley, in this case we cannot use existing cs4271_platform_data and
have to leave long if-else statemens as is. Would it be ok?

Best regards,
	Alexander.
