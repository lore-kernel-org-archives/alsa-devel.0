From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: add clock source selection
	controls
Date: Sat, 16 Aug 2014 16:57:58 +0100
Message-ID: <20140816155758.GV28623@sirena.org.uk>
References: <1404808044-2747-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784294759205632354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93C3D261A5A
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 23:38:07 +0200 (CEST)
In-Reply-To: <1404808044-2747-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7784294759205632354==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Content-Disposition: inline


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2014 at 04:27:24PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We can select the clock source of some digital widgets in rt5670.
> This patch adds the controls of those selections.

Similar comments to the rt5645 apply here - generally we manage clocking
in driver code since we need to coordinate with other subsystems and
devices.  As I said there it's possible that there's a case for doing
this directly in userspace but you need to make it in the changelog.


--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT73+DAAoJELSic+t+oim9KaEP/A1y2ZGxUo6llwA8Z+f+ePo0
W62IfCqwJGNHt3D6FwcGmJs7o2VQiVtA/c0CcPc/pLrMcH6oBdNBnD/Kwo3+rpVG
ZgusPZ+Yxy8GrhfzGO9o2rmH7W4z2MWwTwUFjzmT9E7n7x+lZryBOiqDgrckln9m
ia0owHhXOphWizPdQFmKpFZbz75IPUyhFgVkCk1PPonegpsXG3m0ZIPL5RPoiBq9
mNkVtCP/10cAyFgQPw4nkvGqzmGQWxGDau0CZdNwQwKksSqMbzuYc0JsJ4F1deFz
aYFqQKiAI0PAP4CxHTWaLXcqT0LLqpASKBEGhqljc2IlEeBsdErPX51UOHGEKL8r
/V2wpJlJXHefgRy+ybfuKtvsYv8pomNYL5TsR7MCnEYVkfp+3nptQVPQodSSW/Y+
L236EppLzMm23O012nfsppgqwSZtZ3bDB0ziXFhBUXKWWKT3axZ/ll6uMUea7mRH
XFvjkRCFtXxBd7/yJ3m8dpVAstfDxlZVnFb7kkywuQ63m+3WhYVcXjhfqUnj9Dau
JJWmaCwObTF/EQ4VylB5JfPFmoZCBAg9GaHCz4QuUaBLlBzisRGrSz0AWcvnhBuj
AEQN6NC6PL54ONOmBiA+TZUUhJsyIp3G/2TC8dzki/mCeJ/7QmKMKS8tozJWp2Tt
qBcQdbwP+8wYL3Fj8zKt
=vC0z
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--

--===============7784294759205632354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7784294759205632354==--
