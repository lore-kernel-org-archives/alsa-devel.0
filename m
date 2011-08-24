From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Correct element count for WM8996
	sidetone HPF
Date: Wed, 24 Aug 2011 17:02:03 +0100
Message-ID: <4E55207B.3030506@ti.com>
References: <1314200171-16697-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 962A0103961
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 18:02:06 +0200 (CEST)
In-Reply-To: <1314200171-16697-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 24/08/11 16:36, Mark Brown wrote:
> I can count. Honest.
> 

Hehe

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8996.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
> index 73a1588..3c9080f 100644
> --- a/sound/soc/codecs/wm8996.c
> +++ b/sound/soc/codecs/wm8996.c
> @@ -420,7 +420,7 @@ static const char *sidetone_hpf_text[] = {
>  };
>  
>  static const struct soc_enum sidetone_hpf =
> -	SOC_ENUM_SINGLE(WM8996_SIDETONE, 7, 6, sidetone_hpf_text);
> +	SOC_ENUM_SINGLE(WM8996_SIDETONE, 7, 7, sidetone_hpf_text);
>  
>  static const char *hpf_mode_text[] = {
>  	"HiFi", "Custom", "Voice"


Acked-by: Liam Girdwood <lrg@ti.com>
