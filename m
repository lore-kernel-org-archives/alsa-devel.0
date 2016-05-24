From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: Re: [PATCH 1/2] ASoC: pcm5102a: Add support for
 PCM5102A codec
Date: Wed, 25 May 2016 00:33:00 +0200
Message-ID: <059ee86a-2768-f5db-38ac-c6e3c9a45e4f@laposte.net>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org>
 <1463130853-25096-2-git-send-email-kernel@martin.sperl.org>
 <34ab107e-10dc-fbd3-28d1-203c6411851c@laposte.net>
 <20160523170853.GB8206@sirena.org.uk>
 <312f8476-a437-04d9-3d16-38d7c7c233ad@laposte.net>
 <alpine.DEB.2.02.1605241640250.19416@lnxricardw1.se.axis.com>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz299.laposte.net [178.22.154.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 658E926070F
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 00:32:59 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout011 (Postfix) with ESMTP id EDA1552A86D
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 00:32:56 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
 by lpn-prd-vrout011 (Postfix) with ESMTP id E91E552A831
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 00:32:56 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
 by lpn-prd-vrin003 (Postfix) with ESMTP id D430948DE20
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2016 00:32:56 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1605241640250.19416@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, Rob Herring <robh+dt@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, kernel@martin.sperl.org
List-Id: alsa-devel@alsa-project.org

Le 24/05/2016 =E0 16:44, Ricard Wanderlof a =E9crit :
>
> On Mon, 23 May 2016, Emmanuel Fust=E9 wrote:
>
>> /* pcm5102a in HW mode with external SCK (4wire mode)
>>  * at 128fs, 192fs or 256fs
>>  */
>> 	pcm5102a-4w: pcm5102a {
>> 		compatible =3D "simple-i2s-codec";
>> 		rate =3D <SNDRV_PCM_RATE_8000_192000>;
>> 		format =3D < SNDRV_PCM_FMTBIT_S16_LE
>> 			|SNDRV_PCM_FMTBIT_S24_LE
>> 			|SNDRV_PCM_FMTBIT_S32_LE>;
>> 	};
>> or
>> /* pcm5102a in HW mode with PLL on BCK (3wire mode)
>>  * 16to384khz but only with bck rate of 64fs
>>  */
>> 	pcm5102a-4w: pcm5102a {
>> 		compatible =3D "simple-i2s-codec";
>> 		rate =3D <SNDRV_PCM_RATE_8000_192000
>> 			^ SNDRV_PCM_RATE_8000>;
>> 		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
>> 	};
>> Or
>> /* ES9023 in asynchronous mode mclk > 37Mhz
>>  * I did not try bck rate <64fs as the sabre family did not generally
>>  * support it.
>>  */
>> 	es9023: es9023 {
>> 		compatible =3D "simple-i2s-codec";
>> 		rate =3D <SNDRV_PCM_RATE_8000_192000>;
>> 		format =3D <SNDRV_PCM_FMTBIT_S32_LE>;
>> 	};
>>
>> We could use I2S friendly property instead of "format" :
>> 		bckrates =3D <48, 64>;
>>
>>
>> With two or tree more property (gpio for mute, de-emphasis and filter
>> selection), you could cover 98% of I2S DAC with hardware only interfaces=
. It
>> cover too startup mode of most hifi I2C or SPI controllable DAC. Which i=
s a
>> good starting point for chip for which a driver is not already written.
>
> It seems to me that this only covers the cases where the is codec running
> in slave mode with MCLK derived from the BCLK, but not cases where the
> codec is master and needs to have its MCLK configured appropriately (in
> terms of device-specifc clock source and PLL settings), or am I missing
> something?
>
> /Ricard
>

It not a codec but a simple I2S DAC.
No I2S master mode.
Like most DAC before the CODEC era and all the big mess around them.
In the ES9023 case, the MCLK could either have no frequency an no phase =

relationship with the I2S clocks.
In this case, the MCLK is surely derived from a clock of the Rpi SOC so =

you are right, and the whole HifiBerry driver should be rewritten with =

proper abstraction like Mark suggested : Clock binding etc ...
But now as Mark say too, clock api integration is a goal, but not there.
The proposed hw param rules is a start to not have to write specific =

machine driver because of clocking constraints.
It is the second time I am scratching my head because of clocking =

constraints and because I want to do something better than writing =

another trivial machine driver.
In my case (BBB or other Ti soc using mcasp) I will have to had =

mux/clk_set_parent switching action and/or clk_set_rate action. But I am =

not persuaded that is it the way to go.

That why, by the time we get proper clock api integration with proper =

constraint and constraint description mechanism, a simple DT =

configurable codec driver in which we push the resulting constraint =

(DAC+SOC+design choice) was appealing.

But you are all right. This is not the long term proper way. And the =

actual ultra simple PCM510xA driver could evolve to support all GPIO and =

later properly express all his clock constraints independently of the =

implementation choices.

Thank your for your patience.

Emmanuel.
