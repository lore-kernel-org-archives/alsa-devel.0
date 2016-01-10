From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
Date: Sun, 10 Jan 2016 13:17:17 +0100
Message-ID: <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org> <1452331558-2520-3-git-send-email-kernel@martin.sperl.org> <4332640.jBKM55TPAo@wuerfel> <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com> <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org> <20160110115858.GV6588@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160110115858.GV6588@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org


> On 10.01.2016, at 12:58, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Sun, Jan 10, 2016 at 11:55:48AM +0100, Martin Sperl wrote:
>=20
>> So if someone with a better idea how to keep those dt-binding includ=
es
>> synchronized with the definitions used by the code step forward and
>> propose a better solution how to get that implemented?
>=20
>> I guess there will be a few more occurrences of clocks that are
>> currently not defined, which will need to get introduced in the futu=
re
>> PWM and PCM were just the last in this series.
>=20
> Presumably just making the code not rely on having a define for the
> number of clocks would deal with the problem (eg, using ARRAY_SIZE
> internally).
ARRAY_SIZE would work fine, but the code is:=20

#include <dt-bindings/clock/bcm2835.h>
=2E..
struct bcm2835_cprman {
	struct device *dev;
	void __iomem *regs;
	spinlock_t regs_lock;
	const char *osc_name;

	struct clk_onecell_data onecell;
	struct clk *clks[BCM2835_CLOCK_COUNT];
};
=2E..
static int bcm2835_clk_probe(struct platform_device *pdev)
{
=2E..
	clks[BCM2835_PLLA_CORE] =3D
		bcm2835_register_pll_divider(cprman, &bcm2835_plla_core_data);
=2E..
        clks[BCM2835_CLOCK_PCM] =3D
                bcm2835_register_clock(cprman, &bcm2835_clock_pcm_data)=
;
=2E..
}

So the Array size is defined by the dt-bindings.

What you propose is a major change to the clock framework, so I would
hope that Eric (the original author of this clock-driver) would address
it.

Maybe someone has a better idea for a pattern to use to achieve=20
the required while maintaining =E2=80=9Csynchronization=E2=80=9D betwee=
n defines
inside the dt-binding and the driver.

