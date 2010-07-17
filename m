From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 13/15] sound/soc: davinci: check kzalloc()
	result (typo)
Date: Sat, 17 Jul 2010 18:45:33 +0100
Message-ID: <1279388733.3070.5.camel@odin>
References: <1279296977-25267-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BDF74103809
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 19:45:35 +0200 (CEST)
Received: by wyf19 with SMTP id 19so3043717wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 10:45:35 -0700 (PDT)
In-Reply-To: <1279296977-25267-1-git-send-email-segooon@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kulikov Vasiliy <segooon@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-07-16 at 20:16 +0400, Kulikov Vasiliy wrote:
> The code checks 'davinci_vc' after kzalloc() and do not checks
> 'davinci_vcif_dev' that kzalloc() result is assigned to. It seems that
> it is a typo (autocompletion?).
> 
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
> ---
>  sound/soc/davinci/davinci-vcif.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
> index 9aa980d..4867853 100644
> --- a/sound/soc/davinci/davinci-vcif.c
> +++ b/sound/soc/davinci/davinci-vcif.c
> @@ -203,7 +203,7 @@ static int davinci_vcif_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	davinci_vcif_dev = kzalloc(sizeof(struct davinci_vcif_dev), GFP_KERNEL);
> -	if (!davinci_vc) {
> +	if (!davinci_vcif_dev) {
>  		dev_dbg(&pdev->dev,
>  			"could not allocate memory for private data\n");
>  		return -ENOMEM;

13,14 & 15

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
