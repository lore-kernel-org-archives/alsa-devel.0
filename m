From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix overwriting of
	ahclkx
Date: Fri, 29 Apr 2016 16:19:31 +0300
Message-ID: <94fc59a7-7f27-bc97-328e-33f1e7c1cb65@ti.com>
References: <1461600490-19504-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A5BD2261483
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 15:20:22 +0200 (CEST)
In-Reply-To: <1461600490-19504-1-git-send-email-Linux.HWI@garmin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: alsa-devel@alsa-project.org

On 04/25/2016 07:08 PM, J.D. Schroeder wrote:
> From: Jim Lodes <jim.lodes@garmin.com>
> =

> The mcasp davinci_mcasp_set_dai_fmt function was overriding ahclkx
> input/output status that had already been set by the
> davinci_mcasp_set_sysclk function. This commit removes clearing
> of the ahclkx input/output status from davinci_mcasp_set_dai_fmt.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index e132498..a1197ad 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -489,7 +489,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_d=
ai *cpu_dai,
>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
>  =

>  		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
> -			       ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
> +			       ACLKX | AFSX | ACLKR | AHCLKR | AFSR);
>  		mcasp->bclk_master =3D 0;
>  		break;
>  	default:
> =



-- =

P=E9ter
