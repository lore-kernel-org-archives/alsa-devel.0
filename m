From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix compile error for s6000-i2s.c by
 adding a missing '; ' character
Date: Tue, 30 Nov 2010 11:22:48 +0000
Message-ID: <1291116168.3293.5.camel@odin>
References: <1291081553.18485.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 854DB103933
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 12:22:51 +0100 (CET)
Received: by wwe15 with SMTP id 15so5724603wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 03:22:51 -0800 (PST)
In-Reply-To: <1291081553.18485.3.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, dg@emlix.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-30 at 09:45 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I don't have toolchain to compile s6000, I'm not able to put the error message in the commit log.
> But I know this patch indeed fixes a compile error.
> 
>  sound/soc/s6000/s6000-i2s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
> index 8778faa..3052f64 100644
> --- a/sound/soc/s6000/s6000-i2s.c
> +++ b/sound/soc/s6000/s6000-i2s.c
> @@ -434,7 +434,7 @@ static struct snd_soc_dai_driver s6000_i2s_dai = {
>  		.rate_max = 1562500,
>  	},
>  	.ops = &s6000_i2s_dai_ops,
> -}
> +};
>  
>  static int __devinit s6000_i2s_probe(struct platform_device *pdev)
>  {

I think Daniel was first so I've acked his patch for this.

Thanks

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
