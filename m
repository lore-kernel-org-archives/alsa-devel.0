From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO
	lookup table
Date: Sun, 20 May 2018 19:17:04 +0300
Message-ID: <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <5456625.lDWjtgZygK@z50>
 <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
 <3505791.x6nWYTo8eb@z50>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B4362671D2
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 18:17:06 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id d125-v6so10110565qkb.8
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 09:17:06 -0700 (PDT)
In-Reply-To: <3505791.x6nWYTo8eb@z50>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: linux-fbdev@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Sun, May 20, 2018 at 6:37 PM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> On Sunday, May 20, 2018 4:44:31 PM CEST Andy Shevchenko wrote:

>> Though, I completely dislike "rdy" name of GPIO. Where is it documented?
>
> No documentation files for Amstrad Delta nor for its NAND driver specifically
> exist under Documentation/. However, there exist some for generic GPIO NAND
> driver where the pin name "rdy" is used explicitly:
> Documentation/driver-api/gpio/drivers-on-gpio.rst
> Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
> You can find that mnemonic used across drivers/mtd/nand/, standalone or as a
> suffix, including the Amstrad Delta NAND driver before the change discussed.

> To be honest, I don't like it much either, but I'm just using it instead of
> inventing something new.

OK, that's what I was looking for. Since it's already in use and
documented, then it's fine for me.

-- 
With Best Regards,
Andy Shevchenko
