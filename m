From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Trivial formatting fix in soc-core.c
Date: Mon, 1 Aug 2011 14:10:17 +0100
Message-ID: <4E36A5B9.5060100@ti.com>
References: <1312174391-10355-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A8460243B7
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 15:10:21 +0200 (CEST)
In-Reply-To: <1312174391-10355-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 01/08/11 05:53, Mark Brown wrote:
> Utterly trivial but it annoys me.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 83ad8ca..e2ce248 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -105,7 +105,7 @@ static int format_register_str(struct snd_soc_codec *codec,
>  	if (wordsize + regsize + 2 + 1 != len)
>  		return -EINVAL;
>  
> -	ret = snd_soc_read(codec , reg);
> +	ret = snd_soc_read(codec, reg);
>  	if (ret < 0) {
>  		memset(regbuf, 'X', regsize);
>  		regbuf[regsize] = '\0';
