From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 11/23] ASoC: rt5682: use
 devm_snd_soc_register_component()
Date: Thu, 27 Jun 2019 09:43:47 +0200
Message-ID: <20190627094347.6054300a@xxx>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <87mui3iybl.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF8E3F89739
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:39:50 +0200 (CEST)
In-Reply-To: <87mui3iybl.wl-kuninori.morimoto.gx@renesas.com>
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

On 27 Jun 2019 11:00:46 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_soc_register_component,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/rt5682.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
> index 78409dd..a3459ce 100644
> --- a/sound/soc/codecs/rt5682.c
> +++ b/sound/soc/codecs/rt5682.c
> @@ -2662,14 +2662,13 @@ static int rt5682_i2c_probe(struct i2c_client
> *i2c, 
>  	}
>  
> -	return snd_soc_register_component(&i2c->dev,
> &soc_component_dev_rt5682,
> -			rt5682_dai, ARRAY_SIZE(rt5682_dai));
> +	return devm_snd_soc_register_component(&i2c->dev,
> +					&soc_component_dev_rt5682,
> +					rt5682_dai,
> ARRAY_SIZE(rt5682_dai)); }
>  
>  static int rt5682_i2c_remove(struct i2c_client *i2c)
>  {
> -	snd_soc_unregister_component(&i2c->dev);
> -
>  	return 0;
>  }
>  

Can be entirely removed.
