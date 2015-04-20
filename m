From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: tas571x: New driver for TI
 TAS571x power amplifiers
Date: Mon, 20 Apr 2015 22:14:26 +0100
Message-ID: <20150420211426.GN14892@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <552FB1CD.3040401@metafoo.de>
 <CAJzqFtbxKJirP9=hzHzQ=6KM=OayPmEDhJfkSx25DH4fu-gVgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtbxKJirP9=hzHzQ=6KM=OayPmEDhJfkSx25DH4fu-gVgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Bresticker <abrestic@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dgreid@chromium.org, Olof Johansson <olofj@chromium.org>
List-Id: alsa-devel@alsa-project.org


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 01:56:46PM -0700, Kevin Cernekee wrote:
> On Thu, Apr 16, 2015 at 5:57 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 04/15/2015 11:42 PM, Kevin Cernekee wrote:

> > If you want to make the clock optional use

> >         if (PTR_ERR(priv->mclk) == -ENOENT)
> >                 return PTR_ERR(priv->mclk);

> > This makes sure that the case where the clock is specified, but there is a
> > error with the specification (e.g. incorrect DT cells) is handled properly.

> Did you mean:

> >         if (PTR_ERR(priv->mclk) != -ENOENT)
> >                 return PTR_ERR(priv->mclk);

> I don't see this in other codec drivers, but I do see the explicit
> EPROBE_DEFER check in max98090, max98095, pcm512x, and wm8960.

That's the most correct way of writing a check for an optional clock,
best practice on this stuff is evolving over time (as is standardization
in the clock API).

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWwxAAoJECTWi3JdVIfQqgcH/0gtcE/F6ufPuDKs6Zu2uk4C
4XAeQTM/2M4nLmPaZrp6RIkCk3faCB6yLJuwnt6UTS+ejBgyeW3JNQ6061g2zM2v
/T6aXQ/rht35al8e7vCZa4HZqIG6MVVWu7+9BZ/VurozZVkDlzK7sHfnalVogkaV
I4ouUHHN1+rt4HBGXndpl+tPhaeyF3EKXzIC6d1CswUvB4Z5EPoHvKDn+UY31DeA
id9csyVm1N3cpwNTzcsImX4G50mC7QzA0hDQd3i6m4O6ju4UGL6nohk6m49ETZPv
g2DLZFTCx2s4BgCQnT2kb8wjNOCG55kOBpchGOp3OVse4aAXyweQpByKL6KAfa8=
=Z8L5
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
