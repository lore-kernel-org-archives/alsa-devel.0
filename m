From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] powerpc/drivers: use linux/of_device.h
 instead of asm/of_device.h
Date: Mon, 11 Aug 2008 09:25:17 +0200
Message-ID: <20080811092517.3ab0d0c1@hyperion.delvare>
References: <20080811170432.f747ab5e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id F0BC210380E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 09:25:45 +0200 (CEST)
In-Reply-To: <20080811170432.f747ab5e.sfr@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Hanselmann <linux-kernel@hansmi.ch>, lm-sensors@lm-sensors.org, Stelian Pop <stelian@popies.net>, Paul Mackerras <paulus@samba.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Aug 2008 17:04:32 +1000, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/hwmon/ams/ams.h       |    2 +-
>  sound/aoa/soundbus/soundbus.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> These are the last two users of asm/of_device.h.  If everyone is happy,
> we can put this through the powerpc tree.  I have build tested for
> ppc64_defconfig and ppc6xx_defconfig (which uses the relevant drivers).
> 
> After this we can remove the include of linux/of_device.h from
> asm/of_device.h
> 
> diff --git a/drivers/hwmon/ams/ams.h b/drivers/hwmon/ams/ams.h
> index a6221e5..221ef69 100644
> --- a/drivers/hwmon/ams/ams.h
> +++ b/drivers/hwmon/ams/ams.h
> @@ -4,7 +4,7 @@
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> -#include <asm/of_device.h>
> +#include <linux/of_device.h>
>  
>  enum ams_irq {
>  	AMS_IRQ_FREEFALL = 0x01,
> diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
> index 622cd37..a0f223c 100644
> --- a/sound/aoa/soundbus/soundbus.h
> +++ b/sound/aoa/soundbus/soundbus.h
> @@ -8,7 +8,7 @@
>  #ifndef __SOUNDBUS_H
>  #define __SOUNDBUS_H
>  
> -#include <asm/of_device.h>
> +#include <linux/of_device.h>
>  #include <sound/pcm.h>
>  #include <linux/list.h>
>  

No objection from me, go ahead.

-- 
Jean Delvare
