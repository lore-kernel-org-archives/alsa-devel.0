From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system
 clocks by ID
Date: Wed, 17 Feb 2016 10:13:35 +0200
Message-ID: <56C42BAF.3050900@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk> <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160216191346.2278.725@quark.deferred.io>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org

Mike,

On 02/16/2016 09:13 PM, Michael Turquette wrote:
> Quoting Mark Brown (2016-02-16 05:42:33)
>> On Tue, Feb 16, 2016 at 11:46:52AM +0200, Peter Ujfalusi wrote:
>>
>>> As for codecs, tlv320aic3106 is also pretty simple device from the =
outside, it
>>> can receive it's reference clock via:
>>> MCLK pin, GPIO2 pin or it can use the BCLK from the bus. Based on t=
he incoming
>>> frequency it can use it directly or it needs to use the internal PL=
L to
>>> generate the cocks.
>>> It can output generated clock via GPIO1
>>
>> That already sounds like there is room for configuration and hooking
>> into a wider clock tree - we've got three different source options a=
nd
>> an output plus a PLL that can presumably take in non-audio rates.
>=20
> +1
>=20
> It is quite easy for existing drivers to become clock providers. Plea=
se
> see struct isp_xclk in:
>=20
> drivers/media/platform/omap3isp/isp.h
> drivers/media/platform/omap3isp/isp.c
>=20
> CCF is intentionally designed as a library, meaning that you don't ne=
ed
> to create a new struct device to register clocks. Feel free to BYOD
> (bring your own device).

I have already started to look around what I would need for at least Mc=
ASP and
tlv320aic3x drivers (the most common combination).
I did not know that omap3isp has CCF provider implementation.

> Then your IP block clocks (McASP in this case) can hook into the
> system-wide clock tree (e.g. where some of the parent clocks come fro=
m).
>>
>>> I don't think it will bring any clarity or features we miss right n=
ow if we
>>> try to move CPU and codec drivers to clk API. IMHO.
>=20
> CPU drivers? Peter, you wrote the CCF clock provider driver for DRA7
> ATL, so I'm not sure what you mean here.

also the clk-twl6040, which is not in use upstream yet.
The ATL is providing the clocks to be used as master clock in McASP and
external components (audio codec).
In ASoC the CPU driver means the CPU DAI (Digital Audio Interface) driv=
er,
like the McASP, McBSP, DMIC, McPDM in TI parts.
In order them to generate the needed clocks on the bus they have intern=
al
clock selection, divider(s). From the SoC point of view these are not r=
eally
important, but McASP can also output high speed reference clock to outs=
ide so
the codec for example can use the same reference, reducing jitter.

>> You happen to be looking at a particularly simple system but things =
do
>> scale up and there's not a clear cutoff point which would allow us t=
o
>> make a clear distinction between things that might get used in a sim=
ple
>> system and things that might need something more complex.  This seem=
s
>> particularly important when we're adding things to simple-card, we w=
ant
>> it to be usable with as many different devices as possible.
>=20
> The original patches didn't hit my inbox, only the last two replies. =
Can
> someone fill me in on the DT side of this discussion?

the original patch:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/1043=
20.html

> Why are DT bindings needed here?

ASoC have an API to configure the DAI system clock:
snd_soc_dai_set_sysclk(dai, sysclk_id, sysclk, sysclk_dir);

The sysclk_id is to select among the possible clock sources, sysclk is =
the
rate of the clock and sysclk_dir is to tell the DAI driver if the given=
 clock
should be input or output.
McASP (and McBSP also) can select between two master clock source. aic3=
106 can
select between 3 reference clocks.
Unfortunately the simple-card was hardwired to only handle DAIs which h=
ave no
master clock selection. We have added additional properties to simple-c=
ard so
it will be possible to select clocks and directions.
With this change we don't need to write custom machine drivers for setu=
p not
using sysclk_id =3D=3D 0.
I do think this is reasonable change by itself.

> Are other devices besides McASP consuming the clocks provided by McAS=
P?

Yes, it can output the same reference clock it is using to external pin=
, but
it can do that only if it is set to generate the audio clocks on the bu=
s.

> DT can also be a good candidate for doing per-board (or per-use case)
> clock configuration via the assigned-clocks, assigned-clock-rates, an=
d
> assigned-clock-parents properties.

Yes, if the DAI driver implements it's clock tree with CCF internally a=
nd with
the assigned-clock* properties we will not need snd_soc_dai_set_sysclk(=
) and
we don't need simple-card to know anything about the clocking of the
components. All of this can be done in the board's DTS file with standa=
rd CCF
bindings.

Mark: after thinking over how this should work I can see that it can br=
ing
benefits for the DAI/codec drivers. They need to do things differently,=
 but it
is just implementation question.
However I do think that the current simple-card is flawed regarding to =
clock
selection and the change Jyri and me are proposing is reasonable.
But if we have the CCF providers popping up in DAI/codec drivers the us=
e of
clock configuration via simple-card not going to be needed. But right k=
now it
is needed.

--=20
P=C3=A9ter
