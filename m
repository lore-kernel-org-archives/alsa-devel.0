From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
 board binding to CODEC binding
Date: Wed, 7 Aug 2013 17:30:31 +0100
Message-ID: <20130807163031.GK6427@sirena.org.uk>
References: <1375866978-14726-1-git-send-email-broonie@kernel.org>
 <52026F84.5030204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2606692331688470967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8257C2617A6
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 18:30:37 +0200 (CEST)
In-Reply-To: <52026F84.5030204@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2606692331688470967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cFq0usrlMbRL+LaE"
Content-Disposition: inline


--cFq0usrlMbRL+LaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 10:02:12AM -0600, Stephen Warren wrote:
> On 08/07/2013 03:16 AM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio=
-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm=
8903.txt
>=20
> >    the second being the connection's source. Valid names for sources and
> ...
> > +  sinks are the WM8903's pins (documented in the WM8903 binding docume=
nt),
> > +  and the jacks on the board:

> >    Board connectors:

> Probably want to remove the line "Board connectors:" ?

The board is still defining some jacks.

> > diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Docum=
entation/devicetree/bindings/sound/wm8903.txt

> > +Pins on the device (for linking into audio routes):
> > +
> > +  * IN1L
> > +  * IN1R

> I thought all the pins were going to be assigned numbers too so that
> bindings could use either?

I think someone who wants to start using those should get to pick
numbers they find pleasing :)  More to the point it's more effort and
I'd like to see it in action to see the nicest way to write it up -
create a header and refer to it or just put it in the docs and have the
numbers assigned with new DAPM widget types embedding the numbers for
example?

--cFq0usrlMbRL+LaE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAnYjAAoJELSic+t+oim9xA8P/15iOWwPTlIeUcudqRiAr9wp
jM6eSZz7fHtRVoMg7cJpz+OLtsnG9pHdkOZcVG8Sb/czLqrOigAip/E/u2BoE9W7
i8r5DAG/YMKK4USfSA86c3K9RORs4pITJcesiMPnvlSXcuD5Cwwfs9XuuxmwFQf9
ZjHeMFbvS9a2fYsOdTqLVxh37/erELA2TZSlm07Rh3FVK7QMOOPMSquluJuxRaNi
790NekIZFtoBNcOSe7P3Y7NuFrJZbTG+Lpwp2op6rJzBXKdFQSN+1q1vWgQ4WD6M
P+4zeJr00jCf9p2nlJZCOofRvdPjjE4Z5sQoKWxYpoPNBVJ7hWBPifPGOI6PvWTx
S8JgK9pB0ZpcGxEcK3W4nzHgTC6wXX3Auv9LKY4HhPil+fWNPuPHwgNEpTKt69hZ
62IlWG41Kb6n/U8cu/ErloHa1B5/DJ4S0JuQlb5+G+M1YKVJztZoNupwXjRwVmt1
K6wHKu89IslO3urpHHc7nx2riNrlVGuhdyM0fZFl4l1aF+r/Y/l33+XoQMQUJbDn
RNUZ63ZoTHHnvkDZMHODAEFGBF3ugljqABO+ek5tg49H1n6GHQ83TTqRkFtZWcg8
CvTZRqE1TNkF/BbWmDklz2D/3YpFYuP/USx2KSAs5HEjvC6R8Wq2OOoE2Zaw7JZp
4mgGgBe4A19Ct9+vkAK6
=2pZu
-----END PGP SIGNATURE-----

--cFq0usrlMbRL+LaE--

--===============2606692331688470967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2606692331688470967==--
