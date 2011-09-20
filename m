From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: fsl: Fix error handling if
 platform_device_add fails
Date: Tue, 20 Sep 2011 12:21:01 +0100
Message-ID: <1316517661.8314.4.camel@odin>
References: <1316502540.4269.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 70ECB1039F0
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 13:21:09 +0200 (CEST)
Received: by wwf27 with SMTP id 27so618069wwf.12
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 04:21:05 -0700 (PDT)
In-Reply-To: <1316502540.4269.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-20 at 15:09 +0800, Axel Lin wrote:
> Call platform_device_put() instead of platform_device_unregister() if
> platform_device_add() fails.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/fsl/mpc8610_hpcd.c |    2 +-
>  sound/soc/fsl/p1022_ds.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
> index 358f0ba..31af405 100644
> --- a/sound/soc/fsl/mpc8610_hpcd.c
> +++ b/sound/soc/fsl/mpc8610_hpcd.c
> @@ -505,7 +505,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error_sound:
> -	platform_device_unregister(sound_device);
> +	platform_device_put(sound_device);
>  error:
>  	kfree(machine_data);
>  error_alloc:
> diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
> index e8849ed..2c064a9 100644
> --- a/sound/soc/fsl/p1022_ds.c
> +++ b/sound/soc/fsl/p1022_ds.c
> @@ -506,7 +506,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
>  
>  error:
>  	if (sound_device)
> -		platform_device_unregister(sound_device);
> +		platform_device_put(sound_device);
>  
>  	kfree(mdata);
>  error_put:

Acked-by: Liam Girdwood <lrg@ti.com>
