From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Problem to init AD1938 on i.MX25
Date: Mon, 16 Aug 2010 09:30:40 +0200
Message-ID: <20100816073040.GH27749@pengutronix.de>
References: <4C68C3C5.5030701@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B80FB1037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 09:30:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C68C3C5.5030701@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sven Zeisberg <sven.zeisberg@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Sven,

On Mon, Aug 16, 2010 at 06:51:17AM +0200, Sven Zeisberg wrote:
>   Hello,
> =

> we're working on an ALSA  driver for AD1938 for i.MX25 based system.
> On the I=B2S the CODEC is Master. On the SPI, the MCU is Master.
> =

> SSI seems to work (when we set the CODEC as Master by Hardware).
> =

> We have problems to get the communication via SPI working. The CODEC =

> requires 24Bit words and we can set SPI according to this in the =

> board-file and verify this also with a logic analyzer. However, we can =

> send only one word to the CODEC! This first word is transferred =

> correctly, but all subsequent transfers show no activity on the SPI =

> lines. We do not get any error messages from the SPI drivers! All SPI =

> writes after the first word seem to be executed in software but show not =

> effect in hardware. All reads return 0xff.

This is probaly more a problem in the SPI driver than alsa related. The
i.MX SPI unit comes in many different variants and there may well be a
bug in the i.MX25 path. As a test you could configure the SPI pads in
gpio mode and use the bitbang gpio spi driver (drivers/spi/spi_gpio.c).
When this works you can hunt down the bug in the SPI driver.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
