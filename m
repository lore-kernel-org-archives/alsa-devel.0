From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/3] ASoC: Remove redundant -codec from
 WM8903 driver name
Date: Wed, 9 Feb 2011 08:30:30 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F60158@HQMAIL01.nvidia.com>
References: <1297259228-1891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 117F5243B7
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 17:30:47 +0100 (CET)
In-Reply-To: <1297259228-1891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Wednesday, February 09, 2011 6:47 AM:
> It causes noisy -codecs to appear in things like .codec_name.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

> ---
>  sound/soc/codecs/wm8903.c |    2 +-
>  sound/soc/tegra/harmony.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index 27cd8f5..04c3256 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -2134,7 +2134,7 @@ MODULE_DEVICE_TABLE(i2c, wm8903_i2c_id);
> 
>  static struct i2c_driver wm8903_i2c_driver = {
>  	.driver = {
> -		.name = "wm8903-codec",
> +		.name = "wm8903",
>  		.owner = THIS_MODULE,
>  	},
>  	.probe =    wm8903_i2c_probe,
> diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
> index 11e2cb8..d702abe 100644
> --- a/sound/soc/tegra/harmony.c
> +++ b/sound/soc/tegra/harmony.c
> @@ -189,7 +189,7 @@ static int harmony_asoc_init(struct
> snd_soc_pcm_runtime *rtd)
>  static struct snd_soc_dai_link harmony_wm8903_dai = {
>  	.name = "WM8903",
>  	.stream_name = "WM8903 PCM",
> -	.codec_name = "wm8903-codec.0-001a",
> +	.codec_name = "wm8903.0-001a",
>  	.platform_name = "tegra-pcm-audio",
>  	.cpu_dai_name = "tegra-i2s.0",
>  	.codec_dai_name = "wm8903-hifi",
> --
> 1.7.2.3

-- 
nvpublic
