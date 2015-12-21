From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: old version asrc only
 support even numbered channels
Date: Sun, 20 Dec 2015 23:31:18 -0800
Message-ID: <20151221073117.GC3524@Asurada-CZ80>
References: <beec631c1838b4a0a2a43066e1e308ec1407715b.1450430846.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A7E260663
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 08:31:22 +0100 (CET)
Received: by mail-pf0-f172.google.com with SMTP id u7so37786035pfb.1
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 23:31:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <beec631c1838b4a0a2a43066e1e308ec1407715b.1450430846.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2015 at 05:29:13PM +0800, Zidan Wang wrote:
> The latest asrc's channel bits is 4 bit, the old asrc's channel
> bits is 3. For the old version asrc, channel should be a even number.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index be78dc9..484e46ca 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -113,7 +113,8 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  	if (index == ASRC_INVALID_PAIR) {
>  		dev_err(dev, "all pairs are busy now\n");
>  		ret = -EBUSY;
> -	} else if (asrc_priv->channel_avail < channels) {
> +	} else if (asrc_priv->channel_avail < channels ||
> +		  (asrc_priv->channel_bits < 4 && channels % 2 != 0)) {
>  		dev_err(dev, "can't afford required channels: %d\n", channels);

It's actually not because of "cannot afford" but "not support an odd
channel number". So it should not be merged to the original condition.
Please add an extra else if for it.
