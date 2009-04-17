From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
 format in OMAP McBSP DAI driver
Date: Fri, 17 Apr 2009 09:59:23 +0300
Message-ID: <20090417095923.6392f82e.jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
	<49E7A498.8060804@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id EA3E32438D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 08:58:47 +0200 (CEST)
In-Reply-To: <49E7A498.8060804@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Arun KS <getarunks@gmail.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Apr 2009 23:35:20 +0200
ext Troy Kisky <troy.kisky@boundarydevices.com> wrote:

> Arun KS wrote:
> > But when I2S is used there is no audio on Right channel(left channel
> > is working fine).
> > Thinks something is missing on tlv320aic23 driver.
> > 
> This sounds like the same problem Davinci has. From a comment in
> davinci-i2s.c
> 
> case SND_SOC_DAIFMT_I2S:
>         /* Davinci doesn't support TRUE I2S, but some codecs will have
>          * the left and right channels contiguous. This allows
>          * dsp_a mode to be used with an inverted normal frame clk.
>          * If your codec is master and does not have contiguous
>          * channels, then you will have sound on only one channel.
>          * Try using a different mode, or codec as slave.
>          *
>          * The TLV320AIC33 is an example of a codec where this works.
>          * It has a variable bit clock frequency allowing it to have
>          * valid data on every bit clock.
>          *
>          * The TLV320AIC23 is an example of a codec where this does
> not
>          * work. It has a fixed bit clock frequency with progressively
>          * more empty bit clock slots between channels as the sample
>          * rate is lowered.
>          */

Interesting codec. Arun, how is the right channel working with I2S if
you try to run with higher rate? E.g. aplay -r [48000 |
96000] /dev/urandom

The I2S mode setup in tlv320aic23_set_dai_fmt looks correct.


Jarkko
