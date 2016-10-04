From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 03/14] ASoC: sun4i-i2s: Add apb reset
Date: Tue, 4 Oct 2016 17:42:18 +0200
Message-ID: <20161004154218.GM5228@lukather>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004141516.53c6fa8c@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161004141516.53c6fa8c@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, wens@csie.org, broonie@kernel.org, alexandre.belloni@free-electrons.com, dmaengine@vger.kernel.org, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 04, 2016 at 02:15:16PM +0200, Thomas Petazzoni wrote:
> Hello,
>=20
> On Tue,  4 Oct 2016 11:46:16 +0200, Myl=E8ne Josserand wrote:
>=20
> >  #include <sound/dmaengine_pcm.h>
> >  #include <sound/pcm_params.h>
> > @@ -589,6 +590,7 @@ static int sun4i_i2s_probe(struct platform_device *=
pdev)
> >  {
> >  	struct sun4i_i2s *i2s;
> >  	struct resource *res;
> > +	struct reset_control *reset_apb;
> >  	void __iomem *regs;
> >  	int irq, ret;
> > =20
> > @@ -626,7 +628,19 @@ static int sun4i_i2s_probe(struct platform_device =
*pdev)
> >  		dev_err(&pdev->dev, "Can't get our mod clock\n");
> >  		return PTR_ERR(i2s->mod_clk);
> >  	}
> > -=09
> > +
> > +	reset_apb =3D devm_reset_control_get(&pdev->dev, "apb_reset");
>=20
> I believe this is a change in the Device Tree binding, since you're
> adding support for a new resource. Perhaps the Device Tree binding
> documentation should be updated accordingly?

Indeed.

You have two solutions to do that:
  - Either mark it as optional and use reset_control_get_optional
    (because here, you broke the other SoCs that have that controller
    but no reset line)
  - Or introduce a new compatible, and make the reset property
    mandatory for that new compatible.

I prefer the latter, since you get a stricter error check, and you
cannot end up in a situation where your driver probes but is
useless. But you'll find both in our drivers.

> > +	}
> > +
> > +	ret =3D reset_control_deassert(reset_apb);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Can't deassert apb reset (%d)\n", ret);
> > +		return ret;
> > +	}
>=20
> Do you need to re-assert the reset line in the ->remove() hook?

Even better, you can add it to the runtime_pm hooks! :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX883aAAoJEBx+YmzsjxAgTc4QAL62RJw5dXv9CTB06fQ8erFG
KRm7cM35mifXfs6oCfG+eFX3gzlvcvUbDc/+5GBa9VWa+0eY9++0Mc98NWGdl8A+
8l1W2immpdfDILgk+4Qi2stMyHDMFaV5sqZirNCDVhRnxGAV7KqO9DSd+9EZgb+E
7sj3iy/4E9Jhd5F0LLGcu0VVbIkb0Nv1RmD/ankvCKICycdVVGAo/iZZ3YtLY6sP
G+HRnNtK87VP5+x5sVS+VazQB8nfZFUv77DS3ms8VtwMjk+w7J139iv10iGFghgS
OVJbSxVAiELq0ipxezO/Zi8DAI5u0EwYjp1LxHiwaKUPttaJViYpoc0DGcPHugu5
/39Z3K6EP9sbf/dqySARo4BX9gj+9EAXkrKADJW2UVI3r0Xj4P482J52+f53x4qY
ihiuYnZ4bxqz3GNf2HW3fdzVCvr5fQidmr74hXY/I+VoZtUH4+oBSTcKV07mAVuU
ArAUPzfQpM3n2MZmEDpsJpmZB+Ba/xEeOPCrRF9wfXmGdyxA+uhfrykZNPjsGdv2
OpesbVGybZoyB5uF/C7P9YC4zgtFh0hhB91it1AMQ6MhQ/L46Br3yD/AWP90HwsP
722A1MNqajt1WDvmuspZPsvjP93COKCFJ1YPv1c967xSR1hsPESizbv7FGcGZfxa
gxZSfN+PV+yoI8vcJNVu
=9ZGk
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--
