From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Tue, 26 Aug 2008 20:37:28 +0100
Message-ID: <20080826193728.GD3461@sirena.org.uk>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
	<20080826192043.GA3812@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C841A243BE
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 21:37:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826192043.GA3812@roarinelk.homelinux.net>
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

On Tue, Aug 26, 2008 at 09:20:43PM +0200, Manuel Lauss wrote:

> I don't know about other wm8731 users, but I'd prefer to let the board
> code register the codec i2c device.  Then you could also get rid
> of "struct wm8731_setup_data" altogether.

Yes, that would have been the ideal thing with the old I2C API too IIRC.
Unfortunately ASoC v1 requires that all the devices comprising the ASoC
system be registered in one fell swoop.  Once enough of v2 has been
merged to allow the codec drivers to register their DAIs independantly
of everything else the codecs can be instantiated from wherever the
platform feels like doing it.
