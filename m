From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: S3C: AC97: Remove the -dai suffix
Date: Fri, 10 Sep 2010 12:18:32 +0100
Message-ID: <1284117512.3088.227.camel@odin>
References: <1284104431-14378-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AC6010394B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:18:36 +0200 (CEST)
Received: by wwb22 with SMTP id 22so2633096wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:18:36 -0700 (PDT)
In-Reply-To: <1284104431-14378-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 16:40 +0900, Jassi Brar wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Drop the invalid -dai suffix appended to the Samsung AC97 CPU DAI.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  sound/soc/s3c24xx/smdk2443_wm9710.c |    2 +-
>  sound/soc/s3c24xx/smdk_wm9713.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
> index 66f9e22..4613288 100644
> --- a/sound/soc/s3c24xx/smdk2443_wm9710.c
> +++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
> @@ -28,7 +28,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
>  {
>  	.name = "AC97",
>  	.stream_name = "AC97 HiFi",
> -	.cpu_dai_name = "s3c-ac97-dai",
> +	.cpu_dai_name = "s3c-ac97",
>  	.codec_dai_name = "ac97-hifi",
>  	.codec_name = "ac97-codec",
>  	.platform_name = "s3c24xx-pcm-audio",
> diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
> index 90108a7..11086f8 100644
> --- a/sound/soc/s3c24xx/smdk_wm9713.c
> +++ b/sound/soc/s3c24xx/smdk_wm9713.c
> @@ -47,7 +47,7 @@ static struct snd_soc_dai_link smdk_dai = {
>  	.name = "AC97",
>  	.stream_name = "AC97 PCM",
>  	.platform_name = "s3c24xx-pcm-audio",
> -	.cpu_dai_name = "s3c-ac97-dai",
> +	.cpu_dai_name = "s3c-ac97",
>  	.codec_dai_name = "wm9713-hifi",
>  	.codec_name = "wm9713-codec",
>  };

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
