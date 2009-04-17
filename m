From: Arun KS <getarunks@gmail.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
	format in OMAP McBSP DAI driver
Date: Fri, 17 Apr 2009 14:46:34 +0530
Message-ID: <dfeb90390904170216q4eaa90e0kf66271de4651c27a@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>
	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>
	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
	<49E7A498.8060804@boundarydevices.com>
	<20090417095923.6392f82e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E6591037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 11:22:54 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so532213tia.8
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 02:22:50 -0700 (PDT)
In-Reply-To: <20090417095923.6392f82e.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>, ext Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2009 at 12:29 PM, Jarkko Nikula <jarkko.nikula@nokia.com> w=
rote:
> On Thu, 16 Apr 2009 23:35:20 +0200
> ext Troy Kisky <troy.kisky@boundarydevices.com> wrote:
>
>> Arun KS wrote:
>> > But when I2S is used there is no audio on Right channel(left channel
>> > is working fine).
>> > Thinks something is missing on tlv320aic23 driver.
>> >
>> This sounds like the same problem Davinci has. From a comment in
>> davinci-i2s.c
>>
>> case SND_SOC_DAIFMT_I2S:
>> =A0 =A0 =A0 =A0 /* Davinci doesn't support TRUE I2S, but some codecs wil=
l have
>> =A0 =A0 =A0 =A0 =A0* the left and right channels contiguous. This allows
>> =A0 =A0 =A0 =A0 =A0* dsp_a mode to be used with an inverted normal frame=
 clk.
>> =A0 =A0 =A0 =A0 =A0* If your codec is master and does not have contiguous
>> =A0 =A0 =A0 =A0 =A0* channels, then you will have sound on only one chan=
nel.
>> =A0 =A0 =A0 =A0 =A0* Try using a different mode, or codec as slave.
>> =A0 =A0 =A0 =A0 =A0*
>> =A0 =A0 =A0 =A0 =A0* The TLV320AIC33 is an example of a codec where this=
 works.
>> =A0 =A0 =A0 =A0 =A0* It has a variable bit clock frequency allowing it t=
o have
>> =A0 =A0 =A0 =A0 =A0* valid data on every bit clock.
>> =A0 =A0 =A0 =A0 =A0*
>> =A0 =A0 =A0 =A0 =A0* The TLV320AIC23 is an example of a codec where this=
 does
>> not
>> =A0 =A0 =A0 =A0 =A0* work. It has a fixed bit clock frequency with progr=
essively
>> =A0 =A0 =A0 =A0 =A0* more empty bit clock slots between channels as the =
sample
>> =A0 =A0 =A0 =A0 =A0* rate is lowered.
>> =A0 =A0 =A0 =A0 =A0*/
>
> Interesting codec. Arun, how is the right channel working with I2S if
> you try to run with higher rate? E.g. aplay -r [48000 |
> 96000] /dev/urandom

Its the same. Right channel remains blank and left channel is playing.

>
> The I2S mode setup in tlv320aic23_set_dai_fmt looks correct.
>
>
> Jarkko
>
