From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: RX1950: Enable Mic Jack during glue
 driver init
Date: Sun, 09 Jan 2011 13:58:17 +0000
Message-ID: <1294581497.4472.147.camel@odin>
References: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E05D103856
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 14:58:48 +0100 (CET)
Received: by wwe15 with SMTP id 15so18677754wwe.20
	for <alsa-devel@alsa-project.org>; Sun, 09 Jan 2011 05:58:47 -0800 (PST)
In-Reply-To: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-06 at 22:15 +0200, Vasily Khoruzhick wrote:
> Enable Mic Jack during glue driver init, otherwise capture will not work.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/samsung/rx1950_uda1380.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
> index 5a4587e..f400274 100644
> --- a/sound/soc/samsung/rx1950_uda1380.c
> +++ b/sound/soc/samsung/rx1950_uda1380.c
> @@ -246,6 +246,7 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
>  
>  	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
>  	snd_soc_dapm_enable_pin(dapm, "Speaker");
> +	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
>  
>  	snd_soc_dapm_sync(dapm);
>  
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
