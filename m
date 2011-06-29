From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Change WM9081 speaker output enable
 to	_OUT_DRV
Date: Wed, 29 Jun 2011 16:35:27 +0100
Message-ID: <4E0B463F.90200@ti.com>
References: <1308915922-27465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 692C41038F2
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 17:35:31 +0200 (CEST)
In-Reply-To: <1308915922-27465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.cm>
List-Id: alsa-devel@alsa-project.org

On 24/06/11 12:45, Mark Brown wrote:
> More for neatness than any actual performance improvement.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm9081.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
> index 91c6b39..a469132 100644
> --- a/sound/soc/codecs/wm9081.c
> +++ b/sound/soc/codecs/wm9081.c
> @@ -727,7 +727,7 @@ SND_SOC_DAPM_MIXER_NAMED_CTL("Mixer", SND_SOC_NOPM, 0, 0,
>  SND_SOC_DAPM_PGA("LINEOUT PGA", WM9081_POWER_MANAGEMENT, 4, 0, NULL, 0),
>  
>  SND_SOC_DAPM_PGA("Speaker PGA", WM9081_POWER_MANAGEMENT, 2, 0, NULL, 0),
> -SND_SOC_DAPM_PGA("Speaker", WM9081_POWER_MANAGEMENT, 1, 0, NULL, 0),
> +SND_SOC_DAPM_OUT_DRV("Speaker", WM9081_POWER_MANAGEMENT, 1, 0, NULL, 0),
>  
>  SND_SOC_DAPM_OUTPUT("LINEOUT"),
>  SND_SOC_DAPM_OUTPUT("SPKN"),

Acked-by: Liam Girdwood <lrg@ti.com>
