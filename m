From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH RFT] ASoC: da7219: Fix da7219->alc_en state
 when enabling ALC
Date: Wed, 21 Oct 2015 09:00:06 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D460B2E4@SW-EX-MBX01.diasemi.com>
References: <1445387677.5319.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 3975F2605C7
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 11:00:09 +0200 (CEST)
In-Reply-To: <1445387677.5319.1.camel@ingics.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On October 21, 2015 01:35, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/da7219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 86c528a..e36a7b7 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -402,7 +402,7 @@ static int da7219_alc_sw_put(struct snd_kcontrol *kcontrol,
>  	/* Force ALC offset calibration if enabling ALC */
>  	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
>  		da7219_alc_calib(codec);
> -		da7219->alc_en = false;
> +		da7219->alc_en = true;
>  	} else {
>  		da7219->alc_en = false;
>  	}
> --
> 2.1.4

Tested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
