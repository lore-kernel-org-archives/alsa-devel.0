From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: codecs: adau1701: refactor
 firmware loading function
Date: Thu, 23 May 2013 15:13:23 +0200
Message-ID: <519E15F3.2090702@metafoo.de>
References: <1369310281-4323-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-096.synserver.de (smtp-out-099.synserver.de
 [212.40.185.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 92F8D261A20
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:13:35 +0200 (CEST)
In-Reply-To: <1369310281-4323-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/23/2013 01:58 PM, Daniel Mack wrote:
> Pass a struct i2c_client * to adau1701_load_firmware directly to make
> the code more readable.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/adau1701.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index dafdbe8..95e1677 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -180,9 +180,9 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
>  	return value;
>  }
>  
> -static int adau1701_load_firmware(struct snd_soc_codec *codec)
> +static int adau1701_load_firmware(struct i2c_client *client)
>  {
> -	return process_sigma_firmware(codec->control_data, ADAU1701_FIRMWARE);
> +	return process_sigma_firmware(client, ADAU1701_FIRMWARE);
>  }
>  
>  static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
> @@ -455,10 +455,11 @@ static struct snd_soc_dai_driver adau1701_dai = {
>  static int adau1701_probe(struct snd_soc_codec *codec)
>  {
>  	int ret;
> +	struct i2c_client *client = to_i2c_client(codec->dev);
>  
> -	codec->control_data = to_i2c_client(codec->dev);
> +	codec->control_data = client;
>  
> -	ret = adau1701_load_firmware(codec);
> +	ret = adau1701_load_firmware(client);
>  	if (ret)
>  		dev_warn(codec->dev, "Failed to load firmware\n");
>  
