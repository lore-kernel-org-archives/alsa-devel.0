From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Mon, 23 Jun 2014 16:01:13 +0300
Message-ID: <53A82519.6050506@ti.com>
References: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
 <20140609202403.GX5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F3DE82608C7
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:01:20 +0200 (CEST)
In-Reply-To: <20140609202403.GX5099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/09/2014 11:24 PM, Mark Brown wrote:
> On Fri, Jun 06, 2014 at 04:05:31PM +0300, Peter Ujfalusi wrote:
> =

>> Correct the hw_params callback to configure the codec correctly in case =
of
>> S24_3LE format.
>> S24_LE is not defined as supported format for the codec.
> =

> These should both be supported by the time things get down to the wire -
> the memory layout shouldn't matter.

The codec itself has support for 16, 20, 24 and 32 bits data. The
AIC3X_FORMATS is correct:
#define AIC3X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |=
 \
			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

While in hw_params the switch was not handling the S24_3LE but it was defin=
ed
as S24_LE. So the code was not correct: It advertised that it supportsd
S24_3LE and was not handling it, but it was handling S24_LE which would not
happen with this codec driver since the format is not supported - as it was
defined by the AIC3X_FORMATS.

This is a fix for the current driver.

> I really need to get round to doing
> the rest of the conversions to use params_width() which should ensure
> this.

Not sure how this would work at the end to be honest for all platforms and =
codecs.
How should the bitclock need to be configured for S24_3LE, S24_LE and S32_LE
msbits=3D24? They are at the end have 24bits audio data but in memory they =
are
stored in different ways.
Aic3x for example need to be configured to 24bit mode (24 clocks/channel if=
 it
is master) so it is going to 'pull' that amount from the CPU side. This can
not be used with OMAP's sDMA/McBSP but davinci's eDMA/McASP can support it.=
 I
can even get daVinci to 'extract' the valid 24 bits from the 32bit sample
coming via eDMA (mask/rotate/reverse operation).

So I still think that this is a bit more complicated than it looks

-- =

P=E9ter
