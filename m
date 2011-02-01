From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Tegra: Harmony: Remove redundant !!
Date: Tue, 01 Feb 2011 14:01:09 +0000
Message-ID: <1296568869.3327.13.camel@odin>
References: <1296496817-10128-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ACEB724519
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:01:13 +0100 (CET)
Received: by wwe15 with SMTP id 15so6793375wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:01:13 -0800 (PST)
In-Reply-To: <1296496817-10128-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-31 at 11:00 -0700, Stephen Warren wrote:
> gpio_set_value* should accept logic values not just 0 or 1. The WM8903 GPIO
> driver has been fixed to work this way, so remove the redundant !!
> previously required when it didn't accept values >1.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/harmony.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
> index d1faa63..11e2cb8 100644
> --- a/sound/soc/tegra/harmony.c
> +++ b/sound/soc/tegra/harmony.c
> @@ -132,7 +132,7 @@ static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
>  	struct harmony_audio_platform_data *pdata = harmony->pdata;
>  
>  	gpio_set_value_cansleep(pdata->gpio_spkr_en,
> -				!!SND_SOC_DAPM_EVENT_ON(event));
> +				SND_SOC_DAPM_EVENT_ON(event));
>  
>  	return 0;
>  }

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
