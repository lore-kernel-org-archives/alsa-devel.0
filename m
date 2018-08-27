From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs4265: Add a SPDIF enable actl
Date: Mon, 27 Aug 2018 09:24:23 +0100
Message-ID: <20180827082423.GT32322@imbe.wolfsonmicro.main>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180826225844.13754-3-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 477EA267846
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 10:24:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180826225844.13754-3-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2018 at 08:58:44AM +1000, Matt Flax wrote:
> This patch adds a SPDIF enable/disable toggle switch to the
> sound controls.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/cs4265.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 17d7e6f0..cdfcca9c 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -112,6 +112,13 @@ static const char * const cam_mono_stereo_text[] = {
>  static SOC_ENUM_SINGLE_DECL(spdif_mono_stereo_enum, CS4265_SPDIF_CTL2, 2,
>  		cam_mono_stereo_text);
>  
> +static const char * const spdif_enable_text[] = {
> +	"Enabled", "Disabled"
> +};

If the values are just on/off would not a SOC_SINGLE be more
appropriate?

> +
> +static SOC_ENUM_SINGLE_DECL(spdif_enable_enum, CS4265_SPDIF_CTL2, 5,
> +		spdif_enable_text);
> +
>  static const char * const mono_select_text[] = {
>  	"Channel A", "Channel B"
>  };
> @@ -151,6 +158,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
>  				1, 1),
>  	SOC_SINGLE("ADC Soft Ramp Switch", CS4265_ADC_CTL2, 7,
>  				1, 0),
> +	SOC_ENUM("SPDIF Enable", spdif_enable_enum),

Although you would want to then call this something like "SPDIF
Switch".

>  	SOC_SINGLE("E to F Buffer Disable Switch", CS4265_SPDIF_CTL1,
>  				6, 1, 0),
>  	SOC_ENUM("C Data Access", cam_mode_enum),
> -- 
> 2.17.1

Thanks,
Charles
