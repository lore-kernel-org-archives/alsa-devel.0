From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/7] S3C64XX PCM: Define PCM Controller
	base registers
Date: Mon, 16 Nov 2009 10:47:46 +0000
Message-ID: <20091116104746.GU23772@trinity.fluff.org>
References: <1257914709-4447-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 944C11038A6
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:47:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257914709-4447-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 01:45:09PM +0900, Jassi Brar wrote:
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Should have gone to the linux-arm-kernel list.

Will merge this to my tree.

> ---
>  arch/arm/mach-s3c6400/include/mach/map.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
> index fc8b223..866be31 100644
> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> @@ -48,6 +48,8 @@
>  #define S3C64XX_PA_IIS1		(0x7F003000)
>  #define S3C64XX_PA_TIMER	(0x7F006000)
>  #define S3C64XX_PA_IIC0		(0x7F004000)
> +#define S3C64XX_PA_PCM0		(0x7F009000)
> +#define S3C64XX_PA_PCM1		(0x7F00A000)
>  #define S3C64XX_PA_IISV4	(0x7F00D000)
>  #define S3C64XX_PA_IIC1		(0x7F00F000)
>  
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
