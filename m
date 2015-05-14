From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
Date: Thu, 14 May 2015 10:22:18 +0800
Message-ID: <555406DA.8040709@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com> <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com> <20150512192215.GZ3066@sirena.org.uk> <55535035.5070608@rock-chips.com> <20150513164250.GB2761@sirena.org.uk> <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com> <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Xing Zheng <acgzxing@gmail.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 2015=E5=B9=B405=E6=9C=8814=E6=97=A5 07:11, Dylan Reid wrote:
> On Wed, May 13, 2015 at 10:21 AM, Dylan Reid<dgreid@chromium.org>  wr=
ote:
>> On Wed, May 13, 2015 at 9:42 AM, Mark Brown<broonie@kernel.org>  wro=
te:
>>> On Wed, May 13, 2015 at 09:23:01PM +0800, zhengxing wrote:
>>>> On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:22, Mark Brown wrote:
>>>>> Is it not possible to extend simple card to handle your use cases=
?
>>>>> Given the very generic naming and the fact that things like jack
>>>>> detection and so on should depend on the CODEC and board usually =
rather
>>>>> than on the SoC it doesn't sound like this is Rockchip specific.
>>>>> This also looks like you're reimplementing some device model enum=
eration
>>>>> stuff which probably shouldn't be happening but let's understand =
the
>>>>> problem you're trying to solve here before going too far into the=
 code.
>>>> Because we are trying to bring rt5650 in the project, so we intend=
 to
>>>> describe supported codecs with DTS via only a rockchip machine dri=
ver file,
>>>> others remain pre-implement(like max98090 / rt5645 that vendor mac=
hine
>>>> driver).
>>> I don't undertand what you're saying here, sorry - why is this not =
just
>>> a case of writing multiple machine drivers?
>> I don't understand this either.  I'd think the best solution is
>> simple-card, configured through DTS for each device.

Hi Mark, Dylan,
I tried to use simple-card and had some trouble that jack detection. So=
=20
my idea is simply:
                                                   /-- rockchip_max9809=
0=20
(to configure max98090, and no need to via DTS)
    rockchip_machine_driver  |-- rockchip_rt5645 (to configure=20
rt5650/rt5645, and no need to via DTS)
(supported codecs via DTS)   \-- rockchip_(maybe other codecs)

It is right that it is base on original rockchip_max98090, but the old=20
rockchip_max98090 used DTS.

I tried to explain my ideas. Your kind suggestions will be highly=20
appreciated.

Thanks.
