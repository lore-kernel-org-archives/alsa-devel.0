From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] reset: Add (devm_)reset_control_get stub functions
Date: Mon, 31 Aug 2015 15:56:53 +0100
Message-ID: <20150831145653.GR12027@sirena.org.uk>
References: <1441012943.22251.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xi/AxZ9U2VfEekdX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441012943.22251.1.camel@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xi/AxZ9U2VfEekdX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 05:22:23PM +0800, Axel Lin wrote:

> So the drivers can be compiled with CONFIG_RESET_CONTROLLER disabled.

The lack of this is breaking the build for the newly added ASoC STI
driver in some COMPILE_TEST configurations, can we please get this in
for v4.3-rc1?

--xi/AxZ9U2VfEekdX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5Gs0AAoJECTWi3JdVIfQ5p4H/jcjd03J7W8PW/NUmczxnC39
DY07GK0PDb0u7Ed2JE/YnVS8WNHtY/q8hGXBeYDaW9BZyuOQEkoohlmtN4fTYLkM
PdcnFCfs2VMJL++Z/6eZ16VhxVfHYNBSnuxEuCPK+ITJuhXbCs3IcL0aNvBPb3CE
LF9yYV3TNOBNjREVzLTk6mtqbxgZ5jihzKuLkhePCCVLNWU1oXDjQBy9RfcuTLjw
ZzlQ58Dn0Lr9rQ2pA3m5en6SLYHYv7zJgjwUsEb1FefQ5kDJKyonLYlk4fXlVQu9
CAFSMLLjMMKAw95/7n+KI44807RtGKAQoKR7Yrz3ODb1itFm2qmeAuKnOGxVJg4=
=igxG
-----END PGP SIGNATURE-----

--xi/AxZ9U2VfEekdX--
