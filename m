From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Thu, 15 Jan 2009 10:10:18 +0000
Message-ID: <20090115101018.GK2162@n2100.arm.linux.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 373A024399
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 11:10:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <496F0ABD.4080207@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Only one comment from me...

On Thu, Jan 15, 2009 at 10:06:53AM +0000, Ian Molton wrote:
> diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
> new file mode 100644
> index 0000000..4ff6a84
> --- /dev/null
> +++ b/sound/soc/codecs/wm9705.c
> @@ -0,0 +1,401 @@
> +/*
> + * wm9705.c  --  ALSA Soc WM9705 codec support
> + *
> + * Copyright 2008 Ian Molton <spyro@f2s.com>
> + *
> + *  This program is free software; you can redistribute  it and/or 
> modify it
> + *  under  the terms of  the GNU General  Public License as published 
> by the
> + *  Free Software Foundation; Version 2 of the  License only.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/version.h>

Please do not include linux/version.h except where it is really needed
(I don't see anything requiring it in this file.)
