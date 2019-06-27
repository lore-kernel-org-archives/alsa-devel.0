From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 12/23] ASoC: ak4118: use
 devm_snd_soc_register_component()
Date: Thu, 27 Jun 2019 09:43:56 +0200
Message-ID: <20190627094356.51ed48b4@xxx>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <87lfxniybh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 239B9F8973F
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:40:00 +0200 (CEST)
In-Reply-To: <87lfxniybh.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 27 Jun 2019 11:00:50 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_soc_register_component,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/ak4118.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
> index ce419e8..efbe2d6 100644
> --- a/sound/soc/codecs/ak4118.c
> +++ b/sound/soc/codecs/ak4118.c
> @@ -400,13 +400,12 @@ static int ak4118_i2c_probe(struct i2c_client
> *i2c, return ret;
>  	}
>  
> -	return snd_soc_register_component(&i2c->dev,
> &soc_component_drv_ak4118,
> -					  &ak4118_dai, 1);
> +	return devm_snd_soc_register_component(&i2c->dev,
> +				&soc_component_drv_ak4118,
> &ak4118_dai, 1); }
>  
>  static int ak4118_i2c_remove(struct i2c_client *i2c)
>  {
> -	snd_soc_unregister_component(&i2c->dev);
>  	return 0;
>  }
>  

Remove whole function.
