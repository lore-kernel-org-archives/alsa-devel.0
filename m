From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: dapm: Mark widgets as dirty when
 a route is added
Date: Fri, 06 Jul 2012 15:04:42 +0100
Message-ID: <1341583482.4963.0.camel@odin>
References: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog136.obsmtp.com (na3sys009aog136.obsmtp.com
	[74.125.149.85]) by alsa0.perex.cz (Postfix) with ESMTP id 373562444A
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 16:04:47 +0200 (CEST)
Received: by werf13 with SMTP id f13so7794694wer.23
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 07:04:45 -0700 (PDT)
In-Reply-To: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-07-05 at 17:27 +0100, Mark Brown wrote:
> If we add a new route at runtime then we'll need to recheck the connections
> to the affected widgets.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index ed1860c..beac5e6 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2250,6 +2250,10 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
>  		path->connect = 0;
>  		return 0;
>  	}
> +
> +	dapm_mark_dirty(wsource, "Route added");
> +	dapm_mark_dirty(wsink, "Route added");
> +
>  	return 0;
>  
>  err:

All

Acked-by: Liam Girdwood <lrg@ti.com>
