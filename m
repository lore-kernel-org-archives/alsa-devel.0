From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: SOF: imx8: Fix an is IS_ERR() vs
	NULL check
Date: Mon, 26 Aug 2019 13:23:07 +0000
Message-ID: <17ba2fb20a06d3e167005db6a225ef68f6b78777.camel@nxp.com>
References: <20190826131855.GA6840@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4E7FF801ED
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 15:23:09 +0200 (CEST)
In-Reply-To: <20190826131855.GA6840@mwanda>
Content-Language: en-US
Content-ID: <5C4EB5DE8D1910478CB520EFEE79939D@eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2019-08-26 at 16:18 +0300, Dan Carpenter wrote:
> The device_link_add() function only returns NULL on error, it doesn't
> return error pointers.
> 
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan! Nice catch.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/sof/imx/imx8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index e502f584207f..41ad3a310808 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -227,8 +227,8 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>  						DL_FLAG_STATELESS |
>  						DL_FLAG_PM_RUNTIME |
>  						DL_FLAG_RPM_ACTIVE);
> -		if (IS_ERR(priv->link[i])) {
> -			ret = PTR_ERR(priv->link[i]);
> +		if (!priv->link[i]) {
> +			ret = -ENOMEM;
>  			dev_pm_domain_detach(priv->pd_dev[i], false);
>  			goto exit_unroll_pm;
>  		}
