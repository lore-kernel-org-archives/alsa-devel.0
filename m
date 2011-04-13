From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/5] ASoC: Make struct snd_soc_card's
 dapm_widgets and dapm_routes const
Date: Wed, 13 Apr 2011 08:39:02 +0100
Message-ID: <1302680342.3600.10.camel@odin>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 16F5410381A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:39:07 +0200 (CEST)
Received: by wyg36 with SMTP id 36so284810wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:39:06 -0700 (PDT)
In-Reply-To: <1302629465-21315-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 19:31 +0200, Lars-Peter Clausen wrote:
> Those should not be modified (and are not) by the core code, so make them const.
> This also makes them consistent with the same members of snd_soc_codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  include/sound/soc.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 435cb83..cb6b18b 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -755,9 +755,9 @@ struct snd_soc_card {
>  	/*
>  	 * Card-specific routes and widgets.
>  	 */
> -	struct snd_soc_dapm_widget *dapm_widgets;
> +	const struct snd_soc_dapm_widget *dapm_widgets;
>  	int num_dapm_widgets;
> -	struct snd_soc_dapm_route *dapm_routes;
> +	const struct snd_soc_dapm_route *dapm_routes;
>  	int num_dapm_routes;
>  
>  	struct work_struct deferred_resume_work;

Patch 1,3,4 & 5 

Acked-by: Liam Girdwood <lrg@ti.com>
