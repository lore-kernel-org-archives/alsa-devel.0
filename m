From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: Re: [PATCH] ASoC: DaVinci: Added support for cpu
	clocking I2S
Date: Wed, 30 Jun 2010 10:52:30 +0200
Message-ID: <AANLkTikhqZRWYoNnZ2PSnVVpV0rUqQQyRxfz99a25EMU@mail.gmail.com>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
	<4C28F3D1.5060806@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E74B3103809
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 10:52:30 +0200 (CEST)
Received: by iwn5 with SMTP id 5so657469iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2010 01:52:30 -0700 (PDT)
In-Reply-To: <4C28F3D1.5060806@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

2010/6/28 Troy Kisky <troy.kisky@boundarydevices.com>

> Raffaele Recalcati wrote:
> > +             if (dev->i2s_fast_clock) {
> > +                     clk_div = 256;
> can you have
>   f = (freq / params->rate_num) * params->rate_den;
> > +                     do {
> > +                             framesize = (freq / (--clk_div)) /
> > +                                         params->rate_num *
> > +                                         params->rate_den;
> and
>                                framesize = f / (--clk_div);
> > +                     } while (((framesize < 33) || (framesize > 4095))
> &&
> > +                              (clk_div));
> > +                     clk_div--;
> looks like clk_div can go negative here, should the above while say
> (clk_div > 1)
>

> +                     } while (((framesize < 33) || (framesize > 4095)) &&
> +                              (clk_div));

only if clk_div not null stay inside the while.

> +                     clk_div--;

and here can at minumum be 0, not negative.



> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> > +             } else {
> > +                     /* symmetric waveforms */
> > +                     clk_div = freq / (mcbsp_word_length * 16) /
> > +                               params->rate_num * params->rate_den;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> > +                                                     16 - 1);
> > +             }
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
>


so, dividing for (CLKGDV + 1) it is ok.

Raffaele
