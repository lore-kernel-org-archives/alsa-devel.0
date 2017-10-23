From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 07/14] regmap: Add SoundWire bus support
Date: Mon, 23 Oct 2017 12:56:27 +0100
Message-ID: <1508759787.29460.6.camel@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
         <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
         <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2017-10-21 at 10:34 +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:23AM +0530, Vinod Koul wrote:
> 
> > + *  BSD LICENSE
> > + *
> > + *  Copyright(c) 2015-17 Intel Corporation.
> > + *
> > + *  Redistribution and use in source and binary forms, with or
> > without
> > + *  modification, are permitted provided that the following
> > conditions
> > + *  are met:
> 
> Really unhappy with the dual licensing for regmap code, this is
> interface code for some GPL only kernel code and...

if anyone uses it with GPL code then it ends up GPL so in the Linux
kernel context it's always going to be GPL.

> > +EXPORT_SYMBOL(__regmap_init_sdw);
> 
> ...this is just an obvious attempt to allow non-GPL code to directly
> use
> GPL code.


There's nothing in the GPL about EXPORT_SYMBOL. If its built GPL
dependent then it depends upon GPL code so is GPL.

Alan
