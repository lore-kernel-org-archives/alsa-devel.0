From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Call snd_soc_unregister_dais instead
 of snd_soc_unregister_dai in sh4_soc_dai_remove
Date: Thu, 25 Nov 2010 10:48:23 +0000
Message-ID: <1290682103.3302.16.camel@odin>
References: <1290677035.1928.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 605B3103C1C
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:48:27 +0100 (CET)
Received: by wwe15 with SMTP id 15so776904wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:48:27 -0800 (PST)
In-Reply-To: <1290677035.1928.3.camel@mola>
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
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 17:23 +0800, Axel Lin wrote:
> We call snd_soc_register_dais() in sh4_soc_dai_probe(),
> thus we should call snd_soc_unregister_dais() in sh4_soc_dai_remove().
> 
> Otherwise, we got "too many arguments to function 'snd_soc_unregister_dai'"
> error message.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/sh/ssi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
> index 40bbdf1..05192d9 100644
> --- a/sound/soc/sh/ssi.c
> +++ b/sound/soc/sh/ssi.c
> @@ -387,7 +387,7 @@ static int __devinit sh4_soc_dai_probe(struct platform_device *pdev)
>  
>  static int __devexit sh4_soc_dai_remove(struct platform_device *pdev)
>  {
> -	snd_soc_unregister_dai(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
> +	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
>  	return 0;
>  }
>  

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
