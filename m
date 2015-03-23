From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] ALSA: jack: Refactoring for jack
 kctls
Date: Mon, 23 Mar 2015 09:35:43 -0700
Message-ID: <20150323163543.GD14954@sirena.org.uk>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <550FDA5B.8020604@canonical.com>
 <20150323150031.GB14954@sirena.org.uk>
 <s5ha8z34uoi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244654930839221532=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D9C12260421
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 17:35:20 +0100 (CET)
In-Reply-To: <s5ha8z34uoi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@intel.com, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============1244654930839221532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 04:09:33PM +0100, Takashi Iwai wrote:

> Right, but it's a bit irrelevant.  We do want to have a common core
> code, indeed.  However, as David suggested, the latest patchset still
> doesn't care about "phantom" jack that is a mandatory feature.
> HD-audio create kctl items even for fixed pins without jack detection.
> This is needed for having consistent pin mapping.

OK, right - phantom jacks aren't something I was aware of.

> Now the question is whether we need representing the same item for
> input jack, even though it's nothing but a place holder.  If we want
> to have consistency between input and kctl jack items, then yes.
> OTOH, we might want to drop buttons from kctls in anyway, so such a
> consistency has no importance.  Then we may just ignore phantom jacks
> for input jacks but create only phatom jack kctls, too, either by
> adding a new flag to indicate that, or let type=0 behaving like that.

I'm not sure I see the relevancy of buttons here?

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEEDfAAoJECTWi3JdVIfQCm0H/0+m5BlIEATYANG2Tro6rW4U
Sk7oky4DG4ol1FPNVG/fYBJHJqDEJCepdpoozTRLGXZDld88EvIg0V7Debk40WlY
LmH37K6hOuKv8lTUbHk68be4X488FJv88yjB0izm1kxEA1kdVATwFVzY+BhWt9a9
AvYssQHoWZxuZ2qP8K1Ev1SOQGEEaIsg8mdoFScSBcO2/Lc5JAmYSkty6mgG7xez
pLSYsZrWzPreXiDlCWtMi9oLgOsBJ/iRiF92z7GbHUSj/Jh9gh1lEuZy0SspaAIm
6Yjd6fWnfXwcF/C5xd1QKOYwNiN4CYiCf9u47yCVnddrePq01s1SV0mjGZD2uqw=
=CCVc
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

--===============1244654930839221532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1244654930839221532==--
