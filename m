From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: Re: How to transfer more than 2 channels
 between	i.MX25 & AD1938 using SSI?
Date: Mon, 30 Aug 2010 08:30:50 +0200
Message-ID: <4C7B501A.2070404@googlemail.com>
References: <4C752B37.40601@googlemail.com>
	<20100827114512.GC1473@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id A8D5424458
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 08:30:53 +0200 (CEST)
Received: by fxm11 with SMTP id 11so3097360fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2010 23:30:53 -0700 (PDT)
In-Reply-To: <20100827114512.GC1473@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

  Hi Sascha,


thanks for your help. We've been trying to use =

snd_soc_dai_set_tdm_slot() but had no success. The reason why this =

doesn't work is a limitation in the SSI peripheral of the i.MX25:

Acc. to the "i.MX25 Multimedia Applications Processor Reference Manual, =

Rev. 1" Chapter 43.1.2.4 I=B2S Mode, Page 43-16, the i.MX25 reverts in I=B2=
S =

Slave Mode to "Normal Mode" (as opposed to "Network Mode") by hardware.
In Chapter 43.1.2.1 Normal Mode, Page 43-5, it's explained that this =

mode only transfers one timeslot per frame:

"If Normal mode is configured with more than one time slot per frame, =

data is transferred only in the first time slot. No data is transferred =

in subsequent time slots. In Normal mode, DC[4:0] values corresponding =

to more than a single time slot in a frame, only results in lengthening =

of the frame."

Therefore, the SSI on the i.MX25 in Slave Mode (I don't know the other =

i.MX chips) can not do more than 2 channels.

This kind of explaines also, why all multi channel examples from =

freescale use the ESAI Port. The only codec used in their PDKs on the =

SSI is a plain stereo chip.

To overcome this limitation, we've split up our working group and will =

work on SSI master mode supoprt in the imx-ssc.c driver.

BR Sven


Am 27.08.2010 13:45, schrieb Sascha Hauer:
> Hi Sven,
>
> On Wed, Aug 25, 2010 at 04:39:51PM +0200, Sven Zeisberg wrote:
>>    Hi,
>>
>> has anybody succeeded to transfer more than 2 audio channels between
>> i.MX25 and a CODEC throught the i.MX25 SSI Port?
>>
>> We have succeeded to set the CODEC (AD1938) as Master to the required
>> mode (TDM with 8 Timeslots and 32 Bit per Timeslot). However, as soon as
>> we start to play a wav file with aplay, we can see on the logic analyzer
>> that the data format on the SSI lines is reset to a stereo mode (2
>> channels with frame sync changing level between channels).
>>
>> In the imx-ssi driver, I can see that .channel_max =3D 2 - therefore my
>> question: does this driver support more than two channels at all?
> You have to call snd_soc_dai_set_tdm_slot() with the correct parameters.
> This function is currently relatively untested, so expect bugs here. I
> would try something like:
>
> snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffff00, 0xfffff00, 8, 32);
>
> slot_width is currently not handled in this function, this may be
> wrong. I don't know whether a slot length of 32bit is supported at all
> in the hardware.
>
> I only tested this driver with 2 channels since I have no access to a
> codec supporting something else.
>
> Hope that helps
>
>    Sascha
>
