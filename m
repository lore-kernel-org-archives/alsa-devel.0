From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Thu, 28 Aug 2008 20:33:20 +0100
Message-ID: <20080828193317.GA7155@sirena.org.uk>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
	<20080826192043.GA3812@roarinelk.homelinux.net>
	<20080826193728.GD3461@sirena.org.uk>
	<20080828172540.GA21551@roarinelk.homelinux.net>
	<20080828193754.6f8f6594@hyperion.delvare>
	<20080828184251.GA21868@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E716C24443
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 21:33:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828184251.GA21868@roarinelk.homelinux.net>
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
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Eric Miao <eric.miao@marvell.com>, Jean Delvare <khali@linux-fr.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 28, 2008 at 08:42:52PM +0200, Manuel Lauss wrote:

> Attached below.  Although I'm no longer convinced it's a good idea after
> all; I don't see how multiple asoc devices with this codec could be
> realized (which afaik is planned with asoc2).

You can't have multiple ASoC devices.  You also can't have more than one
codec within the one ASoC device that you can instantiate at the moment.
Loading the codec driver normally can be made to work (the PowerPC guys
are doing it at the minute) but it's fragile since it doesn't play with
the assumptions the ASoC code is currently making.

I'd be more comfortable with leaving the I2C driver registration done
where it is currently until ASoC at least supports dynamic registration
of codec drivers explicitly purely on a risk avoidance basis.
