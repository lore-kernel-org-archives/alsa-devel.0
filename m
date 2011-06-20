From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch] ASoC: adau1701: signedness bug in
	adau1701_write()
Date: Mon, 20 Jun 2011 12:03:02 +0200
Message-ID: <4DFF1AD6.4090103@metafoo.de>
References: <20110620071125.GG14591@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 10F622441D
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 12:04:44 +0200 (CEST)
In-Reply-To: <20110620071125.GG14591@shale.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: "open list:SOUND - SOC LAYER..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/20/2011 09:11 AM, Dan Carpenter wrote:
> "ret" is supposed to be signed here.  The current code will only
> return -EIO on error, instead of a more appropriate error code such
> as -EAGAIN etc.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index 6c01bb6..2758d5f 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -140,9 +140,10 @@ static unsigned int adau1701_register_size(struct snd_soc_codec *codec,
>  static int adau1701_write(struct snd_soc_codec *codec, unsigned int reg,
>  		unsigned int value)
>  {
> -	unsigned int i, ret;
> +	unsigned int i;
>  	unsigned int size;
>  	uint8_t buf[4];
> +	int ret;
>  
>  	size = adau1701_register_size(codec, reg);
>  	if (size == 0)
