From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add missing break in WM8994 probe
Date: Wed, 10 Aug 2011 22:28:06 +0100
Message-ID: <4E42F7E6.8050406@ti.com>
References: <1312982420-3486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 821F0103913
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 23:28:16 +0200 (CEST)
In-Reply-To: <1312982420-3486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 10/08/11 14:20, Mark Brown wrote:
> This error would have no effect on current silicon revisions, the fall
> through case has the same behaviour.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 1a9ef7f..e1fb844 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3042,6 +3042,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
>  			wm8994->hubs.dcs_readback_mode = 2;
>  			break;
>  		}
> +		break;
>  
>  	case WM8958:
>  		wm8994->hubs.dcs_readback_mode = 1;

Acked-by: Liam Girdwood <lrg@ti.com>
