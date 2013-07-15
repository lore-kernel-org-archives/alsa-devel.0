From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: kirkwood-i2s: fix a compilation warning
Date: Mon, 15 Jul 2013 22:37:27 +0100
Message-ID: <20130715213727.GW24642@n2100.arm.linux.org.uk>
References: <20130715103644.04e57749@armhf> <20130715153101.GK11538@sirena.org.uk> <20130715203756.68abbf10@armhf> <20130715200851.GD11538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130715200851.GD11538@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2013 at 09:08:51PM +0100, Mark Brown wrote:
> There's no obvious code that handles anything differently with extclk.
> Indeed if you think about it for a minute you'll realise there's no way
> the driver will ever use an extclk - set_rate() is badly implemented,
> look at how other drivers select between clocks.

I suggest you go back and re-read the driver because it most certainly
does use extclk.  What makes you think it won't?
