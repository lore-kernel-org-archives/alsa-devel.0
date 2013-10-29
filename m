From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT
	support.
Date: Tue, 29 Oct 2013 10:44:45 -0700
Message-ID: <20131029174445.GB20251@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4184442163318913689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E346C2615CC
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 18:44:58 +0100 (CET)
In-Reply-To: <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4184442163318913689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 11:56:54AM -0500, Matt Sealey wrote:

> Maybe this is a reasonable place to ask since I am holding off on
> doing any audio support for the i.MX platform I want to push a DT for,
> and I am still bashing my head over the logic in this. Why is this so
> much more complicated than it needs to be? I can see codec specific
> and Linux-specific things floating in trees. I can see redundancy in
> property naming and misplacement of properties.. this whole thing
> needs to be cleaned up because it's been done as "binding a Linux
> driver into the device tree" and this is another example of the same
> thing - taking the way ASoC is working right now and dumping platform
> data externally.

Can you be more specific about all these points please?  It's hard to
engage without concrete technical discussion which there is very little
of in your rather lengthy mail.  Please also take a look at the previous
discussions on this stuff and make sure you understand the needs of more
advanced audio subsystems like those found in smartphones.

> should not be codec or platform specific at all. This is a TI audio
> codec being referenced in an SoC-specific audio fabric definition.

Please take a look at Morimoto-san's work on the generic sound card if
you want to work on a generic card, it'd be good if some of the people
complaining about this stuff could help him work on that as he doesn't
seem to be getting any help or review from anyone. =20

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb/QKAAoJELSic+t+oim9rsUP/ReqMf5CB+1is955/ROmyhea
MlJBqo2Uza3MH/iYb9kE83XiZxnfsMxb9LetXG6oU9DJCBRyGhsTG/FUWheFrxLW
vVIdA4c3Pynmpy3HQpejWmOHXDFE638Dra4dfXXvjezbxRUgfYABpIV6uXI7klDA
tYVDcDNhJA736WHOXLcexsMXStxIJlS636cUKNe9UTFQgUfJ6GzSI8aEIL/zy7FC
HU4TTt3nFRQZQ6gUU3UZRldaM61UoBh3lgJaKHEdkWlv4F1WUFvDAHihQWcuXoZu
IyQYD2NR8eYZclmvT/EXfOqhZ/DSR6KT37SMeMnD8lPDNa0SDr4XBDInEGs8+0L5
BUFJHAS0ouOW8K4tzJygRgfpN7bItmaurHVBXv148ePPyciGukTbnNUwTEXnPyTo
KFnLiymgR4aST/rWgQGu8sqiiIGlEk2v0zxkTU89TdS6mPZNyrng5FOqK/YK8ucz
Km9yzw8sA53q7e5EmOfBAinSwL97ZV0JC9Q2kNPTVI91FRqhSsAOwYUIuF4nlnD0
hJ0Y1NBu4sYv2OntFy5Ld7m/msVotvG9LF9Ypi3Tcp+GzOfNiW0lZNRoYP21fHAk
gs7SWiA8oehFdbYlxThFKS5Dec5qVu7DUqADDYJ+i5GO8ahvoL65veISnIcbxNg1
mVA73sBWYm6s8On7MO1P
=q6jK
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--===============4184442163318913689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4184442163318913689==--
