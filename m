From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: fsl_sai: Add missing
	MODULE_DEVICE_TABLE
Date: Tue, 14 Apr 2015 16:19:01 -0700
Message-ID: <20150414231901.GA7544@Asurada-GSX>
References: <1429004007-603-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id DF8B2265456
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 01:19:11 +0200 (CEST)
Received: by pacyx8 with SMTP id yx8so28394931pac.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 16:19:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429004007-603-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 14, 2015 at 11:33:27AM +0200, Alexander Stein wrote:
> This enables module auto-loading when using device tree.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index ec79c3d..1fe9f5d 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -673,6 +673,7 @@ static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,imx6sx-sai", },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, fsl_sai_ids);
>  
>  static struct platform_driver fsl_sai_driver = {
>  	.probe = fsl_sai_probe,
> -- 
> 2.0.5
> 
