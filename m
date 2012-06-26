From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH] davinci:mcasp: Fix codec pll configure bug
Date: Tue, 26 Jun 2012 06:23:37 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA2C783@DBDE01.ent.ti.com>
References: <1340275108-15555-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 75F91104069
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 08:23:42 +0200 (CEST)
In-Reply-To: <1340275108-15555-1-git-send-email-gururaja.hebbar@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "Nori,
	Sekhar" <nsekhar@ti.com>
List-Id: alsa-devel@alsa-project.org

All,

Kindly ignore this patch I will resend a corrected patch with below changes

1. add asoc codec maintainers (Mark Brown & Liam Girdwood)
2. modify the subject to indicate ASOC and codec as tlv320aic3x

On Thu, Jun 21, 2012 at 16:08:28, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
> 
> 	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> 	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> 		      data | (pll_p << PLLP_SHIFT));
> 
> In the above code, pll-p value is OR'ed with previous value without
> clearing it. Bug is not seen if pll-p value doesn't change across
> Sampling frequency.
> 
> However on some platforms (like AM335x EVM-SK), pll-p may have different
> values across different sampling frequencies. In such case, above code
> configures the pll with a wrong value.
> Because of this bug, when a audio stream is played with pll value
> different from previous stream, audio is heard as stretched.
> 
> Fix the same by clearing the mask and then writing the value.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    2 +-
>  sound/soc/codecs/tlv320aic3x.h |    1 +

...snip...
...snip...

>  #define PLLJ_SHIFT		2
> -- 
> 1.7.1
> 

Regards, 
Gururaja
