From: gianluca <gianlucarenzi@eurek.it>
Subject: Re: [PATCH 1/2] ASoC: codecs: ad193x: Fix memory
 corruption on BE 64b systems
Date: Wed, 26 Jun 2019 14:45:11 +0200
Message-ID: <49c769f6-f962-b863-454b-95dd44591ee3@eurek.it>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from submit-3.e-mind.com (submit-3.e-mind.com [188.94.192.49])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DDADF806F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 14:45:12 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by submit-3.e-mind.com (Postfix) with ESMTP id 6491284388E
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 12:45:12 +0000 (UTC)
Received: from submit-3.e-mind.com ([127.0.0.1])
 by localhost (submit-3.e-mind.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHv38-3RjS9D for <alsa-devel@alsa-project.org>;
 Wed, 26 Jun 2019 14:45:12 +0200 (CEST)
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
 by submit-3.e-mind.com (Postfix) with SMTP id 1B4A7830F4B
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 14:45:12 +0200 (CEST)
In-Reply-To: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/26/2019 12:49 PM, Codrin Ciubotariu wrote:
> Since change_bit() requires unsigned long*, making this cast on an
> unsigned int variable will change a wrong bit on BE platforms, causing
> memory corruption. Replace this function with a simple XOR.
>
> Fixes: 90f6e6803139 ("ASoC: codecs: ad193x: Fix frame polarity for DSP_A format")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  sound/soc/codecs/ad193x.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
> index 05f4514048e2..3ebc0524f4b2 100644
> --- a/sound/soc/codecs/ad193x.c
> +++ b/sound/soc/codecs/ad193x.c
> @@ -240,10 +240,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  	}
>
>  	/* For DSP_*, LRCLK's polarity must be inverted */
> -	if (fmt & SND_SOC_DAIFMT_DSP_A) {
> -		change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
> -			   (unsigned long *)&dac_fmt);
> -	}
> +	if (fmt & SND_SOC_DAIFMT_DSP_A)
> +		dac_fmt ^= AD193X_DAC_LEFT_HIGH;
>

BigEndian RULEZ! ;-P


-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
