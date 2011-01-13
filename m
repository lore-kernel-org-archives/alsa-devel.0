From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin TDM: fix missed
 snd_soc_dai_get_drvdata update
Date: Thu, 13 Jan 2011 13:55:25 +0000
Message-ID: <20110113135525.GD11840@opensource.wolfsonmicro.com>
References: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A465103B06
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:55:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 11:08:19PM -0500, Mike Frysinger wrote:
> One spot was missed in this driver when converting from
> snd_soc_dai.private_data to snd_soc_dai_get_drvdata.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Ccing in Liam - Mike, please remember to CC maintainers on patches - and
dropping the stable lists for now.


> ---
>  sound/soc/blackfin/bf5xx-tdm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
> index 1251239..b2cf239 100644
> --- a/sound/soc/blackfin/bf5xx-tdm.c
> +++ b/sound/soc/blackfin/bf5xx-tdm.c
> @@ -210,7 +210,7 @@ static int bf5xx_tdm_set_channel_map(struct snd_soc_dai *dai,
>  #ifdef CONFIG_PM
>  static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
>  {
> -	struct sport_device *sport = dai->private_data;
> +	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
>  
>  	if (!dai->active)
>  		return 0;
> -- 
> 1.7.4.rc1
> 
