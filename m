From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Initialize
 codec->control_data before using it
Date: Wed, 28 Sep 2011 09:26:44 +0200
Message-ID: <4E82CC34.10204@metafoo.de>
References: <1317194488.2498.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-141.synserver.de (smtp-out-142.synserver.de
	[212.40.185.142])
	by alsa0.perex.cz (Postfix) with SMTP id 23978103A0E
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 09:27:05 +0200 (CEST)
In-Reply-To: <1317194488.2498.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/28/2011 09:21 AM, Axel Lin wrote:
> Currently codec->control_data is not initialized before calling
> process_sigma_firmware(codec->control_data, ADAU1701_FIRMWARE).
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  sound/soc/codecs/adau1701.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index b7e4cc7..8b7e1c5 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -458,6 +458,7 @@ static int adau1701_probe(struct snd_soc_codec *codec)
>  	int ret;
>  
>  	codec->dapm.idle_bias_off = 1;
> +	codec->control_data = to_i2c_client(codec->dev);
>  
>  	ret = adau1701_load_firmware(codec);
>  	if (ret)
