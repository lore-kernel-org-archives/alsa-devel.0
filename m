From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Wed, 17 Apr 2019 11:52:36 -0700
Message-ID: <20190417185236.GC5073@Asurada-Nvidia.nvidia.com>
References: <cover.1555491598.git.shengjiu.wang@nxp.com>
 <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

This looks better. Just a couple of more small comments inline.

On Wed, Apr 17, 2019 at 09:06:18AM +0000, S.j. Wang wrote:

> +static int fsl_asrc_sel_proc(int inrate, int outrate, int *pre_proc,
> +			     int *post_proc)

Just a nit: it looks better by grouping them two-two.

static int fsl_asrc_sel_proc(int inrate, int outrate,
			     int *pre_proc, int *post_proc)

> +	/* Condition for selection of post-processing */
> +	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
> +		(inrate > 56000 && outrate < 56000);

Could align the indentation:
	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
			  (inrate > 56000 && outrate < 56000);

Here:
> +	/* Does not support cases: Tsout > 8.125 * Tsin */
> +	if (inrate * 8 > 65 * outrate)
> +		return -EINVAL;
And here:
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

Instead of a general message, I was thinking of a more specific
one by telling users that the ratio between the two rates isn't
supported -- something similar to what I suggested previously:

	pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
		 outrate, inrate);

Thanks
Nicolin
