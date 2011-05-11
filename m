From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix NULL vs. 0 warning in SSM2602
Date: Wed, 11 May 2011 14:12:27 +0100
Message-ID: <1305119547.3277.11.camel@odin>
References: <1305064982-26328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AEC4F103849
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 15:12:37 +0200 (CEST)
Received: by eyg5 with SMTP id 5so153283eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 06:12:34 -0700 (PDT)
In-Reply-To: <1305064982-26328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, patches@opensource.wolfsonmicro.com, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-11 at 00:03 +0200, Mark Brown wrote:
> sparse complains if 0 is used as a NULL pointer constant.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/ssm2602.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
> index 70099c9..84f4ad5 100644
> --- a/sound/soc/codecs/ssm2602.c
> +++ b/sound/soc/codecs/ssm2602.c
> @@ -137,7 +137,7 @@ SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM2602_PWR, 3, 1),
>  SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
>  SND_SOC_DAPM_PGA("Line Input", SSM2602_PWR, 0, 1, NULL, 0),
>  
> -SND_SOC_DAPM_SUPPLY("Digital Core Power", SSM2602_ACTIVE, 0, 0, 0, 0),
> +SND_SOC_DAPM_SUPPLY("Digital Core Power", SSM2602_ACTIVE, 0, 0, NULL, 0),
>  
>  SND_SOC_DAPM_OUTPUT("LOUT"),
>  SND_SOC_DAPM_OUTPUT("ROUT"),

Acked-by: Liam Girdwood <lrg@ti.com>
