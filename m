From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Don't squash 16x8 registers down to
	8 bits
Date: Wed, 11 May 2011 14:37:37 +0100
Message-ID: <1305121057.3277.17.camel@odin>
References: <1305114508-6705-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CF300103849
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 15:37:41 +0200 (CEST)
Received: by bwz10 with SMTP id 10so488505bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 06:37:41 -0700 (PDT)
In-Reply-To: <1305114508-6705-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-05-11 at 13:48 +0200, Mark Brown wrote:
> Currently we'll force all registers to fit in 8 bits before passing
> down to the I/O function. Looks like a cut'n'paste bug.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index bb8e446..40548ce 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -232,7 +232,6 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
>  	data[0] = (reg >> 8) & 0xff;
>  	data[1] = reg & 0xff;
>  	data[2] = value;
> -	reg &= 0xff;
>  
>  	return do_hw_write(codec, reg, value, data, 3);
>  }

Acked-by: Liam Girdwood <lrg@ti.com>
