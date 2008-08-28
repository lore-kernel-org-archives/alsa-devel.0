From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style i2c
 driver (testers wanted)
Date: Thu, 28 Aug 2008 19:37:54 +0200
Message-ID: <20080828193754.6f8f6594@hyperion.delvare>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
	<20080826192043.GA3812@roarinelk.homelinux.net>
	<20080826193728.GD3461@sirena.org.uk>
	<20080828172540.GA21551@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D1955243B5
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 19:38:03 +0200 (CEST)
In-Reply-To: <20080828172540.GA21551@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Eric Miao <eric.miao@marvell.com>, Richard Purdie <rpurdie@rpsys.net>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Manuel,

On Thu, 28 Aug 2008 19:25:40 +0200, Manuel Lauss wrote:
> Hi Mark,
> 
> On Tue, Aug 26, 2008 at 08:37:28PM +0100, Mark Brown wrote:
> > On Tue, Aug 26, 2008 at 09:20:43PM +0200, Manuel Lauss wrote:
> > 
> > > I don't know about other wm8731 users, but I'd prefer to let the board
> > > code register the codec i2c device.  Then you could also get rid
> > > of "struct wm8731_setup_data" altogether.
> > 
> > Yes, that would have been the ideal thing with the old I2C API too IIRC.
> > Unfortunately ASoC v1 requires that all the devices comprising the ASoC
> > system be registered in one fell swoop.  Once enough of v2 has been
> > merged to allow the codec drivers to register their DAIs independantly
> > of everything else the codecs can be instantiated from wherever the
> > platform feels like doing it.
> 
> I modified Jean's newest patch a bit to just register the i2c driver and
> leave the actual device registration to the board code.  It works as
> intended!

Great, thanks for testing this. Could you please post an incremental
patch going on top of mine? So that I see what it looks like and also
so that both patches can be pushed upstream.

> The only difference is that udev loads the wm8731 module at boot
> but that is expected due to the set owner field in struct i2c_driver;

What makes the wm8731 driver load at boot is the module alias that is
now exported by the wm8731 module ("i2c:wm8731"). When you create the
wm8731 I2C device from your platform code, udev and the surrounding
scripts notice it and basically call "modprobe i2c:wm8731".

This is one of the various benefits of the new i2c device driver
binding model.

> after loading the platform sound module all is working well.
> (tried with asoc all-modular and all-builtin).

-- 
Jean Delvare
