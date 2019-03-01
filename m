From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the
 asrc of older version
Date: Thu, 28 Feb 2019 18:53:57 -0800
Message-ID: <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1108BF896B8
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 03:54:03 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id j3so10669780pgm.11
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 18:54:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
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

Hi Shengjiu,

On Fri, Mar 01, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> There is a constraint for the channel number setting on the
> asrc of older version (e.g. imx35), the channel number should
> be even, odd number isn't valid.
> 
> So add protection when the asrc of older version is used.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 528e8b108422..b3b3c5e15ef1 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -109,7 +109,8 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  	if (index == ASRC_INVALID_PAIR) {
>  		dev_err(dev, "all pairs are busy now\n");
>  		ret = -EBUSY;
> -	} else if (asrc_priv->channel_avail < channels) {
> +	} else if (asrc_priv->channel_avail < channels ||
> +		(asrc_priv->channel_bits < 4 && channels % 2 != 0)) {
>  		dev_err(dev, "can't afford required channels: %d\n", channels);

I feel it'd be better to have another else-if, since the existing
error message is against something else.

+	} else if (asrc_priv->channel_bits < 4 && channels & 1) {
+		/* old version of ASRC has channel_bits = 3 */
+  		dev_err(dev, "does not support odd channel number\n");
+  		ret = -EINVAL;

Alternatively, I feel instead of error-out at here, should we add
a HW constraint or at least fence it off at the beginning of the
hw_params()? This is actually nothing specific to the pair-request
function but a hardware constraint.
