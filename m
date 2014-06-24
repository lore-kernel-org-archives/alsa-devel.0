From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Tue, 24 Jun 2014 09:23:28 +0300
Message-ID: <53A91960.1040108@ti.com>
References: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
 <20140609202403.GX5099@sirena.org.uk> <53A82519.6050506@ti.com>
 <20140623151822.GA23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D6DB2652E3
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 08:23:33 +0200 (CEST)
In-Reply-To: <20140623151822.GA23300@sirena.org.uk>
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

On 06/23/2014 06:18 PM, Mark Brown wrote:
> On Mon, Jun 23, 2014 at 04:01:13PM +0300, Peter Ujfalusi wrote:
> =

>> AIC3X_FORMATS is correct:
>> #define AIC3X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3L=
E | \
>> 			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
> =

>> While in hw_params the switch was not handling the S24_3LE but it was de=
fined
>> as S24_LE. So the code was not correct: It advertised that it supportsd
>> S24_3LE and was not handling it, but it was handling S24_LE which would =
not
>> happen with this codec driver since the format is not supported - as it =
was
>> defined by the AIC3X_FORMATS.
> =

>> This is a fix for the current driver.
> =

> Yes, but the fix should be to support both.

I would rather fix the S24_3LE with this patch and add the S24_LE with a
separate one. But IMHO the S24_LE support is not obvious.

>>> I really need to get round to doing
>>> the rest of the conversions to use params_width() which should ensure
>>> this.
> =

>> Not sure how this would work at the end to be honest for all platforms a=
nd codecs.
>> How should the bitclock need to be configured for S24_3LE, S24_LE and S3=
2_LE
>> msbits=3D24? They are at the end have 24bits audio data but in memory th=
ey are
>> stored in different ways.
> =

> The number of bits on the wire should be the number specified in the
> format.

So you are saying that for S24_3LE, S24_LE and S32_LE (msbits=3D24) we shou=
ld
have 24 bits on the wire?
At least twl4030/5030 expects the 24bit data on the wire with 32 clocks (24
bits data + 8bits padding).
OMAP McBSP can only support 24bit audio with S32_LE (msbits=3D24) and it ne=
eds
to have 32 clock cycle on the bus to do this due to system constraints.

So if we say that S32_LE (msbits=3D24) should have 24 bits on the wire neit=
her
OMAP McBSP nor twl4030/5030 could do that.

Not sure about other SoCs, but I would not be so surprised that they also w=
ant
to shift out all the bits they have got form the main memory, ie 24 bits in
case of S24_3LE, 32bits in case of S24_LE or S32_LE (msbits=3D24).

>> Aic3x for example need to be configured to 24bit mode (24 clocks/channel=
 if it
>> is master) so it is going to 'pull' that amount from the CPU side. This =
can
>> not be used with OMAP's sDMA/McBSP but davinci's eDMA/McASP can support =
it. I
>> can even get daVinci to 'extract' the valid 24 bits from the 32bit sample
>> coming via eDMA (mask/rotate/reverse operation).
> =

> Sure, so it only supports exactly 24 bit sample formats in master mode.
> That's what's expected by default.
> =

>> So I still think that this is a bit more complicated than it looks
> =

> I'm not seeing anything particularly hard here.  The main thing is that
> we ought to do something for dealing with extra BCLKs (eg, a device that
> can tolerate extra BCLKs can have the other end generating more data
> quite happily).
> =



-- =

P=E9ter
