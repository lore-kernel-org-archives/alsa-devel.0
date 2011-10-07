From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: Suppress early calls to
	snd_soc_dapm_sync()
Date: Fri, 07 Oct 2011 17:18:19 +0300
Message-ID: <1381533.VkWoivMzrE@barack>
References: <1317994442-21459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 36C3C103BA6
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 16:18:01 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 5so577650eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 07:17:52 -0700 (PDT)
In-Reply-To: <1317994442-21459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 07 October 2011 14:34:02 Mark Brown wrote:
> Ensure we only have one sync during the initial startup of the card by
> making snd_soc_dapm_sync() a noop on non-instantiated cards. This avoids
> any bounces due to things like jacks reporting their initial state on
> partially initialised cards. The callers that don't also get called at
> runtime should just be removed.
> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    1 +
>  sound/soc/soc-dapm.c |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 2a25076..b65e3d4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1498,6 +1498,7 @@ static void snd_soc_instantiate_card(struct
> snd_soc_card *card) #endif
> =

>  	card->instantiated =3D 1;
> +	snd_soc_dapm_sync(&card->dapm);

Without prior snd_soc_dapm_new_widgets() call we just moved the kernel crash
here.

>  	mutex_unlock(&card->mutex);
>  	return;
> =

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 8711aab..e49c56d 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -1845,6 +1845,13 @@ static int snd_soc_dapm_set_pin(struct
> snd_soc_dapm_context *dapm, */
>  int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
>  {
> +	/*
> +	 * Suppress early reports (eg, jacks syncing their state) to avoid
> +	 * silly DAPM runs during card startup.
> +	 */
> +	if (!dapm->card || !dapm->card->instantiated)
> +		return 0;
> +
>  	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);

--
P=E9ter
