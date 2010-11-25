From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Make SMDK WM8580 driver unloadable
Date: Thu, 25 Nov 2010 10:25:28 +0000
Message-ID: <1290680728.3302.3.camel@odin>
References: <1290619203-27875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A4BB103BC4
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:25:32 +0100 (CET)
Received: by wyi11 with SMTP id 11so728785wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:25:32 -0800 (PST)
In-Reply-To: <1290619203-27875-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-11-24 at 17:20 +0000, Mark Brown wrote:
> Supply a module exit function so that the driver can be unloaded.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/smdk_wm8580.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
> index 0ae3d57..e2d56b9 100644
> --- a/sound/soc/samsung/smdk_wm8580.c
> +++ b/sound/soc/samsung/smdk_wm8580.c
> @@ -280,6 +280,12 @@ static int __init smdk_audio_init(void)
>  }
>  module_init(smdk_audio_init);
>  
> +static void __exit smdk_audio_exit(void)
> +{
> +	platform_device_unregister(smdk_snd_device);
> +}
> +module_exit(smdk_audio_exit);
> +
>  MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
>  MODULE_DESCRIPTION("ALSA SoC SMDK WM8580");
>  MODULE_LICENSE("GPL");

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
