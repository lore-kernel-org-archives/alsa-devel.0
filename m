From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH -next] platform/chrome: Fix Kconfig dependencies for wilco_ec
Date: Mon, 25 Feb 2019 21:56:26 +0800
Message-ID: <CAFv8NwKb6vxRg1xj+R3AE6PxhuOsgwOGBQOihpc468QqNE5ZQw@mail.gmail.com>
References: <20190220221128.48476-1-ncrews@chromium.org> <420e6e26-6270-e577-6bbc-3ebe884168b5@infradead.org>
 <765ebb17-4523-d915-bdce-9ecde26836f0@collabora.com> <9ac9ee8e-cd7a-10e4-e176-428344e980a6@infradead.org>
 <e30adf98-143b-a9fb-3675-c356bdf31ad0@collabora.com> <CAFv8NwJ9R3wRMPzSKqUiVc7iwEViaswYbZ0JyvG0En8d_5nZLw@mail.gmail.com>
 <22f84fb2-73ef-d0af-0552-2512912ae000@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22f84fb2-73ef-d0af-0552-2512912ae000@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Nick Crews <ncrews@chromium.org>, Benson Leung <bleung@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, dlaurie@chromium.org, Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 25, 2019 at 8:23 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Cheng-yi,
>
> Attached the config that Randy sent.
>
> Thanks,
>  Enric

Hi Enric,
Thanks for the quick reply.
I have posted a patch to fix it.

> On 25/2/19 11:22, Cheng-yi Chiang wrote:
> > On Mon, Feb 25, 2019 at 6:11 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Randy,
> >>
> >> Thanks for the report
> >>
> >> On 22/2/19 17:50, Randy Dunlap wrote:
> >>> On 2/20/19 11:57 PM, Enric Balletbo i Serra wrote:
> >>>> Hi,
> >>>>
> >>>> On 21/2/19 0:09, Randy Dunlap wrote:
> >>>>> On 2/20/19 2:11 PM, Nick Crews wrote:
> >>>>>> In the initial version of the Wilco EC Driver, the
> >>>>>> dependency order was wrong. It before was possible to
> >>>>>> select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
> >>>>>> having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
> >>>>>> WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
> >>>>>> other way around.
> >>>>>>
> >>>>>> Fixes: 1733c32834e5d1 ("platform/chrome: Add new driver for Wilco EC")
> >>>>>> Signed-off-by: Nick Crews <ncrews@chromium.org>
> >>>>>
> >>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> >>>>>
> >>>>
> >>>> As this is [-next] material I squashed that commit and queued for 5.1
> >>>
> >>> Hi,
> >>>
> >>> on linux-next of 20190222, I now see this build error + Kconfig warnings:
> >>>
> >>> (this is on i386; randconfig file is attached)
> >>>
> >>> WARNING: unmet direct dependencies detected for SND_SOC_CROS_EC_CODEC
> >>>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MFD_CROS_EC [=n]
> >>>   Selected by [y]:
> >>>   - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y]
> >>
> >>
> >> This error seems to be introduced by following commit.
> >>
> >> commit 74c6ecf4194ebed285b29964a950e0cd7414fe19
> >> Author: Cheng-Yi Chiang <cychiang@chromium.org>
> >> Date:   Mon Feb 18 12:18:19 2019 +0800
> >>
> >>     ASoC: qcom: Kconfig: select dmic for sdm845
> >>
> >>     sdm845 uses dmic on EC so it should select CROS_EC_CODEC.
> >>
> >>     Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> >>     Signed-off-by: Mark Brown <broonie@kernel.org>
> >>
> >> The problem is that this commit selects CROS_EC_CODEC but the CROS_EC_CODEC
> >> depends on MFD_CROS_EC which is not selected.
> >>
> >> A question for Cheng-Yi, I suppose that the answer is yes but worth ask because
> >> I don't know about this device. Is the sdm845 a chromebook with and embedded
> >> controller right?
> >>
> >> Thanks,
> >> Enric
> >>
> >
> > Hi Enric,
> > Yes you are right.
> > Sorry for causing the trouble.
> > I will post a patch to fix it.
> >
> > Could you please let me know what is the command for your build ?
> > Currently I am using command like
> > ARCH=x86_64 make allyesconfig
> > ARCH=x86_64 make -j64
> >
> > to verify the build, which is not useful to catch bug like this.
> > If you have any other good tip for checking this kind of error please
> > kindly let me know.
> > Thanks!
> >
> >>>
> >>> ld: sound/soc/codecs/cros_ec_codec.o: in function `ec_command_no_resp':
> >>> cros_ec_codec.c:(.text+0x50): undefined reference to `cros_ec_cmd_xfer_status'
> >>> ld: sound/soc/codecs/cros_ec_codec.o: in function `mic_gain_get':
> >>> cros_ec_codec.c:(.text+0x5a8): undefined reference to `cros_ec_cmd_xfer_status'
> >>>
> >>>
> >>>
