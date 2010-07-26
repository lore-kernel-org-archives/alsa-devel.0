From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Capture route DAPM event fix
Date: Mon, 26 Jul 2010 00:06:49 -0700
Message-ID: <EC4B36FE-65AD-4812-8D5A-B21725A3CD49@opensource.wolfsonmicro.com>
References: <1280127555-8042-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100726_075944_269769_57398D82)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10FB51037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 09:06:33 +0200 (CEST)
In-Reply-To: <1280127555-8042-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100726_075944_269769_57398D82)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@Nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 25 Jul 2010, at 23:59, Peter Ujfalusi <peter.ujfalusi@Nokia.com> wrote:

> There is no need to handle POST_PMU, POST_PMD event with
> the Capture Route widget.
> It is enough to handle POST_REG event, since that will come
> when the user changes the routing, and we will switch the needed
> bits in the registers.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> ---
> sound/soc/codecs/twl4030.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index bd557c2..d401c59 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -1432,11 +1432,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
>  	   TX2 Left/Right: either analog Left/Right or Digimic1 */
>  	SND_SOC_DAPM_MUX_E("TX1 Capture Route", SND_SOC_NOPM, 0, 0,
>  		&twl4030_dapm_micpathtx1_control, micpath_event,
> -		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
>  		SND_SOC_DAPM_POST_REG),
>  	SND_SOC_DAPM_MUX_E("TX2 Capture Route", SND_SOC_NOPM, 0, 0,
>  		&twl4030_dapm_micpathtx2_control, micpath_event,
> -		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
>  		SND_SOC_DAPM_POST_REG),
> 
>  	/* Analog input mixers for the capture amplifiers */
> -- 
> 1.7.1.1
> 
