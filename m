From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA V3
Date: Fri, 30 Oct 2009 20:59:56 +0900
Message-ID: <20091030115956.GB19050@linux-sh.org>
References: <20091022202506.GA24298@rafazurita.homelinux.net>
	<s5hd445yvjg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by alsa0.perex.cz (Postfix) with ESMTP id 585F724503
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 13:00:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd445yvjg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Rafael Ignacio Zurita <rizurita@yahoo.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2009 at 12:24:03PM +0100, Takashi Iwai wrote:
> At Thu, 22 Oct 2009 17:25:06 -0300,
> Rafael Ignacio Zurita wrote:
> > --- /dev/null
> > +++ b/include/sound/sh_dac_audio.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * SH_DAC specific configuration, for the dac_audio platform_device
> > + *
> > + * Copyright (C) 2009 Rafael Ignacio Zurita <rizurita@yahoo.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __INCLUDE_SH_DAC_AUDIO_H
> > +#define __INCLUDE_SH_DAC_AUDIO_H
> > +
> > +struct dac_audio_pdata {
> > +	int buffer_size;
> > +	int channel;
> > +	void (*start)(struct dac_audio_pdata *pd);
> > +	void (*stop)(struct dac_audio_pdata *pd);
> > +};
> > +
> > +#endif /* __INCLUDE_SH_DAC_AUDIO_H */
> 
> Isn't it better to include this piece into mach/hp6xx.h or so?
> Since it's pretty specific to the platform, it's not necessarily in
> the common sound include path.
> 
It's not really platform specific, it's a generic driver for the SH
on-chip DAC. hp6xx is the only platform that is using this at the moment,
but it's forseeable that other SH-3 platforms will enable this, too.

Of course we can hide this header in the sh includes somewhere if you
don't want it in include/sound, but include/sound certainly seems like a
reasonable place for it.
