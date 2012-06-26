From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH V2] ASoC: tlv320aic3x: Fix codec pll
	configure bug
Date: Tue, 26 Jun 2012 14:07:48 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA2D2A2@DBDE01.ent.ti.com>
References: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
	<20120626085403.GH30406@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B96D224399
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 16:07:57 +0200 (CEST)
In-Reply-To: <20120626085403.GH30406@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 26, 2012 at 14:24:03, Mark Brown wrote:
> On Tue, Jun 26, 2012 at 11:33:43AM +0530, Hebbar, Gururaja wrote:
> > In sound/soc/codecs/tlv320aic3x.c
> > 
> >         data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> >         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> >                       data | (pll_p << PLLP_SHIFT));
> > 
> > In the above code, pll-p value is OR'ed with previous value without
> > clearing it. Bug is not seen if pll-p value doesn't change across
> > Sampling frequency.
> 
> A better fix is to change the code to use snd_soc_update_bits() rather
> than open code it.  This is more idiomatic and will suppress writes if
> they don't change anything.
> 

Sure will resend the patch. Thanks for the review


Regards, 
Gururaja
