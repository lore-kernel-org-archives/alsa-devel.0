From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc: neo1973_wm8753 audio support does	not
	require scoop
Date: Mon, 31 Jan 2011 11:23:40 +0000
Message-ID: <20110131112339.GD11937@sirena.org.uk>
References: <201101281200.18371.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DB9E24133
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 12:23:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201101281200.18371.hartleys@visionengravers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 12:00:18PM -0700, H Hartley Sweeten wrote:
> This driver does not use any of the functionality provided by the scoop
> hardware.  Remove the unneeded header.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

CCing in Liam.  As I think I've mentioned before please do remember to
CC maintainers.

> 
> ---
> 
> diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
> index c7a2451..c5b3113 100644
> --- a/sound/soc/samsung/neo1973_wm8753.c
> +++ b/sound/soc/samsung/neo1973_wm8753.c
> @@ -24,7 +24,6 @@
>  #include <sound/tlv.h>
>  
>  #include <asm/mach-types.h>
> -#include <asm/hardware/scoop.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-gpio.h>
>  #include <mach/hardware.h>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
