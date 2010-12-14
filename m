From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: A few minor stylistic
 changes
Date: Tue, 14 Dec 2010 16:02:50 +0000
Message-ID: <1292342570.3316.20.camel@odin>
References: <1292339736-8567-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 3FE4024641
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 17:02:53 +0100 (CET)
Received: by fxm14 with SMTP id 14so841851fxm.23
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 08:02:53 -0800 (PST)
In-Reply-To: <1292339736-8567-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-14 at 15:15 +0000, Dimitris Papastamos wrote:
> Remove redundant parentheses/spaces in the use of the sizeof
> operator.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> ---
>  sound/soc/soc-cache.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 678fd75..0e17b40 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -85,7 +85,7 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
>  	msg[1] = data[0];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -166,7 +166,7 @@ static int snd_soc_7_9_spi_write(void *control_data, const char *data,
>  	msg[1] = data[1];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -246,7 +246,7 @@ static int snd_soc_8_8_spi_write(void *control_data, const char *data,
>  	msg[1] = data[1];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -326,7 +326,7 @@ static int snd_soc_8_16_spi_write(void *control_data, const char *data,
>  	msg[2] = data[2];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -513,7 +513,7 @@ static int snd_soc_16_8_spi_write(void *control_data, const char *data,
>  	msg[2] = data[2];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -633,7 +633,7 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
>  	msg[3] = data[3];
>  
>  	spi_message_init(&m);
> -	memset(&t, 0, (sizeof t));
> +	memset(&t, 0, sizeof t);
>  
>  	t.tx_buf = &msg[0];
>  	t.len = len;
> @@ -1342,7 +1342,7 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
>  	 * that register.
>  	 */
>  	bmp_size = codec_drv->reg_cache_size;
> -	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof (long),
> +	sync_bmp = kmalloc(BITS_TO_LONGS(bmp_size) * sizeof(long),
>  			   GFP_KERNEL);
>  	if (!sync_bmp) {
>  		ret = -ENOMEM;
