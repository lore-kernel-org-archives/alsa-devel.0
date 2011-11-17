From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: alc5632: Fix compile without
	CONFIG_I2C
Date: Thu, 17 Nov 2011 14:20:00 +0000
Message-ID: <20111117141959.GA19918@opensource.wolfsonmicro.com>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
	<1321438023-29660-3-git-send-email-leon@leon.nu>
	<20111116103521.GA3072@opensource.wolfsonmicro.com>
	<CALq1K=KG1cycVrftOHeCYzaY9WoEwVpgt-8HYvTRrpQ=v7yEWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31F7524500
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 15:20:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=KG1cycVrftOHeCYzaY9WoEwVpgt-8HYvTRrpQ=v7yEWw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 09:11:00PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 16, 2011 at 12:35, Mark Brown

> > This is only needed if the driver supports more than one control
> > interface. =A0If it only supports I2C then this should be sorted out at
> > Kconfig stage.

> It is the same as your WM9081 codec, you have entry in Kconfig and
> CONFIG_I2C in the code.

> Anyway this codec is not usable without I2C, so we can drop this patch.

Some devices do have both I2C and SPI support but didn't get round to
adding one bus or the other.
