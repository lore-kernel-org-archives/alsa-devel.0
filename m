From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
Date: Wed, 13 May 2015 16:11:14 -0700
Message-ID: <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk> <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: zhengxing <zhengxing@rock-chips.com>, Xing Zheng <acgzxing@gmail.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 10:21 AM, Dylan Reid <dgreid@chromium.org> wrot=
e:
> On Wed, May 13, 2015 at 9:42 AM, Mark Brown <broonie@kernel.org> wrot=
e:
>> On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
>>> On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:22, Mark Brown wrote:
>>
>>> >Is it not possible to extend simple card to handle your use cases?
>>> >Given the very generic naming and the fact that things like jack
>>> >detection and so on should depend on the CODEC and board usually r=
ather
>>> >than on the SoC it doesn't sound like this is Rockchip specific.
>>
>>> >This also looks like you're reimplementing some device model enume=
ration
>>> >stuff which probably shouldn't be happening but let's understand t=
he
>>> >problem you're trying to solve here before going too far into the =
code.
>>
>>> Because we are trying to bring rt5650 in the project, so we intend =
to
>>> describe supported codecs with DTS via only a rockchip machine driv=
er file,
>>> others remain pre-implement(like max98090 / rt5645 that vendor mach=
ine
>>> driver).
>>
>> I don't undertand what you're saying here, sorry - why is this not j=
ust
>> a case of writing multiple machine drivers?
>
> I don't understand this either.  I'd think the best solution is
> simple-card, configured through DTS for each device.
>
>>
>>> I communicated with Dylan, and he told me that the jack detection i=
s an
>>> issue in the simple-card, and suggested we are better to send them =
at
>>> present.
>>
>> But what are these issues?
>
> The issue I was referring to when I spoke with rock chip was the need
> to pass the jack simple-card creates to the headset chip or codec.  W=
e
> need a way to specify a device like a tsa227e or rt5650 to pass the
> jack to, which events are supported by the jack, and a generic API fo=
r
> passing the jack.

I'm having some trouble envisioning how to pass the jack to the
headset chip in a generic way.  A callback could be added to
snd_soc_component_driver, or a snd_soc_headset_driver could be added.
The headset_drive would fit the ts3a227e well, but not the rt5645
which is also a full blown codec.
