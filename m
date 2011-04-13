From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix mis cherry-pick of wm1250-ev1
 driver
Date: Wed, 13 Apr 2011 08:57:33 +0100
Message-ID: <1302681453.3600.26.camel@odin>
References: <1302583892-14156-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CF9C8103956
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:57:36 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 36so296225wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:57:36 -0700 (PDT)
In-Reply-To: <1302583892-14156-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2011-04-11 at 21:51 -0700, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm1250-ev1.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
> index 9cf699e..14d0716 100644
> --- a/sound/soc/codecs/wm1250-ev1.c
> +++ b/sound/soc/codecs/wm1250-ev1.c
> @@ -73,7 +73,7 @@ static const struct i2c_device_id wm1250_ev1_i2c_id[] = {
>  	{ "wm1250-ev1", 0 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(i2c, wm1250_ev1__id);
> +MODULE_DEVICE_TABLE(i2c, wm1250_ev1_i2c_id);
>  
>  static struct i2c_driver wm1250_ev1_i2c_driver = {
>  	.driver = {

Acked-by: Liam Girdwood <lrg@ti.com>
