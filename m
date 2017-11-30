From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: tfa9879: Export OF device ID as
	module alias
Date: Thu, 30 Nov 2017 19:56:54 +0100
Message-ID: <e143d60a-de5f-7d42-1359-a3c0e2e19929@axentia.se>
References: <20171130175616.29073-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50138.outbound.protection.outlook.com [40.107.5.138])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BF6267B18
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 19:57:00 +0100 (CET)
In-Reply-To: <20171130175616.29073-1-javierm@redhat.com>
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
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 2017-11-30 18:56, Javier Martinez Canillas wrote:
> The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
> device was registered via OF, this means that exporting the OF device ID
> table device aliases in the module is not needed. But in order to change
> how the core reports modaliases to user-space, it's better to export it.

Looks ok to me,

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> Before this patch:
> 
> $ modinfo sound/soc/codecs/snd-soc-tfa9879.ko  | grep alias
> alias:          i2c:tfa9879
> 
> After this patch:
> 
> $ modinfo sound/soc/codecs/snd-soc-tfa9879.ko  | grep alias
> alias:          i2c:tfa9879
> alias:          of:N*T*Cnxp,tfa9879C*
> alias:          of:N*T*Cnxp,tfa9879
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
>  sound/soc/codecs/tfa9879.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
> index f8dd67ca0744..e7ca764b5729 100644
> --- a/sound/soc/codecs/tfa9879.c
> +++ b/sound/soc/codecs/tfa9879.c
> @@ -316,6 +316,7 @@ static const struct of_device_id tfa9879_of_match[] = {
>  	{ .compatible = "nxp,tfa9879", },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, tfa9879_of_match);
>  
>  static struct i2c_driver tfa9879_i2c_driver = {
>  	.driver = {
> 
