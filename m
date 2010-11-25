From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: davinci-vcif - fix a memory leak
Date: Thu, 25 Nov 2010 10:46:55 +0000
Message-ID: <1290682015.3302.12.camel@odin>
References: <1290655994.30158.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A0769103BD7
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:46:59 +0100 (CET)
Received: by wyi11 with SMTP id 11so747107wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:46:59 -0800 (PST)
In-Reply-To: <1290655994.30158.1.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 11:33 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/davinci/davinci-vcif.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
> index fb4cc1e..9d2afcc 100644
> --- a/sound/soc/davinci/davinci-vcif.c
> +++ b/sound/soc/davinci/davinci-vcif.c
> @@ -247,7 +247,10 @@ fail:
>  
>  static int davinci_vcif_remove(struct platform_device *pdev)
>  {
> +	struct davinci_vcif_dev *davinci_vcif_dev = dev_get_drvdata(&pdev->dev);
> +
>  	snd_soc_unregister_dai(&pdev->dev);
> +	kfree(davinci_vcif_dev);
>  
>  	return 0;
>  }

Acked-by: Liam Girdwood <lrg@slimlogic.o.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
