From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH] MAINTAINERS: Remove Jaroslav Kysela
Date: Fri, 08 Nov 2013 08:28:09 +0100
Message-ID: <527C9289.5000409@perex.cz>
References: <1383854696.9263.25.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EC95D26560F
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 08:28:09 +0100 (CET)
In-Reply-To: <1383854696.9263.25.camel@joe-AO722>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Date 7.11.2013 21:04, Joe Perches wrote:
> Jaroslav hasn't acked or signed a patch in quite awhile.

It does not mean that I'm not willing to continue the kernel code
maintenance when Takashi is offline. Keep me in. You may reorder M: lines.

> Mark ISAPnp and HP VG/AnyLAN driver as orphan.

I agree.

> 
> Add sound to his CREDITS entry.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  CREDITS     | 1 +
>  MAINTAINERS | 7 ++-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 0640e16..01a1b34 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2021,6 +2021,7 @@ E: perex@perex.cz
>  W: http://www.perex.cz
>  D: Original Author and Maintainer for HP 10/100 Mbit Network Adapters
>  D: ISA PnP
> +D: ALSA/Sound
>  S: Sindlovy Dvory 117
>  S: 370 01  Ceske Budejovice
>  S: Czech Republic
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 831b869..8706839 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3983,8 +3983,7 @@ S:	Orphan
>  F:	drivers/platform/x86/tc1100-wmi.c
>  
>  HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
> -M:	Jaroslav Kysela <perex@perex.cz>
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/net/ethernet/hp/hp100.*
>  
>  HPET:	High Precision Event Timers driver
> @@ -4600,8 +4599,7 @@ F:	include/linux/irqdomain.h
>  F:	kernel/irq/irqdomain.c
>  
>  ISAPNP
> -M:	Jaroslav Kysela <perex@perex.cz>
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/isapnp.txt
>  F:	drivers/pnp/isapnp/
>  F:	include/linux/isapnp.h
> @@ -7818,7 +7816,6 @@ S:	Maintained
>  F:	drivers/memstick/core/ms_block.*
>  
>  SOUND
> -M:	Jaroslav Kysela <perex@perex.cz>
>  M:	Takashi Iwai <tiwai@suse.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  W:	http://www.alsa-project.org/
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
