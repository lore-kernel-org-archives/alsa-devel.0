From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove excessively verbose logging
 on I2C write
Date: Tue, 05 Apr 2011 08:33:57 +0100
Message-ID: <1301988837.14075.107.camel@vega>
References: <1301896652-24701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 206661039B4
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 09:34:02 +0200 (CEST)
Received: by wwf26 with SMTP id 26so80585wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2011 00:34:01 -0700 (PDT)
In-Reply-To: <1301896652-24701-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2011-04-04 at 14:57 +0900, Mark Brown wrote:
> We don't need to log every I2C transfer, and certainly not at error level.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 22b0990..5655fce 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -245,7 +245,6 @@ static unsigned int do_i2c_read(struct snd_soc_codec *codec,
>  	xfer[1].buf = data;
>  
>  	ret = i2c_transfer(client->adapter, xfer, 2);
> -	dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
>  	if (ret == 2)
>  		return 0;
>  	else if (ret < 0)

Acked-by: Liam Girdwood <lrg@ti.com>
