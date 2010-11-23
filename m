From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Do not update the cache if write to
	hardware failed
Date: Tue, 23 Nov 2010 09:39:16 +0200
Message-ID: <201011230939.17080.peter.ujfalusi@nokia.com>
References: <1290492847.7286.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 821642437D
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 08:40:50 +0100 (CET)
In-Reply-To: <1290492847.7286.1.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Axel Lin <axel.lin@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 23 November 2010 08:14:07 ext Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/tpa6130a2.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index bfef3da..2d64502 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -77,8 +77,10 @@ static int tpa6130a2_i2c_write(int reg, u8 value)
> 
>  	if (data->power_state) {
>  		val = i2c_smbus_write_byte_data(tpa6130a2_client, reg, value);
> -		if (val < 0)
> +		if (val < 0) {
>  			dev_err(&tpa6130a2_client->dev, "Write failed\n");
> +			return val;
> +		}
>  	}
> 
>  	/* Either powered on or off, we save the context */

Nice catch, thank you!

CC-ing alsa-devel

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
