From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove extra rtd->dev.init_name
 assignment in soc_probe_dai_link
Date: Tue, 21 Sep 2010 14:07:06 +0100
Message-ID: <1285074426.3089.44.camel@odin>
References: <1285072609-22191-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F8841038B0
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:07:11 +0200 (CEST)
Received: by wyb32 with SMTP id 32so5275905wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 06:07:10 -0700 (PDT)
In-Reply-To: <1285072609-22191-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-21 at 15:36 +0300, Jarkko Nikula wrote:
> rtd->dev.init_name is set twice in soc_probe_dai_link. I removed the first
> assignement from dai_link->stream_name since then there won't be sysfs name
> changes and usually dai_link->name seems to fit anyway better for a sysfs
> directory name.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/soc-core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 6001b7f..c8d1596 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1451,7 +1451,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  	snd_soc_dapm_sync(codec);
>  
>  	/* register the rtd device */
> -	rtd->dev.init_name = rtd->dai_link->stream_name;
>  	rtd->dev.release = rtd_release;
>  	rtd->dev.init_name = dai_link->name;
>  	ret = device_register(&rtd->dev);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
