From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for PCM1789
Date: Mon, 5 Mar 2018 16:57:15 +0100
Message-ID: <20180305155715.GJ3035@piout.net>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-2-mylene.josserand@bootlin.com>
 <20180305154910.GJ8588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180305154910.GJ8588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

On 05/03/2018 at 15:49:10 +0000, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 01:48:16PM +0100, Mylène Josserand wrote:
> 
> > --- /dev/null
> > +++ b/sound/soc/codecs/pcm1789-i2c.c
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCM1789 ASoC I2C driver
> > + *
> > + * Copyright (c) Bootlin 2018
> > + *
> > + * Mylène Josserand <mylene.josserand@bootlin.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> 
> Please don't mix C and C++ style comments in a single comment like this
> - it looks unintentional.  Just use the same style for the whole thing.
> You also don't need to include all the boilerplate with the SPDX header.
> 

I think Linus made it clear that he wants the SPDX header to be a
C++ comment, the documentation has:

"
2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>
"

I agree the boilerplate should be removed.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
