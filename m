From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm_adsp: Use __leXX for little
	endian data
Date: Mon, 20 Apr 2015 14:59:25 +0100
Message-ID: <20150420135925.GK6023@sirena.org.uk>
References: <1429534365-13439-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4839760805272030664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5067265CCB
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 15:59:38 +0200 (CEST)
In-Reply-To: <1429534365-13439-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4839760805272030664==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a6rOogRKEuQMT5d5"
Content-Disposition: inline


--a6rOogRKEuQMT5d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 01:52:44PM +0100, Charles Keepax wrote:
> Using uXX for little endian data, was triggering some warnings through
> sparse:

Applied both, thanks.

--a6rOogRKEuQMT5d5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNQY1AAoJECTWi3JdVIfQ86gH/j9fg4WvUVKNe6CfINCd7KKS
D9Ee/66Jkuud4lL/0fLqtNKhFja++N2e5QCzAcS9ftp/vG1DbgkCAXRY3iPLUyP7
lmZHJZ0oLvsDz6zXNyJ6er2GtU4CRmgP79nyIki3tgssyDiUWhBQ0rav1xsDp9wX
DyF2Dtv8MVt6sZ9OispBoPqNhVp+THdVxz637ZNt8TZCaHbYHrazjnQ252Td0qYL
DP27QdJv+2M5sFPsKirceWulSl7regMqdUxKNWI7SFvwk7S3XBCT6pwVfjgzunIS
ezPH6nRsQqOwTrw3UKYhN8QURjC1O6pL3RfjvPi9A2ufGyfzz2dIZkTNbeRBJ/4=
=FZqt
-----END PGP SIGNATURE-----

--a6rOogRKEuQMT5d5--

--===============4839760805272030664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4839760805272030664==--
