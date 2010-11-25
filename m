From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix SND_PXA2XX_LIB Kconfig warning
Date: Thu, 25 Nov 2010 10:28:41 +0000
Message-ID: <1290680921.3302.7.camel@odin>
References: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F79D103BD7
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:28:45 +0100 (CET)
Received: by wyi11 with SMTP id 11so731354wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:28:45 -0800 (PST)
In-Reply-To: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 00:46 +0300, Dmitry Artamonow wrote:
> Fix following warning observed when SND_PXA2XX_SOC is set and SND_ARM isn't:
> 
> warning: (SND_PXA2XX_AC97 && SOUND && !M68K && SND && SND_ARM && ARCH_PXA ||
> SND_PXA2XX_SOC && SOUND && !M68K && SND && SND_SOC && ARCH_PXA) selects
> SND_PXA2XX_LIB which has unmet direct dependencies (SOUND && !M68K && SND &&
> SND_ARM)
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---
> 
> This is fix for 2.6.37-rc3
> 
>  sound/soc/pxa/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
> index 37f191b..580f485 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -1,6 +1,7 @@
>  config SND_PXA2XX_SOC
>  	tristate "SoC Audio for the Intel PXA2xx chip"
>  	depends on ARCH_PXA
> +	select SND_ARM
>  	select SND_PXA2XX_LIB
>  	help
>  	  Say Y or M if you want to add support for codecs attached to

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
