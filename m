From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASOC: fsl_spdif: fix bit order for spdif
 RX channel status
Date: Wed, 23 Sep 2015 16:07:12 -0700
Message-ID: <20150923230710.GA4026@Asurada-CZ80>
References: <1443016847-29857-1-git-send-email-kgroeneveld@lenbrook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD5226149D
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 01:07:20 +0200 (CEST)
Received: by pacgz1 with SMTP id gz1so3473429pac.3
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 16:07:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443016847-29857-1-git-send-email-kgroeneveld@lenbrook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2015 at 10:00:47AM -0400, Kevin Groeneveld wrote:
> The bits within each byte of the hardware registers for the channel status
> bits are reversed. Therefore when the channel status is read from the
> hardware we need to reverse the bits.
> 
> The code which writes the channel status bits for the TX already correctly
> reverses the bits. This patch implements similar functionality for the RX.
> 
> I have tested this patch running on imx6 using several different SPDIF
> source devices.
> 
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you

> ---
>  sound/soc/fsl/fsl_spdif.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index ab729f2..e84e839 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -676,14 +676,14 @@ static int fsl_spdif_capture_get(struct snd_kcontrol *kcontrol,
>  		return -EAGAIN;
>  
>  	regmap_read(regmap, REG_SPDIF_SRCSH, &cstatus);
> -	ucontrol->value.iec958.status[0] = (cstatus >> 16) & 0xFF;
> -	ucontrol->value.iec958.status[1] = (cstatus >> 8) & 0xFF;
> -	ucontrol->value.iec958.status[2] = cstatus & 0xFF;
> +	ucontrol->value.iec958.status[0] = bitrev8((cstatus >> 16) & 0xFF);
> +	ucontrol->value.iec958.status[1] = bitrev8((cstatus >> 8) & 0xFF);
> +	ucontrol->value.iec958.status[2] = bitrev8(cstatus & 0xFF);
>  
>  	regmap_read(regmap, REG_SPDIF_SRCSL, &cstatus);
> -	ucontrol->value.iec958.status[3] = (cstatus >> 16) & 0xFF;
> -	ucontrol->value.iec958.status[4] = (cstatus >> 8) & 0xFF;
> -	ucontrol->value.iec958.status[5] = cstatus & 0xFF;
> +	ucontrol->value.iec958.status[3] = bitrev8((cstatus >> 16) & 0xFF);
> +	ucontrol->value.iec958.status[4] = bitrev8((cstatus >> 8) & 0xFF);
> +	ucontrol->value.iec958.status[5] = bitrev8(cstatus & 0xFF);
>  
>  	/* Clear intr */
>  	regmap_write(regmap, REG_SPDIF_SIC, INT_CNEW);
> -- 
> 1.7.4.1
> 
