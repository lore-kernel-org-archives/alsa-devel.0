From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Sun, 26 Mar 2017 21:02:32 +0200
Message-ID: <d655f31c-8448-e45c-e399-bcf954fbb5b6@laposte.net>
References: <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
 <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
 <20170227115108.GA6732@delle.lan>
 <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz29.laposte.net [194.117.213.104])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D93266847
 for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2017 21:02:34 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout017 (Postfix) with ESMTP id 9AA8DA0494E
 for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2017 21:02:33 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout017 (Postfix) with ESMTP id 8D678A04942
 for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2017 21:02:33 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.prosodie [10.128.63.4])
 by lpn-prd-vrout017 (Postfix) with ESMTP id 8B600A0494E
 for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2017 21:02:33 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
 by lpn-prd-vrin003 (Postfix) with ESMTP id 74F7348EADC
 for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2017 21:02:33 +0200 (CEST)
In-Reply-To: <20170321221145.GA7258@camel2.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matt Flax <flatmax@flatmax.org>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le 21/03/2017 =E0 23:11, Matthias Reichl a =E9crit :
> On Tue, Mar 21, 2017 at 10:21:04PM +0100, Emmanuel Fust=E9 wrote:
>> Le 16/03/2017 =E0 23:14, Matt Flax a =E9crit :
>>>
>>> On 17/03/17 08:27, Lars-Peter Clausen wrote:
>>>> On 03/16/2017 09:51 PM, Matt Flax wrote:
>>>>> On 16/03/17 06:01, Mark Brown wrote:
>>>>>> On Tue, Feb 28, 2017 at 09:59:29AM +0000, Charles Keepax wrote:
>>>>>>> On Mon, Feb 27, 2017 at 12:51:08PM +0100, Matthias Reichl wrote:
>>>>>>>>> I have a bcm2835 (Pi 2 and 3) SoC here. It is producing
>>>>>>>>> multichannel (8
>>>>>>>>> out,
>>>>>>>>> 6 in) audio. In ALSA we call that DSP mode - right ?!
>>>>>>>> No. DSP modes are protocol/timing specifications as I2S, PDP,
>>>>>>>> S/PDIF, ...
>>>>>>>> You can look these up in datasheets and if a chip implements such a
>>>>>>>> protocol you can be sure that it adheres to that standard - i.e. it
>>>>>>>> will sync the frames to the pulses on LRclk.
>>>>>>> I agree with the thoughts in this thread really if the AP doesn't
>>>>>>> actually support DSP A mode we shouldn't add DSP A mode.
>>>>>> The trouble here is that this isn't 100% clear, the specifications of
>>>>>> the DSP modes are such that only one edge in the LRCLK matters and so
>>>>>> providing you're doing mono or have exact clocking they interoperate
>>>>>> perfectly well.  We already frequently do similar things the other
>>>>>> way,
>>>>>> most of the programmable serial ports can't actually do I2S modes
>>>>>> properly and rely on exact clocking to get things right when operati=
ng
>>>>>> as I2S since they only sync on one edge (though they can generally
>>>>>> generate the clocks correctly when operating as master, they just
>>>>>> don't
>>>>>> pay attention to the left/right switch edge).
>>>>>>
>>>>>> That said unless we're doing something with the data layout or simil=
ar
>>>>>> configuration there's a fairly strong case for putting the mangling
>>>>>> for
>>>>>> this in the core, something like just falling back to I2S mode if we
>>>>>> set
>>>>>> DSP A and so on.  Which would be a lot nicer if we actually got
>>>>>> round to
>>>>>> putting mode capability information in the drivers.
>>>>> I agree, the data layout is already configurable in the bcm2835_i2s.c
>>>>> platform driver. We can already use the "snd_soc_dai_set_bclk_ratio"
>>>>> function to manage word offsets in our machine drivers.
>>>>>
>>>>> There is nothing which says that the bcm2835 SoC is I2S restricted in
>>>>> any
>>>>> way. In fact, the reference document says quite the opposite.
>>>>>
>>>>> In the reference "BCM2835 ARM Peripherals" pdf, they call the audio
>>>>> system
>>>>> an "APB peripheral". They are saying that it is reconfigurable and
>>>>> part of
>>>>> the AMBA family of interconnect schemes.
>>>>>
>>>>> As far as the bcm2835_i2s platform driver goes, it has implemented an
>>>>> AMBA
>>>>> protocol, where audio words are counted from the LR clock onset - for
>>>>> some
>>>>> reason people are insisting this is an I2S bus. Really our
>>>>> implementation is
>>>>> not I2S at all, because word onsets are programmable and flexible in
>>>>> the
>>>>> bcm2835_i2s.c driver.
>>>> AMBA/APB is the interface which connects the peripheral to the system
>>>> memory
>>>> bus. It is the interface over which the CPU does configuration register
>>>> writes. This has nothing and absolutely nothing to do with the I2S
>>>> interface
>>>> that is also implemented by the peripheral that is used to stream audio
>>>> to
>>>> and from external components.
>>>>
>>> Their (BCM reference) document [1] specifically states "It supports many
>>> classic PCM formats including I2S".
>>>
>>> Do agree with Mark's statement "the specifications of the DSP modes are
>>> such that only one edge in the LRCLK matters" ?
>>>
>>> If we look at the bcm2835 platform driver setup, it is concerned with b=
it
>>> clock counting to specify the audio data for both of the AMBA/APB chann=
els
>> >from serial bitstream into memory. It has two channels into memory,
>>> however "it supports many classic PCM formats" ... my vote for one clas=
sic
>>> format is DSP mode !
>>>
>>> Do you see a problem with that ?
>>>
>>> thanks
>>> Matt
>>> [1] https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-=
Peripherals.pdf
>>> _______________________________________________
>>>
>> Re-reading this document, the bcm2835 PCM IP block SHOULD support real D=
SP
>> mode, with one BCLK pulsed LRCLK, zero BCLK delay etc...
>> It just need to be properly setup.
> I've re-read the document, too, last week and noticed the framesync
> registers - sorry, I had completely forgotten about these. I guess it
> should be possible to configure the bcm2835 to DSP mode but it'd still be
> limited to 2 channel setups - the hardware only has 2 channel position
> registers for each direction.
>
>> According to the same document, you could program the bmc up to 16 32bits
>> channels when in master mode, so I suspect that you could go up to this
>> limit in slave mode.
>> But as it is designed, it could only use up to two of any channels among=
 the
>> 16.
> I'm not quite sure if I can follow you on this - how would you
> configure 16 channels when there are only 2 channel position registers?
>
> With bclk ratio eg set to 16*32=3D512 BCM2835 will only transmit 2*32
> bits of data (at configurable bit positions), the remaining 448
> bits will be zero.
>
>
Yes, two arbitrary tdm channels out of 16. And as I and you said, the =

others are not usable.
Could be useful in a TDM chained scenario , but not for what we are =

talking here.

Emmanuel.
