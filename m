From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: tlv320aic3x: Allow driver to use
	already	registered i2c device
Date: Fri, 7 Aug 2009 10:43:01 +0100
Message-ID: <20090807094301.GA639@sirena.org.uk>
References: <20090806230204.992074844@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A1341038B0
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 11:43:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090806230204.992074844@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 07, 2009 at 12:02:05AM +0100, Ben Dooks wrote:
> Add the ability for the driver to use an already registered i2c device
> instead of creating one of them itself. Add the field i2c_already field
> to the setup data and not set the i2c bus address the driver will then
> use the device already setup.

Why would you want to do this?  I suspect that perhaps you want to
convert the driver to use the standard device model instead but without
understanding your motivation for making this change it is very hard to
comment in detail.

> --- a/sound/soc/codecs/tlv320aic3x.c	2009-08-06 11:53:30.000000000 +0100
> +++ b/sound/soc/codecs/tlv320aic3x.c	2009-08-06 15:29:45.000000000 +0100
> @@ -1310,6 +1310,7 @@ static int aic3x_i2c_remove(struct i2c_c
>  
>  static const struct i2c_device_id aic3x_i2c_id[] = {
>  	{ "tlv320aic3x", 0 },
> +	{ "tlv320aic33", 0 },
>  	{ }
>  };

This is a reasonable but unrelated change.
