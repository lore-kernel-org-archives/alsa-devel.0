From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Fri, 19 Apr 2019 11:22:42 -0700
Message-ID: <20190419182241.GB1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0f7a6907c73e110c797b478fedaba2fc47b5e994.1555669068.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 19, 2019 at 10:23:53AM +0000, S.j. Wang wrote:

> @@ -289,6 +318,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);

Since the function always return 0, I am thinking of treating
this function as a lookup function, and then moving this call
right before the register settings -- as we have already made
sure that both inrate and outrate are supported.

> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

And probably no longer need this error-out. If there's a new
limitation related to this function, I believe we can add it
to the rate validation section as we are doing now -- better
to have rate validation code at one place.

> @@ -380,8 +415,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* Apply configurations for pre- and post-processing */

Here:
-  	/* Apply configurations for pre- and post-processing */
+  	/* Select and apply configurations for pre- and post-processing */
+	fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
>  	regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>  			   ASRCFG_PREMODi_MASK(index) |	ASRCFG_POSTMODi_MASK(index),
> -			   ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -			   ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +			   ASRCFG_PREMOD(index, pre_proc) |
> +			   ASRCFG_POSTMOD(index, post_proc));
