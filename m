From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: OMAP3 Pandora: update for TWL4030
 codec changes
Date: Sun, 08 Nov 2009 20:31:17 +0000
Message-ID: <1257712277.15162.3.camel@vega>
References: <1257628572-6049-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id D5EEF24605
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 21:34:22 +0100 (CET)
Received: by ewy21 with SMTP id 21so9212156ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 12:34:21 -0800 (PST)
In-Reply-To: <1257628572-6049-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2009-11-07 at 23:16 +0200, Grazvydas Ignotas wrote:
> A while ago TWL4030 had it's playback stream name changed, but
> pandora needs it for it's playback path. Update to correct stream
> name so that playback works again.
> 
> Also mark VIBRA output as not connected.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  sound/soc/omap/omap3pandora.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index ad219aa..0cd06f5 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -134,7 +134,7 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
>   *  |P| <--- TWL4030 <--------- Line In and MICs
>   */
>  static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
> -	SND_SOC_DAPM_DAC("PCM DAC", "Playback", SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_DAC("PCM DAC", "HiFi Playback", SND_SOC_NOPM, 0, 0),
>  	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
>  			   0, 0, NULL, 0, omap3pandora_hp_event,
>  			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> @@ -181,6 +181,7 @@ static int omap3pandora_out_init(struct snd_soc_codec *codec)
>  	snd_soc_dapm_nc_pin(codec, "CARKITR");
>  	snd_soc_dapm_nc_pin(codec, "HFL");
>  	snd_soc_dapm_nc_pin(codec, "HFR");
> +	snd_soc_dapm_nc_pin(codec, "VIBRA");
>  
>  	ret = snd_soc_dapm_new_controls(codec, omap3pandora_out_dapm_widgets,
>  				ARRAY_SIZE(omap3pandora_out_dapm_widgets));

Acked-by:Liam Girdwood <lrg@slimlogic.co.uk>
