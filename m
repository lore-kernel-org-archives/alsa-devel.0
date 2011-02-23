From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] pxa: Enable pxa-pcm-audio on
 pxa210/pxa25x platform
Date: Wed, 23 Feb 2011 21:13:04 +0000
Message-ID: <1298495584.3396.222.camel@odin>
References: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 8BBA424416
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 22:13:07 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 28so3687195wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 13:13:07 -0800 (PST)
In-Reply-To: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-23 at 02:29 +0300, Dmitry Eremin-Solenikov wrote:
> pxa25x platforms were left out of major ASoC Update patch.
> Since f0fba2ad1b a registration of pxa-pcm-audio device is required for
> ASoC to function on pxa platforms. Register one also for pxa210/pxa25x.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/mach-pxa/pxa25x.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
> index fbc5b77..b166b1d 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -347,6 +347,7 @@ static struct platform_device *pxa25x_devices[] __initdata = {
>  	&pxa25x_device_assp,
>  	&pxa25x_device_pwm0,
>  	&pxa25x_device_pwm1,
> +	&pxa_device_asoc_platform,
>  };
>  
>  static struct sys_device pxa25x_sysdev[] = {

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
