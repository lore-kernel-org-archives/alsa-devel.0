From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: au1x: fix section mismatch in
 psc-i2s.c
Date: Tue, 13 Jul 2010 11:41:42 +0100
Message-ID: <1279017702.3125.36.camel@odin>
References: <1278940499-16824-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F2924413
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 12:41:52 +0200 (CEST)
Received: by wwb13 with SMTP id 13so231238wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 03:41:47 -0700 (PDT)
In-Reply-To: <1278940499-16824-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-07-12 at 15:14 +0200, Manuel Lauss wrote:
> Annotate platform probe callback with __devinit instead of plain __init.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
>  sound/soc/au1x/psc-i2s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
> index 495be6e..24454c9 100644
> --- a/sound/soc/au1x/psc-i2s.c
> +++ b/sound/soc/au1x/psc-i2s.c
> @@ -300,7 +300,7 @@ struct snd_soc_dai au1xpsc_i2s_dai = {
>  };
>  EXPORT_SYMBOL(au1xpsc_i2s_dai);
>  
> -static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
> +static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
>  {
>  	struct resource *r;
>  	unsigned long sel;


Manuel, thanks for the patch. Could you CC both Mark and I in the future
on future ASoC patches. I almost missed this one. 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
