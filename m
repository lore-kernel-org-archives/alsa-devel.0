From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: mcbsp: Trivial cleanup in
	asoc-ti-mcbsp.h
Date: Mon, 30 Dec 2013 08:52:40 +0200
Message-ID: <52C11838.6030107@ti.com>
References: <1388380068-31424-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 933A42616B8
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 07:52:44 +0100 (CET)
In-Reply-To: <1388380068-31424-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, trivial@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On 12/30/2013 07:07 AM, Sachin Kamat wrote:
> Commit 2203747c9771 ("ARM: omap: move platform_data definitions")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  include/linux/platform_data/asoc-ti-mcbsp.h |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/=
platform_data/asoc-ti-mcbsp.h
> index c78d90b28b19..3c73c045f8da 100644
> --- a/include/linux/platform_data/asoc-ti-mcbsp.h
> +++ b/include/linux/platform_data/asoc-ti-mcbsp.h
> @@ -1,6 +1,4 @@
>  /*
> - * arch/arm/plat-omap/include/mach/mcbsp.h
> - *
>   * Defines for Multi-Channel Buffered Serial Port
>   *
>   * Copyright (C) 2002 RidgeRun, Inc.
> @@ -21,8 +19,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA
>   *
>   */
> -#ifndef __ASM_ARCH_OMAP_MCBSP_H
> -#define __ASM_ARCH_OMAP_MCBSP_H
> +#ifndef __ASOC_TI_MCBSP_H
> +#define __ASOC_TI_MCBSP_H
>  =

>  #include <linux/spinlock.h>
>  #include <linux/clk.h>
> =



-- =

P=E9ter
