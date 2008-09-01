From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Convert tlv320aic3x to a new-style
	i2c driver
Date: Mon, 1 Sep 2008 14:31:14 +0300
Message-ID: <20080901143114.e98543a1.jarkko.nikula@nokia.com>
References: <20080901112131.08cdbb59@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 378442434F
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 13:31:36 +0200 (CEST)
In-Reply-To: <20080901112131.08cdbb59@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2008 11:21:31 +0200
"ext Jean Delvare" <khali@linux-fr.org> wrote:

> Convert the tlv320aic3x codec driver to the new (standard) device
> driver binding model.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Vladimir Barinov <vbarinov@ru.mvista.com>
> Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> Warning: this assumes that the davinci-evm and n810 have their codec
> chips on I2C bus 0, which may or may not be the case. Someone with
> these machines please test and report.
> 
...
> linux-2.6.27-rc5/sound/soc/omap/n810.c	2008-09-01
> 08:30:10.000000000 +0200 @@ -290,6 +290,7 @@ static struct
> snd_soc_machine snd_soc_ma /* Audio private data */
>  static struct aic3x_setup_data n810_aic33_setup = {
> +	.i2c_bus = 0,

Thanks. In N810 it's connected into second i2c bus so this makes it
working

 +	.i2c_bus = 2,


Jarkko
