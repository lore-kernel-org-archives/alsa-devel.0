From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ak4642: Revive ak4642_snd_controls
Date: Fri, 03 Sep 2010 10:43:23 +0100
Message-ID: <1283507003.3069.29.camel@odin>
References: <w3p8w3jb8rf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 84E842437B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 11:43:43 +0200 (CEST)
Received: by wyb32 with SMTP id 32so1441123wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 02:43:43 -0700 (PDT)
In-Reply-To: <w3p8w3jb8rf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-03 at 16:12 +0900, Kuninori Morimoto wrote:
> This patch revive ak4642_snd_controls which was removed on
> f0fba2ad1b6b53d5360125c41953b7afcd6deff0
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/ak4642.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
> index 31b35e9..c84cc9c 100644
> --- a/sound/soc/codecs/ak4642.c
> +++ b/sound/soc/codecs/ak4642.c
> @@ -424,6 +424,8 @@ static int ak4642_probe(struct snd_soc_codec *codec)
>  	codec->hw_write		= (hw_write_t)i2c_master_send;
>  	codec->control_data = ak4642->control_data;
>  
> +	snd_soc_add_controls(codec, ak4642_snd_controls,
> +			     ARRAY_SIZE(ak4642_snd_controls));
>  
>  	return 0;
>  }
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
