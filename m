From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Remove unused mutex from WM9090
	driver
Date: Wed, 31 Aug 2011 11:31:07 +0100
Message-ID: <4E5E0D6B.2090109@ti.com>
References: <1314715807-20289-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id A80A024498
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:31:11 +0200 (CEST)
In-Reply-To: <1314715807-20289-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 30/08/11 15:50, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm9090.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
> index 4de1220..f2f3077 100644
> --- a/sound/soc/codecs/wm9090.c
> +++ b/sound/soc/codecs/wm9090.c
> @@ -139,7 +139,6 @@ static const u16 wm9090_reg_defaults[] = {
>  
>  /* This struct is used to save the context */
>  struct wm9090_priv {
> -	struct mutex mutex;
>  	struct wm9090_platform_data pdata;
>  	void *control_data;
>  };
> @@ -663,7 +662,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
>  
>  	i2c_set_clientdata(i2c, wm9090);
>  	wm9090->control_data = i2c;
> -	mutex_init(&wm9090->mutex);
>  
>  	ret =  snd_soc_register_codec(&i2c->dev,
>  			&soc_codec_dev_wm9090,  NULL, 0);

Acked-by: Liam Girdwood <lrg@ti.com>
