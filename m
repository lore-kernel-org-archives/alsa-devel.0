From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/2] ASoC: da7213: Improve a size
 determination in da7213_i2c_probe()
Date: Fri, 24 Nov 2017 11:49:08 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B11B9@SW-EX-MBX01.diasemi.com>
References: <babe2503-46f1-2e1e-b482-62cd3e89f246@users.sourceforge.net>
 <0ec34e2a-8e18-bc1d-b07f-a606499b3682@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 384AD266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 12:49:10 +0100 (CET)
In-Reply-To: <0ec34e2a-8e18-bc1d-b07f-a606499b3682@users.sourceforge.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support
 Opensource <Support.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 23 November 2017 17:34, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Nov 2017 18:15:30 +0100
> 
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7213.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index d1b77a0e3b74..b2b4e90fc02a 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -1853,8 +1853,7 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
>  	struct da7213_priv *da7213;
>  	int ret;
> 
> -	da7213 = devm_kzalloc(&i2c->dev, sizeof(struct da7213_priv),
> -			      GFP_KERNEL);
> +	da7213 = devm_kzalloc(&i2c->dev, sizeof(*da7213), GFP_KERNEL);
>  	if (!da7213)
>  		return -ENOMEM;
> 
> --
> 2.15.0
