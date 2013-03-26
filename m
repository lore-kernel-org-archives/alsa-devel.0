From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: BUG: soft lockup when recording audio on MX28EVK with ASoC sgtl5000
Date: Tue, 26 Mar 2013 12:43:41 +0100
Message-ID: <515189ED.3080807@digi.com>
References: <51502C87.8050902@digi.com> <CAOMZO5CWE-Q0Oh_LnP3ZOcnm5D68rJ6JGun=Tpq4EbS4TDQ+bw@mail.gmail.com> <CAOMZO5CvrkfGPi7=4-JXnSLzU+8NKV=RD9n3eLvCehXdv6JHEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CvrkfGPi7=4-JXnSLzU+8NKV=RD9n3eLvCehXdv6JHEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 03/26/2013 12:15 AM, Fabio Estevam wrote:
> Hector,
>
> On Mon, Mar 25, 2013 at 4:31 PM, Fabio Estevam <festevam@gmail.com> w=
rote:
>> Hi Hector,
>>
>> On Mon, Mar 25, 2013 at 7:52 AM, Hector Palacios
>> <hector.palacios@digi.com> wrote:
>>> Hello,
>>>
>>> I just tried recording audio on Freescale's MX28EVK that uses ASoC =
sgtl5000
>>> (kernel v3.8) with:
>>>
>>>          arecord -M -f cd sound.wav --duration 10
>>>
>>> and got a scheduler message:
>>>
>>> [  789.041847] [sched_delayed] sched: RT throttling activated
>>
>> I have just tested arecord on 3.8,4 and I haven't seen the 'soft loc=
kup' bug.
>>
>> However, I see that mxs saif gets busy after the record and any
>> attempt to do an 'aplay' after the first arecord fails.
>>
>> With the attached patch applied I am able to do arecord/aplay sequen=
ce
>> several times.
>>
>> I don't have a cable handy here to actually test if the sound is
>> recorded properly or not.
>>
>> Could you please test it against 3.8.4?
>
> I managed to test arecord and it works with the following as follows:
>
> 1. Run alsamixer and select LINE_IN in the Capture element
>
> 2. Record with the following command line:
>
> arecord -D hw:0,1 -d 10 -f S16_LE -r 44100 -c  test.wav

This command works on v3.8 even without your patch. I can arecord/aplay=
 several times=20
without problems.

With my original command 'arecord [-M] -f cd sound.wav --duration 10', =
the soft lockup=20
appears both in v3.8 and v3.8.4 with and without your patch. So it look=
s like the=20
patch does not help here.

Regards,
--=20
H=C3=A9ctor Palacios
