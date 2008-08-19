From: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH] duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
Date: Tue, 19 Aug 2008 08:15:05 +0200 (CEST)
Message-ID: <3ef3fed769e5aa57681bacea1230e82b.squirrel@secure.sipsolutions.net>
References: <48AA407C.8090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id D4BD4245DC
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Aug 2008 08:15:09 +0200 (CEST)
In-Reply-To: <48AA407C.8090409@gmail.com> 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: roel kluin <roel.kluin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

roel kluin wrote:
> untested, is it correct?

not a clue, do you know how long ago that was? :)
does the driver check endianness anywhere?

> duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c
> b/sound/aoa/codecs/snd-aoa-codec-tas.c
> index 7a16a33..c922505 100644
> --- a/sound/aoa/codecs/snd-aoa-codec-tas.c
> +++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
> @@ -654,15 +654,15 @@ static struct snd_kcontrol_new bass_control = {
>  static struct transfer_info tas_transfers[] = {
>  	{
>  		/* input */
> -		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
> -			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
>  		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> SNDRV_PCM_RATE_48000,
>  		.transfer_in = 1,
>  	},
>  	{
>  		/* output */
> -		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
> -			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
>  		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> SNDRV_PCM_RATE_48000,
>  		.transfer_in = 0,
>  	},
>
>
