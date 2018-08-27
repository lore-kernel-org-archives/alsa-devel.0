From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [EXTERNAL] [PATCH 1/3] ASoC: cs4265: SOC_SINGLE
 register value error fix
Date: Mon, 27 Aug 2018 17:37:38 -0500
Message-ID: <f3a22388-fba4-4ab9-a336-88cd74aa5b3c@EX4.ad.cirrus.com>
References: <20180826225511.13619-1-flatmax@flatmax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C296826787A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 00:37:54 +0200 (CEST)
In-Reply-To: <20180826225511.13619-1-flatmax@flatmax.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matt Flax <flatmax@flatmax.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Sun, 26 Aug 2018, Matt Flax wrote:

> From: Matt Flax <flatmax@flatmax.org>
> 
> The cs4265 driver declares the "MMTLR Data Switch" register setting with
> a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
> This incorrect value causes alsamixer to fault with the output :
> cannot load mixer controls: Input/output error
> 
> This patch corrects the register value. alsamixer now runs.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/cs4265.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 275677de..15b4ae04 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -157,8 +157,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
>  	SOC_SINGLE("Validity Bit Control Switch", CS4265_SPDIF_CTL2,
>  				3, 1, 0),
>  	SOC_ENUM("SPDIF Mono/Stereo", spdif_mono_stereo_enum),
> -	SOC_SINGLE("MMTLR Data Switch", 0,
> -				1, 1, 0),
> +	SOC_SINGLE("MMTLR Data Switch", CS4265_SPDIF_CTL2, 0, 1, 0),
>  	SOC_ENUM("Mono Channel Select", spdif_mono_select_enum),
>  	SND_SOC_BYTES("C Data Buffer", CS4265_C_DATA_BUFF, 24),
>  };

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com> 
