From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
Date: Fri, 15 May 2015 22:40:59 +0200
Message-ID: <555659DB.9010204@metafoo.de>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com> <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com> <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com> <20150513164250.GB2761@sirena.org.uk> <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com> <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dylan Reid <dgreid@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Xing Zheng <acgzxing@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sonny Rao <sonnyrao@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 05/14/2015 01:11 AM, Dylan Reid wrote:
> On Wed, May 13, 2015 at 10:21 AM, Dylan Reid <dgreid@chromium.org> wr=
ote:
>> On Wed, May 13, 2015 at 9:42 AM, Mark Brown <broonie@kernel.org> wro=
te:
>>> On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
>>>> On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:22, Mark Brown wrote:
>>>
>>>>> Is it not possible to extend simple card to handle your use cases=
?
>>>>> Given the very generic naming and the fact that things like jack
>>>>> detection and so on should depend on the CODEC and board usually =
rather
>>>>> than on the SoC it doesn't sound like this is Rockchip specific.
>>>
>>>>> This also looks like you're reimplementing some device model enum=
eration
>>>>> stuff which probably shouldn't be happening but let's understand =
the
>>>>> problem you're trying to solve here before going too far into the=
 code.
>>>
>>>> Because we are trying to bring rt5650 in the project, so we intend=
 to
>>>> describe supported codecs with DTS via only a rockchip machine dri=
ver file,
>>>> others remain pre-implement(like max98090 / rt5645 that vendor mac=
hine
>>>> driver).
>>>
>>> I don't undertand what you're saying here, sorry - why is this not =
just
>>> a case of writing multiple machine drivers?
>>
>> I don't understand this either.  I'd think the best solution is
>> simple-card, configured through DTS for each device.
>>
>>>
>>>> I communicated with Dylan, and he told me that the jack detection =
is an
>>>> issue in the simple-card, and suggested we are better to send them=
 at
>>>> present.
>>>
>>> But what are these issues?
>>
>> The issue I was referring to when I spoke with rock chip was the nee=
d
>> to pass the jack simple-card creates to the headset chip or codec.  =
We
>> need a way to specify a device like a tsa227e or rt5650 to pass the
>> jack to, which events are supported by the jack, and a generic API f=
or
>> passing the jack.
>
> I'm having some trouble envisioning how to pass the jack to the
> headset chip in a generic way.  A callback could be added to
> snd_soc_component_driver, or a snd_soc_headset_driver could be added.
> The headset_drive would fit the ts3a227e well, but not the rt5645
> which is also a full blown codec.

Yea, our current jack detection code is quite rudimentary when it comes=
 to=20
writing generic code.

I think the proper way to support this is come up with the concept of j=
ack=20
detection providers and consumers. A component can register a jack dete=
ction=20
provider just like it can register a DAI. And then in the board driver =
you'd=20
just link the jack detection logic to the jack using the usual approach=
,=20
which is also used for DAIs (e.g. of node or device name). The core wou=
ld=20
then take care of calling a enable callback or whatever is required to =
setup=20
the jack detection logic in the driver.

This would also nicely solve the issue with the GPIO jack detectors, wh=
ere=20
we currently can't really handle -EPROBE_DEFER. The GPIO would be reque=
sted=20
by a jack detection provider which can request them before the card is=20
registered rather than having to do the requesting in the card's init c=
allback.

- Lars
