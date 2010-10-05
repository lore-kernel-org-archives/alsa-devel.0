From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] sound/soc/nuc900: remove duplicated include
Date: Tue, 05 Oct 2010 13:27:42 +0100
Message-ID: <1286281662.3111.97.camel@odin>
References: <20101005141140.0276dc14@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id E0B89244C7
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 14:27:45 +0200 (CEST)
Received: by wyb42 with SMTP id 42so5980582wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Oct 2010 05:27:44 -0700 (PDT)
In-Reply-To: <20101005141140.0276dc14@absol.kitzblitz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-05 at 14:11 +0200, Nicolas Kaiser wrote:
> Remove duplicated include.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
>  sound/soc/nuc900/nuc900-ac97.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> index caa7c90..265a950 100644
> --- a/sound/soc/nuc900/nuc900-ac97.c
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -20,7 +20,6 @@
>  #include <sound/pcm.h>
>  #include <sound/initval.h>
>  #include <sound/soc.h>
> -#include <linux/device.h>
>  #include <linux/clk.h>
>  
>  #include <mach/mfp.h>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
