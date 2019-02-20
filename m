From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/6] ASoC: fsl: Fix of-node refcount
 unbalance in fsl_ssi_probe_from_dt()
Date: Tue, 19 Feb 2019 21:29:08 -0800
Message-ID: <20190220052907.GA6629@Asurada-CZ80>
References: <20190219154652.13644-1-tiwai@suse.de>
 <20190219154652.13644-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A3CCF8075E
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 10:18:21 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id y10so11930290plp.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 01:18:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190219154652.13644-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2019 at 04:46:47PM +0100, Takashi Iwai wrote:
> The node obtained from of_find_node_by_path() has to be unreferenced
> after the use, but we forgot it for the root node.
> 
> Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Only compile-tested.  Please review carefully.  Thanks!

Ran a boot test by removing the if-condition. It'd be fine.

Thank you
Nicolin
 
>  sound/soc/fsl/fsl_ssi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 0a648229e643..09b2967befd9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1439,8 +1439,10 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
>  	 * different name to register the device.
>  	 */
>  	if (!ssi->card_name[0] && of_get_property(np, "codec-handle", NULL)) {
> -		sprop = of_get_property(of_find_node_by_path("/"),
> -					"compatible", NULL);
> +		struct device_node *root = of_find_node_by_path("/");
> +
> +		sprop = of_get_property(root, "compatible", NULL);
> +		of_node_put(root);
>  		/* Strip "fsl," in the compatible name if applicable */
>  		p = strrchr(sprop, ',');
>  		if (p)
> -- 
> 2.16.4
> 
