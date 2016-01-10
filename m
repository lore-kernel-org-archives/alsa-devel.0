From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
Date: Sun, 10 Jan 2016 13:30:14 +0100
Message-ID: <20160110123014.GA1764@cruxbox>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 10, 2016 at 01:17:17PM +0100, Martin Sperl wrote:
> >=20
> > Presumably just making the code not rely on having a define for the
> > number of clocks would deal with the problem (eg, using ARRAY_SIZE
> > internally).
> ARRAY_SIZE would work fine, but the code is:=20
>=20
> #include <dt-bindings/clock/bcm2835.h>
> ...
> struct bcm2835_cprman {
> 	struct device *dev;
> 	void __iomem *regs;
> 	spinlock_t regs_lock;
> 	const char *osc_name;
>=20
> 	struct clk_onecell_data onecell;
> 	struct clk *clks[BCM2835_CLOCK_COUNT];
> };
> ...
> static int bcm2835_clk_probe(struct platform_device *pdev)
> {
> ...
> 	clks[BCM2835_PLLA_CORE] =3D
> 		bcm2835_register_pll_divider(cprman, &bcm2835_plla_core_data);
> ...
>         clks[BCM2835_CLOCK_PCM] =3D
>                 bcm2835_register_clock(cprman, &bcm2835_clock_pcm_dat=
a);
> ...
> }
>=20
> So the Array size is defined by the dt-bindings.
>=20
> What you propose is a major change to the clock framework, so I would
> hope that Eric (the original author of this clock-driver) would addre=
ss
> it.
>=20
> Maybe someone has a better idea for a pattern to use to achieve=20
> the required while maintaining =E2=80=9Csynchronization=E2=80=9D betw=
een defines
> inside the dt-binding and the driver.
>=20

Why not just get rid of BCM2835_CLOCK_COUNT and use an internal clock
count ? Something like the patch attached at the end of the mail. This
has the downside to be more careful when adding a new clock.

If it is not ok, I could try to modify the clk driver to use Mark's
solution if you want.

Regards,

--=20
Remi

--------------------------------->8------------------------------------=
---
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm283=
5.c
index 015e687..f558c5b 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -281,6 +281,8 @@
 #define LOCK_TIMEOUT_NS                100000000
 #define BCM2835_MAX_FB_RATE    1750000000u
=20
+#define BCM2835_CLOCK_MAX BCM2835_CLOCK_PCM
+
 struct bcm2835_cprman {
        struct device *dev;
        void __iomem *regs;
@@ -288,7 +290,7 @@ struct bcm2835_cprman {
        const char *osc_name;
=20
        struct clk_onecell_data onecell;
-       struct clk *clks[BCM2835_CLOCK_COUNT];
+       struct clk *clks[BCM2835_CLOCK_MAX + 1];
 };
=20
 static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg=
, u32 val)

