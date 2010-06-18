From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix overflow bug in
	SOC_DOUBLE_R_SX_TLV
Date: Fri, 18 Jun 2010 11:29:24 +0100
Message-ID: <1276856964.3054.1.camel@odin>
References: <20100618023810.GS7759@www.longlandclan.yi.org>
	<1276829770-31557-1-git-send-email-redhatter@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3E524534
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 12:29:29 +0200 (CEST)
Received: by wwf26 with SMTP id 26so324399wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2010 03:29:26 -0700 (PDT)
In-Reply-To: <1276829770-31557-1-git-send-email-redhatter@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-18 at 12:56 +1000, Stuart Longland wrote:
> When SX_TLV widgets are read, if the gain is set to a value below 0dB,
> the mixer control is erroniously read as being at maximum volume.
> 
> The value read out of the CODEC register is never sign-extended, and
> when the minimum value is subtracted (read; added, since the minimum is
> negative) the result is a number greater than the maximum allowed value
> for the control, and hence it saturates.
> 
> Solution: Mask the result so that it "wraps around", emulating
> sign-extension.
> 
> Signed-off-by: Stuart Longland <redhatter@gentoo.org>
> ---
>  sound/soc/soc-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a82a797..0470288 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2400,8 +2400,8 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
>  	int val = snd_soc_read(codec, mc->reg) & mask;
>  	int valr = snd_soc_read(codec, mc->rreg) & mask;
>  
> -	ucontrol->value.integer.value[0] = ((val & 0xff)-min);
> -	ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
> +	ucontrol->value.integer.value[0] = ((val & 0xff)-min) & mask;
> +	ucontrol->value.integer.value[1] = ((valr & 0xff)-min) & mask;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
