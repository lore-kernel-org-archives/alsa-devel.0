From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] Add rudimentary device tree support for
 SSM2518
Date: Thu, 13 Aug 2015 14:27:34 +0200
Message-ID: <55CC8D36.6040001@metafoo.de>
References: <alpine.DEB.2.02.1508131404050.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-198.synserver.de (smtp-out-199.synserver.de
 [212.40.185.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 37855261A03
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 14:28:00 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131404050.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/13/2015 02:12 PM, Ricard Wanderlof wrote:
> 
> For some reason the SSM2518 codec driver doesn't have DT support, even 
> though there are bindings described for it in 
> Documentation/devicetree/sound/ssm2518.txt . This patch adds rudimentary 
> DT support for the compatible property which is a step forward.
> 
> Signed-off-by: Ricard Wanderlof <ricardw@axis.com>

Patch looks mostly good, but make sure to use a patch subject that follows
the general style of the subsystem you are sending the patch for. In this
case it should be something like:

ASoC: ssm2518: Add rudimentary device tree support

Also make sure that when you send a patch to add the maintainers of the
subsystem to your receiver list, so they'll see the patch can pick it up. In
this case that is Mark and Liam

One issue inline.

> ---
>  sound/soc/codecs/ssm2518.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
> index 67ea55a..ecf9996 100644
> --- a/sound/soc/codecs/ssm2518.c
> +++ b/sound/soc/codecs/ssm2518.c
[...]
> @@ -821,6 +828,9 @@ static struct i2c_driver ssm2518_driver = {
>  	.driver = {
>  		.name = "ssm2518",
>  		.owner = THIS_MODULE,
> +#ifdef CONFIG_OF
> +		.of_match_table = of_match_ptr(ssm2518_dt_ids),
> +#endif

If you use of_match_ptr() you don't need the #ifdef CONFIG_OF, so just drop
the two lines.

>  	},
>  	.probe = ssm2518_i2c_probe,
>  	.remove = ssm2518_i2c_remove,
> 
