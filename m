From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Remove byte swap in 4x12 SPI
 write
Date: Wed, 11 May 2011 14:37:55 +0100
Message-ID: <1305121075.3277.18.camel@odin>
References: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 532F3103937
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 15:37:59 +0200 (CEST)
Received: by fxm5 with SMTP id 5so396333fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 06:37:59 -0700 (PDT)
In-Reply-To: <1305114833-7553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


On Wed, 2011-05-11 at 13:53 +0200, Mark Brown wrote:
> snd_soc_4_12_spi_write() contains a byte swap. Since this code was written
> for an Analog CODEC on a Blackfin reference board it appears that this is
> done because while Blackfin is little endian the CODEC is big endian (as
> are most CODECs).
> 
> Push this up into the generic 4x12 write function and use cpu_to_be16() to
> do the byte swap so things are more regular and things work on both CPU
> endiannesses.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 6e5e30a..73907e5 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -101,12 +101,11 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
>  static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
>  			      unsigned int value)
>  {
> -	u8 data[2];
> +	u16 data;
>  
> -	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
> -	data[1] = value & 0x00ff;
> +	data = cpu_to_be16((reg << 12) | (value & 0xffffff));
>  
> -	return do_hw_write(codec, reg, value, data, 2);
> +	return do_hw_write(codec, reg, value, &data, 2);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -115,8 +114,8 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
>  {
>  	u8 msg[2];
>  
> -	msg[0] = data[1];
> -	msg[1] = data[0];
> +	msg[0] = data[0];
> +	msg[1] = data[1];
>  
>  	return do_spi_write(control_data, msg, len);
>  }

Both

Acked-by: Liam Girdwood <lrg@ti.com>
