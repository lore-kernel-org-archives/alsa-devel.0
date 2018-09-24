From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs4265: Add a MIC pre. route
Date: Mon, 24 Sep 2018 09:45:37 +0100
Message-ID: <20180924084537.GM1653@imbe.wolfsonmicro.main>
References: <20180923230835.18483-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 4302B267730
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2018 10:45:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180923230835.18483-1-flatmax@flatmax.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2018 at 09:08:35AM +1000, Matt Flax wrote:
> The cs4265 driver is missing a microphone preamp enable.
> This patch enables/disables the microphone preamp when mic
> selection is made using the kcontrol.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/cs4265.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 275677de..332d714a 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -230,6 +230,10 @@ static const struct snd_soc_dapm_route cs4265_audio_map[] = {
>  	{"DAI1 Capture", NULL, "DOUT"},
>  	{"DAI2 Capture", NULL, "DOUT"},
>  
> +	{ "Pre-amp MIC", NULL, "MICL" },
> +	{ "Pre-amp MIC", NULL, "MICR" },
> +	{ "ADC Mux", "MIC", "Pre-amp MIC" },
> +

This looks good but I think you should also remove the existing
routes that put the mic straight into the ADC Mux.

{"ADC Mux", "MIC", "MICL"},
{"ADC Mux", "MIC", "MICR"},

Thanks,
Charles
