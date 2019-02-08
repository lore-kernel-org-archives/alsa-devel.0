From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license
 information
Date: Fri, 8 Feb 2019 16:15:02 +0100
Message-ID: <20190208151502.GP4686@localhost>
References: <20190207165755.1548-1-johan@kernel.org>
 <20190207165755.1548-2-johan@kernel.org>
 <20190208115341.GB6695@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208115341.GB6695@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 08, 2019 at 11:53:41AM +0000, Mark Brown wrote:
> On Thu, Feb 07, 2019 at 05:57:53PM +0100, Johan Hovold wrote:
> 
> > +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> > @@ -1,3 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> > + */
> 
> Please use a C++ comment for the whole thing so it looks more consistent
> with the rest of ASoC (and a bit neater in general).

Ah, yes, that makes sense for consistency since you've already enforced
that style. And while I don't think the all-c++-comment headers look
better in general, for the single copyright statement case it's not too
bad.

v2 under way.

Johan
