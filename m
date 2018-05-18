From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3] ASoC: ssm2305: Add amplifier driver
Date: Fri, 18 May 2018 10:07:11 +0200
Message-ID: <20180518080711.asgrisdqxgzm3ziw@pengutronix.de>
References: <20180517135518.29345-1-m.felsch@pengutronix.de>
 <20180517170826.GV20254@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F587266F4E
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 10:07:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180517170826.GV20254@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Dear Mark,

On 18-05-17 18:08, Mark Brown wrote:
> On Thu, May 17, 2018 at 03:55:18PM +0200, Marco Felsch wrote:
> 
> > +++ b/sound/soc/codecs/ssm2305.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Analog Devices SSM2305 Amplifier Driver
> 
> Please submit a followup patch which makes the entire comment a C++ one
> rather than mixing them in the same comment block, it makes things look
> more intentional.

I'm a bit confused. As documented by the 
Documentation/process/license-rules.rst the license header should be a C++
comment but for all block comments the 'normal' coding style should be
applied. I can seperate the license header and the comment to make it
more intentional.

// SPDX-License-Identifier: GPL-2.0

/*
 * Analog Devices SSM2305 Amplifier Driver
 *
 * Copyright (C) 2018 Pengutronix, Marco Felsch <kernel@pengutronix.de>
 */

Is that better?

Marco
