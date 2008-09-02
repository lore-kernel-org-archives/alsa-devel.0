From: Timur Tabi <timur@freescale.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Tue, 02 Sep 2008 10:03:59 -0500
Message-ID: <48BD55DF.8060203@freescale.com>
References: <20080831161843.227b31f3@hyperion.delvare>	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AB621037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 17:47:45 +0200 (CEST)
In-Reply-To: <20080831190928.2931b0ed@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jean Delvare wrote:

> * Your driver now lacks a remove method. Unless I miss something, if
> the snd-soc-cs4270 driver is unloaded, you will leave dangling
> resources behind (codec->reg_cache in particular.)

Indeed, but then, I don't think I ever supported loading and unload this driver
as a module.  The Kconfig does say it's a tristate, though.  I'll take a look at
it.

Most of my real development is going to the ASoC V2 version of this driver, and
that version should be a lot better.  I'll take another look at both driver to
make sure I didn't screw this up.

> * I2C_DRIVERID_CS4270 must be removed from i2c-id.h.

It can't be removed until this patch goes upstream, but thanks for the reminder.

> As I understand it, without that patch the mpc8610_hpcd doesn't work,
> as the I2C address of the sound codec will be made busy by the platform
> code and thus the snd-soc-cs4270 driver won't be able to attach to it.

That's correct.  I though I made that clear in the changelog.

> Do you
> know off the top of your head if other drivers have already been
> converted?

I doubt it.  ASoC V1 doesn't generally support PowerPC, although there is code
to make it work.  That's why there's not a lot of support across the board for
PowerPC-isms.

-- 
Timur Tabi
Linux kernel developer at Freescale
