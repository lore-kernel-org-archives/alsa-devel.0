From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V5 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Date: Sun, 21 Apr 2019 19:49:16 -0700
Message-ID: <20190422024915.GA9768@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a74fe1798ef8f473e11f5e39452664b5e80515df.1555900078.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 02:32:32AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is (1/24, 8). In the driver

Should be [1/24, 8].

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
> 
> Fixes: fff6e03c7b65 ("ASoC: fsl_asrc: add support for 8-30kHz
> output sample rate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0b937924d2e4..ea035c12a325 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -282,8 +282,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> -	if ((outrate > 8000 && outrate < 30000) &&
> -	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> +	if ((outrate >= 8000 && outrate <= 30000) &&
> +	    (outrate > 24 * inrate || inrate > 8 * outrate)) {
>  		pair_err("exceed supported ratio range [1/24, 8] for \
>  				inrate/outrate: %d/%d\n", inrate, outrate);
>  		return -EINVAL;
> -- 
> 1.9.1
> 
