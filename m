From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2]ASoC:blackfin:add ad73311 card driver
 name
Date: Tue, 13 Sep 2011 17:11:36 +0100
Message-ID: <1315930296.5157.13.camel@odin>
References: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EFD6103962
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 18:11:47 +0200 (CEST)
Received: by mail-wy0-f175.google.com with SMTP id 19so701601wyf.20
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 09:11:40 -0700 (PDT)
In-Reply-To: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 14:59 -0400, Scott Jiang wrote:
> Add driver_name in snd_soc_card, asoc will copy this name to driver field of snd_card.
> ALSA lib need this info to load the proper card config.
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
> ---
>  sound/soc/blackfin/bf5xx-ad73311.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
> index 732a247..975c6e8 100644
> --- a/sound/soc/blackfin/bf5xx-ad73311.c
> +++ b/sound/soc/blackfin/bf5xx-ad73311.c
> @@ -192,6 +192,7 @@ static struct snd_soc_dai_link bf5xx_ad73311_dai[] = {
>  
>  static struct snd_soc_card bf5xx_ad73311 = {
>  	.name = "bfin-ad73311",
> +	.driver_name = "AD73311",
>  	.probe = bf5xx_probe,
>  	.dai_link = &bf5xx_ad73311_dai[CONFIG_SND_BF5XX_SPORT_NUM],
>  	.num_links = 1,

Acked-by: Liam Girdwood <lrg@ti.com>
