From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] Remove unused variable 'codec' from
	sound/soc/codecs/tlv320aic23.c
Date: Tue, 28 Oct 2008 12:33:33 +0530
Message-ID: <dfeb90390810280003i5a5171fam2f8bc6627dc1b4ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id A8F2B2451F
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 08:03:35 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id k29so4675062rvb.2
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 00:03:34 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manish Katiyar <mkatiyar@gmail.com>
Cc: alsa-devel@alsa-project.org, troy.kisky@boundarydevices.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Manish Katiyar wrote:
> [ Apologies if this is not the proper list for this patch, but I
> couldn't find any list more appropriate for this]
>
> Below patch removes the following warning.
> sound/soc/codecs/tlv320aic23.c:424: warning: unused variable 'codec'

CCing Troy

Troy has got some patch which adds support for more mclk frequencies.
So that variable will be required.

Thanks,
Arun KS
>
>
> Signed-off-by: Manish Katiyar <mkatiyar@gmail.com>
> ---
>  sound/soc/codecs/tlv320aic23.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
> index 44308da..45395d0 100644
> --- a/sound/soc/codecs/tlv320aic23.c
> +++ b/sound/soc/codecs/tlv320aic23.c
> @@ -421,8 +421,6 @@ static int tlv320aic23_set_dai_fmt(struct
> snd_soc_dai *codec_dai,
>  static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>  				      int clk_id, unsigned int freq, int dir)
>  {
> -	struct snd_soc_codec *codec = codec_dai->codec;
> -
>  	switch (freq) {
>  	case 12000000:
>  		return 0;
