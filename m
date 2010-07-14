From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] wm8727: add a missing return in
	wm8727_platform_probe
Date: Wed, 14 Jul 2010 15:59:57 +0100
Message-ID: <1279119597.3080.120.camel@odin>
References: <1279105051.2290.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0454B1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 17:00:03 +0200 (CEST)
Received: by wwb13 with SMTP id 13so1379499wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 08:00:03 -0700 (PDT)
In-Reply-To: <1279105051.2290.5.camel@phoenix>
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
Cc: Neil Jones <neil.jones@imgtec.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-07-14 at 18:57 +0800, Axel Lin wrote:
> otherwise the error path will always be executed.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/wm8727.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
> index 1072621..9d1df26 100644
> --- a/sound/soc/codecs/wm8727.c
> +++ b/sound/soc/codecs/wm8727.c
> @@ -127,6 +127,8 @@ static __devinit int wm8727_platform_probe(struct platform_device *pdev)
>  		goto err_codec;
>  	}
>  
> +	return 0;
> +
>  err_codec:
>  	snd_soc_unregister_codec(codec);
>  err:

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
