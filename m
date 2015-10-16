From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: rt298: correct index default
	value
Date: Fri, 16 Oct 2015 18:14:44 +0100
Message-ID: <20151016171444.GW14956@sirena.org.uk>
References: <1444980092-8801-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474459651289642123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D773260453
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 19:14:53 +0200 (CEST)
In-Reply-To: <1444980092-8801-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, ramesh.babu@intel.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0474459651289642123==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m62MDEjg5u5lTXSK"
Content-Disposition: inline


--m62MDEjg5u5lTXSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2015 at 03:21:32PM +0800, Bard Liao wrote:
> Some of the default value on rt298_index_def are incorrect. Change
> them to the correct value.
>=20
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
> This patch is base on topic/rt298 branch.

=2E..and the reason this was conflicting when I tried to apply it before
was that there's a change on the topic/rt286 branch for this CODEC.
Please, if there's issues with things applying like this talk about them
and say what other branches things depend on rather than sending
something that applies on one branch and then still needs cleanup in the
merge - that's what the issue is when things don't apply.

--m62MDEjg5u5lTXSK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWITCDAAoJECTWi3JdVIfQsj8H/0EKi35WQyghUPmQb0wmjwaH
pHxNTSalWza04KxMTzUWtsN02BP3kEPFSiY16IA0bqJcfXTPWagng3tFZdhRBrEH
yxYZsC/ZM0i6y3OdsjgxefAEJ3JsnbdzFBMIqQKk7/Q4rzNQOWgob5atoIfWEUPO
HkXibS/m5C385R+gvyS2YUu5lzNaW9dU6YYYs0pA5J0doWPTXMDMbxCLpm5VwlJP
AjcENcxmqij9TGoxB/rIiO7Zdw2MF8PUsEeqdOH4suc7wbA0XaELuqCIJpJtHoIz
G+e6B1gYtQLeDipMhhpr+evfR4C5qUyRkfK4nMnjO/Pvw5XJhidxWle718uBC1s=
=3Fb0
-----END PGP SIGNATURE-----

--m62MDEjg5u5lTXSK--

--===============0474459651289642123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0474459651289642123==--
