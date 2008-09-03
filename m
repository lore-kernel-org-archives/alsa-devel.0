From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Wed, 3 Sep 2008 17:01:46 +0100
Message-ID: <200809031701.46791.gineera@aspect135.co.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E7D103801
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 17:56:17 +0200 (CEST)
In-Reply-To: <1220291224-11269-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Monday 01 September 2008 18:47, Mark Brown wrote:
> From: Cliff Cai <cliff.cai@analog.com>
>
> [Modified to allow runtime selection between I2C and SPI and to select
> SPI_MASTER for all codecs build so this is included. -- broonie]
>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

What architecture has this SPI code been tested on?  Specifically, what 
endianess?

> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c

 
> +static int wm8731_spi_write(struct spi_device *spi, const char *data, int
> len) +{
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	u16 msg[2];
> +
> +	if (len <= 0)
> +		return 0;
> +
> +	msg[0] = (data[0] << 8) + data[1];
> +
> +	spi_message_init(&m);
> +	memset(&t, 0, (sizeof t));
> +
> +	t.tx_buf = &msg[0];
> +	t.len = len;
> +
> +	spi_message_add_tail(&t, &m);
> +	spi_sync(spi, &m);
> +
> +	return len;
> +}

Is this _spi_write arch BE/LE proof?

Alan
