From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-vcif: Use
	devm_snd_soc_register_component
Date: Mon, 17 Aug 2015 10:36:18 +0300
Message-ID: <55D18EF2.8090300@ti.com>
References: <20150815023155.GA27364@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id F3356260577
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 09:36:24 +0200 (CEST)
In-Reply-To: <20150815023155.GA27364@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 08/15/2015 05:31 AM, Vaishali Thakkar wrote:
> Use resource managed function devm_snd_soc_register_component for
> component registration instead of snd_soc_register_component.
> =

> Also, remove davinci_vcif_remove as it is now redundant.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
>  sound/soc/davinci/davinci-vcif.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci=
-vcif.c
> index fabd05f..c77d921 100644
> --- a/sound/soc/davinci/davinci-vcif.c
> +++ b/sound/soc/davinci/davinci-vcif.c
> @@ -231,8 +231,9 @@ static int davinci_vcif_probe(struct platform_device =
*pdev)
>  =

>  	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
>  =

> -	ret =3D snd_soc_register_component(&pdev->dev, &davinci_vcif_component,
> -					 &davinci_vcif_dai, 1);
> +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> +					      &davinci_vcif_component,
> +					      &davinci_vcif_dai, 1);
>  	if (ret !=3D 0) {
>  		dev_err(&pdev->dev, "could not register dai\n");
>  		return ret;
> @@ -241,23 +242,14 @@ static int davinci_vcif_probe(struct platform_devic=
e *pdev)
>  	ret =3D edma_pcm_platform_register(&pdev->dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
> -		snd_soc_unregister_component(&pdev->dev);
>  		return ret;
>  	}
>  =

>  	return 0;
>  }
>  =

> -static int davinci_vcif_remove(struct platform_device *pdev)
> -{
> -	snd_soc_unregister_component(&pdev->dev);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver davinci_vcif_driver =3D {
>  	.probe		=3D davinci_vcif_probe,
> -	.remove		=3D davinci_vcif_remove,
>  	.driver		=3D {
>  		.name	=3D "davinci-vcif",
>  	},
> =



-- =

P=E9ter
