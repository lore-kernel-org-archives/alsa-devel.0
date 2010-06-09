From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 4/4]AsoC/nuc900: fix a typo and rename
 the header file
Date: Wed, 09 Jun 2010 14:33:49 +0100
Message-ID: <1276090429.3067.15.camel@odin>
References: <4C05F49A.8070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F7C2103824
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 15:34:20 +0200 (CEST)
Received: by wyg36 with SMTP id 36so894467wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Jun 2010 06:34:20 -0700 (PDT)
In-Reply-To: <4C05F49A.8070309@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-06-02 at 14:05 +0800, Wan ZongShun wrote:
> Fix a '#include "nuc900-audio.h' typo, I think it should be 'audio'.
> At the same time, this patch renames the 'nuc900-auido.h' file to
> 'nuc900-audio.h'.
> 
> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>
> ---
>  sound/soc/nuc900/nuc900-ac97.c                     |    2 +-
>  .../soc/nuc900/{nuc900-auido.h => nuc900-audio.h}  |    0
>  2 files changed, 1 insertions(+), 1 deletions(-)
>  rename sound/soc/nuc900/{nuc900-auido.h => nuc900-audio.h} (100%)
> 
> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> index db7fc13..caa7c90 100644
> --- a/sound/soc/nuc900/nuc900-ac97.c
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -25,7 +25,7 @@
> 
>  #include <mach/mfp.h>
> 
> -#include "nuc900-auido.h"
> +#include "nuc900-audio.h"
> 
>  static DEFINE_MUTEX(ac97_mutex);
>  struct nuc900_audio *nuc900_ac97_data;
> diff --git a/sound/soc/nuc900/nuc900-auido.h b/sound/soc/nuc900/nuc900-audio.h
> similarity index 100%
> rename from sound/soc/nuc900/nuc900-auido.h
> rename to sound/soc/nuc900/nuc900-audio.h

I've just tried to build NUC900 as part of the ASoC multi-component work
and it looks like you didn't build this patch before sending it. The old
header name is still used in nuc900-audio.c and nuc900-pcm.c.

Can you send an incremental patch to fix this.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
