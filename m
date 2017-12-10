From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v3] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Sun, 10 Dec 2017 10:00:02 +0100
Message-ID: <CAOFm3uHd_mepHLV1kBxin=OoCYp=perRLD-tKQFawqKLmw3frA@mail.gmail.com>
References: <20171209224205.2b4qcqpro37fnev7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 93607266B0F
 for <alsa-devel@alsa-project.org>; Sun, 10 Dec 2017 10:00:43 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id t8so9384556wmc.3
 for <alsa-devel@alsa-project.org>; Sun, 10 Dec 2017 01:00:43 -0800 (PST)
In-Reply-To: <20171209224205.2b4qcqpro37fnev7@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Steven,

On Sat, Dec 9, 2017 at 11:42 PM, Steven Eckhoff
<steven.eckhoff.opensource@gmail.com> wrote:
> Currently there is no support for the TSCS42xx audio CODEC.
>
> Add support for it.
>
> Below is the link to the v2 patch in case the threading is broken. This
>  patch addressed each issue raised in the last review.
>
> https://patchwork.kernel.org/patch/10058117/
>
> Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
[...]
> --- /dev/null
> +++ b/sound/soc/codecs/tscs42xx.c
> @@ -0,0 +1,1571 @@
> +/*
> + * tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
> + *
> + * Copyright 2017 Tempo Semiconductor, Inc.
> + *
> + * Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Have you considered using the new SPDX ids? This would come out as:

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
> + *
> + * Copyright 2017 Tempo Semiconductor, Inc.
> + *
> + * Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> + */

... and is shorter and greppable: there is nothing not to like in
this, unless you love legalese of course!

Check also Thomas doc patches and Linus rationale of why he wants this
as the top line using C++-style comments.

And if you agree like me with Linus take on C++ comments, you could
even go with less boilerplate with this:

> +// SPDX-License-Identifier: GPL-2.0
> +// tscs42xx.c -- TSCS42xx ALSA SoC Audio driver
> +// Copyright 2017 Tempo Semiconductor, Inc.
> +// Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>

This would make 12 lines of comment be just 4 .... with the same
effect, but less distraction from your fine code.

Thank you for your kind consideration!
-- 
Cordially
Philippe Ombredanne
