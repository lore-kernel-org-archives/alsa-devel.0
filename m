From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 01/12] ASoC: Create codec DAPM widgets
 before calling the codecs probe function
Date: Sat, 07 May 2011 19:11:00 +0100
Message-ID: <1304791860.3470.15.camel@odin>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CC5C9103807
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 20:11:05 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3469355wyg.38
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 11:11:04 -0700 (PDT)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
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
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Frysinger <vapier@gentoo.org>, Mike@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-05 at 16:59 +0200, Lars-Peter Clausen wrote:
> This allows to create DAPM routes depending on those widgets in the codecs probe
> function.
> This is helpful when supporting similar codecs with minor differences in the DAPM
> routing with the same driver.
> 
> Something similar has already been done for cards in commit a841ebb9(ASoC: Create
> card DAPM widgets early so they can be used in callbacks)
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

These look all OK but I'm not fully following your commit message above
with moving the call to snd_soc_dapm_new_controls() below. Could you
explain why moving the call fixes your issue.

> ---
>  sound/soc/soc-core.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 133edeb..a477e21 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1495,6 +1495,10 @@ static int soc_probe_codec(struct snd_soc_card *card,
>  
>  	soc_init_codec_debugfs(codec);
>  
> +	if (driver->dapm_widgets)
> +		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
> +					  driver->num_dapm_widgets);
> +
>  	if (driver->probe) {
>  		ret = driver->probe(codec);
>  		if (ret < 0) {
> @@ -1508,9 +1512,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
>  	if (driver->controls)
>  		snd_soc_add_controls(codec, driver->controls,
>  				     driver->num_controls);
> -	if (driver->dapm_widgets)
> -		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
> -					  driver->num_dapm_widgets);
>  	if (driver->dapm_routes)
>  		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
>  					driver->num_dapm_routes);
