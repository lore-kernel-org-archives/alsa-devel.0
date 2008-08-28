From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Thu, 28 Aug 2008 19:25:40 +0200
Message-ID: <20080828172540.GA21551@roarinelk.homelinux.net>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
	<20080826192043.GA3812@roarinelk.homelinux.net>
	<20080826193728.GD3461@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B572243D9
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 19:25:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826193728.GD3461@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Eric Miao <eric.miao@marvell.com>, Andrew
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Aug 26, 2008 at 08:37:28PM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2008 at 09:20:43PM +0200, Manuel Lauss wrote:
> 
> > I don't know about other wm8731 users, but I'd prefer to let the board
> > code register the codec i2c device.  Then you could also get rid
> > of "struct wm8731_setup_data" altogether.
> 
> Yes, that would have been the ideal thing with the old I2C API too IIRC.
> Unfortunately ASoC v1 requires that all the devices comprising the ASoC
> system be registered in one fell swoop.  Once enough of v2 has been
> merged to allow the codec drivers to register their DAIs independantly
> of everything else the codecs can be instantiated from wherever the
> platform feels like doing it.

I modified Jean's newest patch a bit to just register the i2c driver and
leave the actual device registration to the board code.  It works as
intended!  The only difference is that udev loads the wm8731 module at boot
but that is expected due to the set owner field in struct i2c_driver;
after loading the platform sound module all is working well.
(tried with asoc all-modular and all-builtin).

Best regards,
	Manuel Lauss
