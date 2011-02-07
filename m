From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: Samsung: neo1973_gta02: Fix bluetooth DAI
 registration
Date: Mon, 7 Feb 2011 17:02:14 +0000
Message-ID: <20110207170213.GP10564@opensource.wolfsonmicro.com>
References: <1297033463-14577-1-git-send-email-lars@metafoo.de>
 <1297033463-14577-6-git-send-email-lars@metafoo.de>
 <20110207115906.GD10564@opensource.wolfsonmicro.com>
 <4D5023A4.3020209@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D5023A4.3020209@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Please fix your MUA to word wrap at less than 80 columns, I've reflowed
your text so it's legible.

On Mon, Feb 07, 2011 at 05:53:56PM +0100, Lars-Peter Clausen wrote:

> > In any
> > case, we clearly shouldn't be applying patches which bodge around the
> > core.

> Well the alternative would be a patch looking like this:

> -	.cpu_dai_name = "bluetooth-dai",
> +	.cpu_dai_name = "soc-core",

> Which isn't really nice either.

If you think the core isn't behaving helpfully the core should be
changed.  This is part of how APIs evolve to be maximally useful.

To be honest it's not massively obvious that we shouldn't just be taking
the name of the device here, either using a device to represent the
modem or registering the card using snd_soc_register_machine() and using
a more meaningful name for the card seems like a sensible approach here.
