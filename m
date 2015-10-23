From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: AMD: add AMD ASoC ACP-I2S driver
Date: Sat, 24 Oct 2015 06:17:05 +0900
Message-ID: <20151023211705.GA5103@sirena.org.uk>
References: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
 <20151022161415.GU8232@sirena.org.uk>
 <CANv6ZMY_8MzZK0StdgAnzN7EqZVJ3tMz88pKACb3sGKXmRTtXQ@mail.gmail.com>
 <20151023193152.GL29919@sirena.org.uk>
 <CADnq5_M_XyTgyfCpSfA77ce-rFCkRJg6VkfPWriEHNkRbU8m-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0941896656=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_M_XyTgyfCpSfA77ce-rFCkRJg6VkfPWriEHNkRbU8m-Q@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, maruthi srinivas <maruthi.srinivas.b@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0941896656==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2015 at 04:39:07PM -0400, Alex Deucher wrote:

> something.  In this particular case, most of the common infrastructure
> that should be utilized for this particular patch set comes from
> non-traditional x86 platforms so most of us that come from a more
> traditional x86 background as not as familiar with them.  Searching

A lot of this infrastructure (like genirq) comes as much from the x86
side as anywhere else :(

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKqPQAAoJECTWi3JdVIfQMK4H/i1HRRqLRAHr8A9nA92IFHIX
e/D1CG2TK6OwD5sQwKxDapbqjGWy2N7Vf0SMjW81/+I/GqBR8L+7TsXBuUFPBhIO
oAHXL33Hy1VwTKyl1Re4PLg3wiEH3DyJmV0iogo7rK3nu8izmPVv2S97/IF0+/1u
4zLhp4xra+jODUkswRwmKA3HBhHJyKtFRrhIFTtcQfRundRNT+VQEX08ftUXOPVK
WQdohMeftty+SRly7il3YTz4epCfBmn7otU5SX95NthSODDu77qXGUSaEXroNaIE
+ZPIJHrKn5FQDAhyvGoaH5qeu1//3idvPIdFmV51kRAzWNqgcfLvlP++rW+cPrQ=
=KUAZ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============0941896656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0941896656==--
