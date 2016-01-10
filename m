From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 5/5] dt-bindings: bsm2835: fix bindings documentation to use new clock framework
Date: Sun, 10 Jan 2016 12:05:52 +0100
Message-ID: <ED21A42A-EE91-495D-857E-04C533CD718C@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org> <1452331558-2520-6-git-send-email-kernel@martin.sperl.org> <20160109224523.GA17329@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160109224523.GA17329@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Remi Pommarel <repk-lovNVp52yxIDGOk2Oe9MvA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, lFlorian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On 09.01.2016, at 23:45, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Sat, Jan 09, 2016 at 09:25:57AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wro=
te:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>=20
>> The bcm2835-i2s driver has been updated to use the new clock framewo=
rk
>> for the bcm2835 SOC.
>=20
> You are breaking compatibility with the driver change. New kernels wi=
ll=20
> not work with old dtbs as you have found. What should be done is fix =
the=20
> driver to work with the old and new dtb.

Actually the driver/device-tree is already broken with commit 94cb7f76c=
aa0
("ARM: bcm2835: Switch to using the new clock driver support=E2=80=9D)

Because there we already have the following conflicting definitions:

clocks: cprman@7e101000 {
	compatible =3D "brcm,bcm2835-cprman";
	#clock-cells =3D <1>;
	reg =3D <0x7e101000 0x2000>;
	/* CPRMAN derives everything from the platform's
	* oscillator.
	*/
	clocks =3D <&clk_osc>;
};

i2s: i2s@7e203000 {
	compatible =3D "brcm,bcm2835-i2s";
	reg =3D <0x7e203000 0x20>,
	      <0x7e101098 0x02>;
	dmas =3D <&dma 2>,
	       <&dma 3>;
	dma-names =3D "tx", "rx";
	status =3D "disabled";
};

The i2s driver fails to load because the second reg range
overlaps with the range from clocks (which was introduced
with the commit mentioned above.

This patch only changes the driver to work again without
this second reg address range and using the clocks property
instead.

>=20
>> This patch documents the required changes to the bindings.
>>=20
>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> ---
>> Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 =
+++----
>> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> But I leave it to platform maintainers to decide if breaking=20
> compatibility is okay, so:
>=20
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
