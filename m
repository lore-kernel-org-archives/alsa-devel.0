From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ALSA/NUC900: Fix a while loop bug for
 nuc900 alsa driver
Date: Tue, 01 Jun 2010 10:06:42 +0100
Message-ID: <1275383202.3060.9.camel@odin>
References: <4C04756E.4000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDEE1039BF
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 11:06:51 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1320591wwf.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 02:06:46 -0700 (PDT)
In-Reply-To: <4C04756E.4000400@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-06-01 at 10:50 +0800, Wan ZongShun wrote:
> Dear all,
> 
> This patch is to fix a while loop bug for nuc900 alsa driver.

Which bug ? It's best to say the bug you are fixing when submitting a
patch like this.

Thanks

Liam

> 
> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>
> ---
>  sound/soc/nuc900/nuc900-ac97.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> index 5b864f9..db7fc13 100644
> --- a/sound/soc/nuc900/nuc900-ac97.c
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -66,9 +66,8 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
>  	udelay(100);
> 
>  	/* polling the AC_R_FINISH */
> -	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> -	val &= AC_R_FINISH;
> -	while (!val && timeout--)
> +	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
> +								&& timeout--)
>  		mdelay(1);
> 
>  	if (!timeout) {
> @@ -121,9 +120,8 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, unsigned
> short reg,
>  	udelay(100);
> 
>  	/* polling the AC_W_FINISH */
> -	tmp = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> -	tmp &= AC_W_FINISH;
> -	while (tmp && timeout--)
> +	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
> +								&& timeout--)
>  		mdelay(1);
> 
>  	if (!timeout)
