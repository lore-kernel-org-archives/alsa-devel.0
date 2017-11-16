From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_asrc: Fix line continuation
	format
Date: Thu, 16 Nov 2017 11:01:59 -0800
Message-ID: <20171116190158.GA11301@Asurada-Nvidia>
References: <cover.1510849466.git.joe@perches.com>
 <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id DE771266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:01:50 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id r62so26186pfd.5
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 11:01:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 08:25:46AM -0800, Joe Perches wrote:
> Line continuations with excess spacing causes unexpected output
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 806d39927318..ed683fe8b94a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -288,8 +288,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  
>  	if ((outrate > 8000 && outrate < 30000) &&
>  	    (outrate/inrate > 24 || inrate/outrate > 8)) {
> -		pair_err("exceed supported ratio range [1/24, 8] for \
> -				inrate/outrate: %d/%d\n", inrate, outrate);
> +		pair_err("exceed supported ratio range [1/24, 8] for inrate/outrate: %d/%d\n",
> +			 inrate, outrate);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.15.0
> 
