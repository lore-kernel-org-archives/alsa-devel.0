From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 01 May 2015 09:30:09 +0200
Message-ID: <1430465409.2187.47.camel@x220>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
	 <1430429283-27907-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430429283-27907-2-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Just a nit: a license mismatch.

On Thu, 2015-04-30 at 23:28 +0200, Marek Belisko wrote:
> --- /dev/null
> +++ b/sound/soc/codecs/gtm601.c

> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
(just) GPL v2. So I think either the comment at the top of this file or
the ident used in the MODULE_LICESE() macro should change.


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
