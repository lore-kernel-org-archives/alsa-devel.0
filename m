From: Gen Zhang <blackgod016574@gmail.com>
Subject: Re: [PATCH] Revert "wcd9335: fix a incorrect use of
	kstrndup()"
Date: Wed, 12 Jun 2019 21:34:53 +0800
Message-ID: <20190612133453.GA3922@zhanggen-UX430UQ>
References: <20190612133040.5kgtio7gidxx64gh@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81089F806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 15:35:00 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id n4so16987075wrs.3
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 06:35:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190612133040.5kgtio7gidxx64gh@xylophone.i.decadent.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 12, 2019 at 02:30:40PM +0100, Ben Hutchings wrote:
> This reverts commit a54988113985ca22e414e132054f234fc8a92604.
> The strings being duplicated are not fixed-length, so kstrndup()
> is the correct function to use.
> 
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  sound/soc/codecs/wcd9335.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 85737fe54474..a04a7cedd99d 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
>  	char *dec;
>  	u8 hpf_coff_freq;
>  
> -	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
> +	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
>  	if (!widget_name)
>  		return -ENOMEM;
>  
> -- 
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
> 
OMG! There is someone following what I was doing these days...
Kind of peculiar
