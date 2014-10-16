From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Thu, 16 Oct 2014 11:04:54 +0200
Message-ID: <20141016090454.GB6678@sirena.org.uk>
References: <1413407742-19112-1-git-send-email-anatol.pomozov@gmail.com>
 <20141016073846.GA724@sirena.org.uk>
 <CALj_zD4-8TWKvX9vebTM5j__o3NgjjfPO+7ZvjPUzFX3dO10sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2220348806458970390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 653BC2614EE
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 11:05:21 +0200 (CEST)
In-Reply-To: <CALj_zD4-8TWKvX9vebTM5j__o3NgjjfPO+7ZvjPUzFX3dO10sA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomazau <anatol@google.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Stephen Warren <swarren@nvidia.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============2220348806458970390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 01:59:58AM -0700, Anatol Pomazau wrote:
> On Thu, Oct 16, 2014 at 12:38 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Oct 15, 2014 at 02:15:42PM -0700, Anatol Pomozov wrote:

> >> +Required properties:
> >> +- nvidia,speaker-codec: The phandle of the board specific speaker amplifier.
> >> +  This binding assumes that AIF2 on the audio CODEC is connected to this
> >> +  amplifier.

> > To repeat my comment on the previous version:

> > | This isn't as generic as all that, it relies on the specific speaker
> > | driver.  I'd suggest either just saying it's board specific or making
> > | the speaker CODEC optional.

> > Please don't ignore review comments.

> In the description of the dts property I said that its board specific
> amp. If it not what you want then I do not know what "saying it's
> board specific" means. Could you please provide examples of "board
> specific" properties?

The *driver* is board specific.  Obviously all DT properties in a given
DT are specific to the particular board.  This driver claims to be a
generic driver for Tegra systems with this CODEC but it has a
non-optional requirement for an external speaker driver driver to be
specified and hooked up in that particular way.

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP4o1AAoJECTWi3JdVIfQlBAH/jJq6K4UfiQPpeSDpgIVnkPy
ipriVgMswpBxqGMHQ9DiCknoIftcuWgzH9fUjy1UeUwbSYTUBkAksmSXeML/mX8Y
/VmJWqzvRNNQTCTf2fjSwXdXGMMkmRyWEpnjLckIFv7/GWTIr8HK6R40chKLLwHZ
kx+IgYnwmovF7wz1hWzWvVYRWJ6uJlRM8KWtGEou9NZopqBgICafbnBm/IA074va
dPZdHgNOVGYyOSuNgc1KHLFChYriqw9GYNadZmZwu3LvlSXFgbCDywlzJ1o5w3Nd
nP0JaBhCUMa6OoLoPgq0IlZPaKKSMGKNEACP5g8bhOf2nvTKlF4GNjtMfN6mpeI=
=rVho
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

--===============2220348806458970390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2220348806458970390==--
