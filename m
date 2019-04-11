From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Thu, 11 Apr 2019 13:06:03 -0700
Message-ID: <20190411200602.GA13170@Asurada-Nvidia.nvidia.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com>
 <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 11, 2019 at 09:39:06AM +0000, S.j. Wang wrote:
  
> +/*
> + * Select the pre-processing and post-processing options

By aligning with other function comments:
/**
 * Select the pre-processing and post-processing options

> + *
> + * Fsin: input sample rate
> + * Fsout: output sample rate

I would suggest to use inrate and outrate to keep naming consistent.

> + * pre_proc: return value for pre-processing option
> + * post_proc: return value for post-processing option
> + */
> +static int fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)
> +{
> +	bool det_out_op2_cond;
> +	bool det_out_op0_cond;

By looking at the comments below. Probably better to rename them
	bool post_proc_cond2, post_proc_cond0;

> +	/* Codition for selection of post-processing */

"Codition" -> "Conditions"

> +	det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +					((Fsin > 56000) & (Fsout < 56000)));

Combining Daniel's comments + indentation alignment:
	det_out_op2_cond = (Fsin * 15 > Fsout * 16 && Fsout < 56000) ||
			   (Fsin > 56000 && Fsout < 56000);

> +	det_out_op0_cond = (Fsin * 23 < Fsout * 8);
> +
> +	/*
> +	 * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.

Funny thing is that there'd be no point in checking the 16.125, if
Tsout is bigger than 8.125 times of Tsin, i.e. only one condition:
	Tsout > 8.125 * Tsin

> +	 * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> +	 * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> +	 * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> +	 * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout

Took me a while to understand what it is saying....

Better to write like this:
	/* Does not support cases: Tsout > 8.125 * Tsin */
	if (Fsin * 8 > 65 * Fsout) {
		pair_err("Does not support %d > 8.125 * %d\n", Fsout, Fsin);
		return -EINVAL;
	}

	/* Otherwise, select pre_proc between [0, 2] */
	if (Fsin * 8 > 33 * Fsout)
> +		*pre_proc = 2;
> +	else if (Fsin * 8 > 15 * Fsout) {
> +		if (Fsin > 152000)
> +			*pre_proc = 2;
> +		else
> +			*pre_proc = 1;
> +	} else if (Fsin < 76000)
> +		*pre_proc = 0;
> +	else if (Fsin > 152000)
> +		*pre_proc = 2;
> +	else
> +		*pre_proc = 1;

<== Would look better by moving post_cond calculations here.

> +	if (det_out_op2_cond)
> +		*post_proc = 2;
> +	else if (det_out_op0_cond)
> +		*post_proc = 0;
> +	else
> +		*post_proc = 1;

And we could remove this check below:
> +	/* unsupported options */
> +	if (*pre_proc == 4 || *pre_proc == 5)
> +		return -EINVAL;

So basically we are doing:
	1) Error out unsupported cases
	2) Select pre_proc
	3) Calculate conditions for post_proc
	4) Select post_proc

Thanks
