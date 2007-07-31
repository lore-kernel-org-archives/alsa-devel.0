From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] ASoC CS4270 codec device driver
Date: Tue, 31 Jul 2007 13:53:16 -0500
Message-ID: <46AF851C.5090700@freescale.com>
References: <1185896812320-git-send-email-timur@freescale.com>
	<s5h4pjkva0g.wl%tiwai@suse.de> <46AF5F7C.5020309@freescale.com>
	<s5h3az4v97m.wl%tiwai@suse.de> <s5hy7gwttzp.wl%tiwai@suse.de>
	<46AF6648.5000803@freescale.com>
	<Pine.LNX.4.58.0707311122470.15067@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CA9C1037F8
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 20:53:21 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0707311122470.15067@shell2.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:

> If config FOO is compiled in (i.e.  it's "y"), CONFIG_FOO will be defined.
> If it's a module, CONFIG_FOO_MODULE will be defined.  It's one or the
> other, not both.

Learn something new every day.  I should have known that already, though.

> If you want your code to comple differently if it has i2c available, you should
> do this:
> 
> #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
> /* code that needs i2c goes here, i2c_transfer(), etc. */
> #endif
> 
> Note that just checking defined(CONFIG_I2C_MODULE) isn't correct.  If your
> code is compiled in and i2c is a module, you can't call i2c functions or
> the kernel won't link.

Which is a problem because ASoC currently requires all modules to be linked together.  The 
machine driver has hard-coded references to structures in the other drivers.

I think Liam was trying to fix that with the PowerPC branch, but it doesn't look like he's 
finished.

> Of course, if you need i2c to work in any reasonble way, you should just
> have your driver depend on i2c in Kconfig.

Well, that's the odd thing about the CS4270 - it's not required.  The CS4270 can work with 
or without I2C.  I tried writing the driver to be intelligent about that - if I2C is 
enabled, but the device can't be found on the I2C bus, it falls back to "stand-alone" mode.

It looks like I'm not really going to be able to support stand-alone mode yet, anyway.  So 
I'll just try to make it compile when I2C is disabled.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
