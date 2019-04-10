From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Date: Tue, 9 Apr 2019 21:26:39 -0700
Message-ID: <20190410042638.GB3032@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11AC9F89616
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 06:26:44 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id d1so569887plj.8
 for <alsa-devel@alsa-project.org>; Tue, 09 Apr 2019 21:26:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 03:15:26AM +0000, S.j. Wang wrote:
> The table is not flexible if supported sample rate is not in the
> table, so use a function to replace it.

Could you please elaborate a bit the special use case here?

The table was copied directly from the Reference Manual. We
also have listed all supported input and output sample rates
just right behind that table. If there're missing rates, we
probably should update those two lists also? Otherwise, how
could we have a driver limiting both I/O sample rates while
we still see something not in the table?

> +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int *post_proc)

Please add some comments to this function to explain what it
does, and how it works. And better to rename it to something
like "fsl_asrc_sel_proc".

> +{
> +	bool det_out_op2_cond;
> +	bool det_out_op0_cond;
> +
> +	det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +					((Fsin > 56000) & (Fsout < 56000)));
> +	det_out_op0_cond = (Fsin * 23 < Fsout * 8);

"detect output option condition"? Please explain a bit or add
comments to explain.

> +
> +	/*
> +	 * Not supported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.

Could be "unsupported". And it should fit within one line:
	/* Unsupported case: Tsout > 16.125 * Tsin, and Tsout > 8.125 * Tsin */

> +	 */
> +	if (Fsin * 8 > 129 * Fsout)
> +		*pre_proc = 5;
> +	else if (Fsin * 8 > 65 * Fsout)
> +		*pre_proc = 4;
> +	else if (Fsin * 8 > 33 * Fsout)
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
> +
> +	if (det_out_op2_cond)
> +		*post_proc = 2;
> +	else if (det_out_op0_cond)
> +		*post_proc = 0;
> +	else
> +		*post_proc = 1;
> +
> +	if (*pre_proc == 4 || *pre_proc == 5)
> +		return -EINVAL;

I think you'd better add some necessary comments here too.

> @@ -377,11 +404,17 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
>  			   ASRCTR_IDR(index) | ASRCTR_USR(index));
>  
> +	ret = proc_autosel(inrate, outrate, &pre_proc, &post_proc);
> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

I think we should do this earlier in this function, once We
know the inrate and outrate, instead of having all register
being configured then going for an error-out.

Another thing confuses me: so we could have supported sample
rates in the list but the hardware might not support some of
them because we couldn't calculate their processing options?
