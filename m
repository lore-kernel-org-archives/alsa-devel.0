From: Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>
Subject: Re: [PATCH] ASoC: max98373: Added Amplifier Driver
Date: Fri, 22 Dec 2017 09:39:00 +0100
Message-ID: <CAOFm3uH3+UsSZ7DgDk9AYRb8K7GjKUNwchGW3_hxD3DMOidjpg@mail.gmail.com>
References: <1513907030-18441-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513907030-18441-1-git-send-email-ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, afd-l0cyMroinI0@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, supercraig0719-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, dannenberg-l0cyMroinI0@public.gmane.org, Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, bryce.ferguson-lFk7bPDcGtkY5TsXZYaR1UEOCMrvLtNR@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, m-stecklein-l0cyMroinI0@public.gmane.org, ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ryan.lee.maxim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Ryan,

On Fri, Dec 22, 2017 at 2:43 AM, Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org> wrote:
> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> ---
>
> Created max98373 amplifier driver.
>

<snip>

> --- /dev/null
> +++ b/sound/soc/codecs/max98373.c
> @@ -0,0 +1,996 @@
> +/*
> + * max98373.c  --  MAX98373 ALSA Soc Audio driver
> + *
> + * Copyright (C) 2017 Maxim Integrated Products
> + * Author: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + */

Have you considered using the new SPDX tags instead of this fine but
long legalese?

And if other contributors in your team could follow suit and you could
spread the word that would be even better!

See Thomas doc patches [1] for details.
Thanks!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
