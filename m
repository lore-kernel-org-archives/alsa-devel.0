From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Provide register I/O
	functions by default
Date: Fri, 19 Jul 2013 07:04:43 -0500
Message-ID: <D26B8D96-4ABC-4826-8FC8-3B363A563B46@tabi.org>
References: <1374231334-8400-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id B3FE1265694
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 14:04:44 +0200 (CEST)
In-Reply-To: <1374231334-8400-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org



On Jul 19, 2013, at 5:55 AM, Mark Brown <broonie@kernel.org> wrote:

> From: Mark Brown <broonie@linaro.org>
> 
> Use the ARM version by default as that's the more generally portable
> one, it doesn't matter if they work well on random platforms when the
> goal is only build coverage.

Ack


> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
> sound/soc/fsl/fsl_ssi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index c9974a4..e12a997 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -36,7 +36,7 @@
> #define read_ssi(addr)             in_be32(addr)
> #define write_ssi(val, addr)         out_be32(addr, val)
> #define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
> -#elif defined ARM
> +#else
> #define read_ssi(addr)             readl(addr)
> #define write_ssi(val, addr)         writel(val, addr)
> /*
> -- 
> 1.8.3.2
