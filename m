From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8995: Remember to flush the cache
 on resume
Date: Tue, 11 Jan 2011 10:54:09 +0000
Message-ID: <1294743249.3338.5.camel@odin>
References: <1294738112-6052-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ACDBB103855
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 11:54:12 +0100 (CET)
Received: by wyi11 with SMTP id 11so20423880wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 02:54:12 -0800 (PST)
In-Reply-To: <1294738112-6052-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 09:28 +0000, Dimitris Papastamos wrote:
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8995.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
> index 3d2110c..96e0dc0 100644
> --- a/sound/soc/codecs/wm8995.c
> +++ b/sound/soc/codecs/wm8995.c
> @@ -1498,6 +1498,7 @@ static int wm8995_set_bias_level(struct snd_soc_codec *codec,
>  	case SND_SOC_BIAS_OFF:
>  		snd_soc_update_bits(codec, WM8995_POWER_MANAGEMENT_1,
>  				    WM8995_BG_ENA_MASK, 0);
> +		codec->cache_sync = 1;
>  		break;
>  	}
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
