From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date: Mon, 18 Jun 2018 14:39:32 +0200
Message-ID: <20180618123932.GA28476@centauri.lan>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
 <20180618110642.GA6928@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618110642.GA6928@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, robh+dt@kernel.org, frowand.list@gmail.com
Cc: andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
> > of_platform_device_destroy is only defined when building
> > with CONFIG_OF=y. Add a depends on OF.
> 
> Is it sensible that of_platform_device_destroy() is only defined when
> building with CONFIG_OF=y?

I'm redirecting that question to the device tree maintainers.

There are a few of_* functions in include/linux/of_platform.h
that are only defined when CONFIG_OF=y:

of_platform_device_create()
of_platform_device_destroy()
of_platform_bus_probe()
of_device_alloc()

Rob, Frank, do you want me to create static inline dummy versions of these?

Regards,
Niklas
