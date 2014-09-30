From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Wed, 1 Oct 2014 00:09:06 +0100
Message-ID: <20140930230906.GQ4273@sirena.org.uk>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <20140930174241.GA1296@Asurada>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5886837790614486308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D8FB2608F0
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 01:09:20 +0200 (CEST)
In-Reply-To: <20140930174241.GA1296@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============5886837790614486308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p6hDAtPN9q+ZnUca"
Content-Disposition: inline


--p6hDAtPN9q+ZnUca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 10:42:42AM -0700, Nicolin Chen wrote:
> On Tue, Sep 30, 2014 at 05:45:10PM +0100, Mark Brown wrote:

> > That select shouldn't be there in the first place, I asked Nicolin to
> > fix this when I applied the driver but he's not got round to it yet.

> I think I might have missed something around those days, even though
> the 'Applied' mail seemly doesn't have any comment against this part:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080083.html

> Is that possible for you to copy and paste the comments again?

I suspect it was on an earlier version of the patch or a cover letter;
IIRC you were resending while I was reviewing.

--p6hDAtPN9q+ZnUca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKzgRAAoJECTWi3JdVIfQm2sH/2w+PzlBwjaPGTGX+27daSAe
h4H5mVQvySLW9dpubsr2hXtSGbHaCQ6RZDKu4k5LFFXk0bM+EJPc2gnW4jS8iQB6
ntI9eFa+g4fLbB212yIzX3XesesRdxkrLiRylGJPI9DaO5y76KMQw2dUnVNKt+Ry
aPU4qgIeiCddArcdt+yFw5o71N69Pm3zuNmggKg0ix+gSJe4/1F1bH7gkYsekqsQ
sScW7xxQjd63yFqf//kEsxjGkctg5K+Nf1VS8vYwyKfnB49JrY6qZTPbRMoVKIGt
3i9YmeDojxG3WubUU+xJs80nTRqFB9PBTu1oooA6Lmtke52BPVD9g4lbypR/xwk=
=ZHuC
-----END PGP SIGNATURE-----

--p6hDAtPN9q+ZnUca--

--===============5886837790614486308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5886837790614486308==--
