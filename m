From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
Date: Sun, 10 Jan 2016 20:07:32 +0100
Message-ID: <93C244A0-20B7-4E21-A183-E09F83CFE035@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org> <1452331558-2520-3-git-send-email-kernel@martin.sperl.org> <4332640.jBKM55TPAo@wuerfel> <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com> <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org> <20160110115858.GV6588@sirena.org.uk> <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org> <CAMuHMdXan4aM76aAx_wbnrib7wH5W7tkg60jgRkyQjGFmUEo=A@mail.gmail.com> <D415BD6A-6BE1-4B87-B0D4-D0AC6D39785A@martin.sperl.org> <CAMuHMdVG+ox4JJWAiNRVgTtV_Lz4Njhekp0=dOyY-G+=mxby3Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVG+ox4JJWAiNRVgTtV_Lz4Njhekp0=dOyY-G+=mxby3Q@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


> On 10.01.2016, at 19:56, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>=20
> Hi Martin,
>=20
> On Sun, Jan 10, 2016 at 7:01 PM, Martin Sperl <kernel@martin.sperl.or=
g> wrote:
>>> On 10.01.2016, at 14:02, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>>> I wrote:
>>> | Hence it can better be replaced (it seems to be unused in dts fil=
es, but you
>>> | can keep the definition to be 100% sure) by an ARRAY_SIZE() in th=
e C driver.
>>> | This requires changing the driver to e.g. initialize clks[] in
>>> |bcm2835_clk_probe() based on a table instead of explicit code.
>>>=20
>>> If you fill in clks[] from a static table, you can take ARRAY_SIZE =
of
>>> the static table.
>>=20
>> You mean something like the below?
>> (note: copy/paste from console issues - spaces instead of tabs)
>=20
> More or less.
>=20
>> };
>>=20
>> static inline void cprman_write(struct bcm2835_cprman *cprman, u32 r=
eg, u32 val
>> @@ -496,6 +496,14 @@ static const struct bcm2835_pll_data bcm2835_pl=
lh_data =3D {
>>        .max_fb_rate =3D BCM2835_MAX_FB_RATE,
>> };
>>=20
>> +static const struct bcm2835_pll_data *bcm2835_plls[] =3D {
>> +       [BCM2835_PLLA] =3D &bcm2835_plla_data,
>> +       [BCM2835_PLLB] =3D &bcm2835_pllb_data,
>> +       [BCM2835_PLLC] =3D &bcm2835_pllc_data,
>> +       [BCM2835_PLLD] =3D &bcm2835_plld_data,
>> +       [BCM2835_PLLH] =3D &bcm2835_pllh_data,
>> +};
>=20
> This is a sparse array?
Yes - for all.

>=20
>> struct bcm2835_pll {
>>        struct clk_hw hw;
>>        struct bcm2835_cprman *cprman;
>> @@ -1560,8 +1600,13 @@ static int bcm2835_clk_probe(struct platform_=
device *pdev)
>>        struct clk **clks;
>>        struct bcm2835_cprman *cprman;
>>        struct resource *res;
>> +       const int clks_cnt =3D max(ARRAY_SIZE(bcm2835_plls),
>> +                                max(ARRAY_SIZE(bcm2835_pll_divs),
>> +                                    ARRAY_SIZE(bcm2835_clks))) + 1;
>> +       size_t alloc =3D sizeof(*cprman) + clks_cnt * sizeof(*clks);
>> +       size_t i;
>=20
> If you combine all 3 arrays in a single non-sparse array, you could g=
et rid
> of the dynamic allocation using the maximum of the 3 sizes, and can j=
ust
> use a single ARRAY_SIZE().


The problem is that we need different initialization methods for pll, p=
ll-dividers
and derived clocks, so we can not easily make them a common setting unl=
ess we
would use function and void pointers to work arround this, which would =
make it
less readable (and more code again just for the - repeated - assignment=
).

As far as I can tell from my testing the patched version works and the =
kernel
boots correctly.

I will respin the patchset tomorrow - it might take slightly longer, as=
 I
found that the fractional clock divider is not working unless the MASH
functionality is activated in the registers. This results in =E2=80=9Cf=
requency shifts=E2=80=9D
for audio, which we want to avoid - this means we need another patch to
enable this MASH feature.

