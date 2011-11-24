From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: drop unknown Kconfig symbol
Date: Thu, 24 Nov 2011 17:22:16 +0000
Message-ID: <20111124172216.GR8470@opensource.wolfsonmicro.com>
References: <1322155037.25125.61.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322155037.25125.61.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 06:17:17PM +0100, Paul Bolle wrote:
> There's no Kconfig symbol 'MACH_NEO1973_GTA01'. So drop all Kconfig
> references to that symbol and all code that depends on
> CONFIG_MACH_NEO1973_GTA01. This also allows for some related cleanups
> (eg, drop some checks for CONFIG_MACH_NEO1973_GTA02, as they have become
> useless). Update a few strings too, to make clear that the Openmoko Neo
> Freerunner (GTA02) is supported while the Openmoko Neo 1973 (GTA01)
> isn't.

There's people somewhat actively working on the OpenMoko devices out of
tree (and I personally have a GTA01) and I'd rather not do anything that
causes any more hassle for them.  I'd suggest discussing this with the
OpenMoko guys if you want to do it.
