From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: adg :: AUDIO-CLKOUTn can synchronizes with
 L/R clock.
Date: Wed, 8 Jun 2016 16:14:59 +0100
Message-ID: <20160608151459.GL7510@sirena.org.uk>
References: <87oa7dtti3.wl%kuninori.morimoto.gx@renesas.com>
 <20160607105418.GS7510@sirena.org.uk>
 <87eg88jzt3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibe32dcbQs37CEZO"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87eg88jzt3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--ibe32dcbQs37CEZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 12:27:48AM +0000, Kuninori Morimoto wrote:

> > Why would a user not want these clocks to be synchronous?  A lot of
> > CODECs will at least have better performance if their master clock is
> > synchronous to the audio clocks so it'd be a better default, is there an
> > advantage to not doing it?

> I'm now confusing. We can set system clock on audio card, for example
> simple-card case, it is called as "system-clock-frequency".
> In my understanding, this "system clock" and above "master clock" are sam=
e clock.
> but "system clock" is fixed rate (=3D not related to audio clock in many =
cases).
> Because of this, some codec doesn't request synchronous between
> master clock <-> audio clock, but, some codec requests synchronous it.
> Am I wrong ??

A lot of CODECs can to varying degrees tolerate this but it will tend to
show up in performance numbers, it's often not immediately obvious just
=66rom a listening test.  Usually those that don't mind have a FLL or PLL
they're using to generate the actual audio master clock at a useful rate
for dividing down, or sometimes fancy digital logic to match things
up.

It's not a problem to have this configurable, I'm just thinking it might
be better to have the default be the other way around so that we default
to synchronous but can turn that off if it's required.

--ibe32dcbQs37CEZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWDZyAAoJECTWi3JdVIfQxTMH/jBwVgzlvL2W/XfD1S/DPk/Y
Ij+BqlfC5VHuJ55beOJXJfsi5FQowuyJHWxpUwkFOy6xSCeuWlqUvkhov1GfxO2/
2kq6IYxN/JiYA8l9fk6vjfzK9X+iMh6T9Xuzdki8eC+GRdNkQBuRiAfEDNVcokch
RN7W7nNq4gRqF9D6LVvuNhvCMF2DsNxzuaclM1+d+BQJqjNsd2HgXU0WdsZT9n/z
OYPR6Utje2I0IpsFo5xUq/lMa9yq0X0pCoL8rjEs3WO6WwVuKb1Akjk02Ba9QA9A
VLAbI7CkIkgRNr4RAca2YHEIcfWZjheiJ9uOglMPI/gT/G6v27JulZC2215HQr0=
=T038
-----END PGP SIGNATURE-----

--ibe32dcbQs37CEZO--
