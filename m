From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: If pmdown_time is zero then
 shut down DAPM immediately
Date: Thu, 09 Feb 2012 08:33:05 +0000
Message-ID: <1328776385.3951.1.camel@odin>
References: <1328731884-12468-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CD63103FE8
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 09:33:23 +0100 (CET)
Received: by wgbdt14 with SMTP id dt14so955870wgb.27
	for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2012 00:33:08 -0800 (PST)
In-Reply-To: <1328731884-12468-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 20:11 +0000, Mark Brown wrote:
> Since we've already got logic to special case immediate teardown of the
> stream we may as well use it if the pmdown_time has been set to zero by
> the application layer instead of scheduling a work item with zero delay.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index ef28dd5..d7bb268 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -369,7 +369,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>  	cpu_dai->runtime = NULL;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		if (codec->ignore_pmdown_time ||
> +		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
>  		    rtd->dai_link->ignore_pmdown_time) {
>  			/* powered down playback stream now */
>  			snd_soc_dapm_stream_event(rtd,

Acked-by: Liam Girdwood <lrg@ti.com>
