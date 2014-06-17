From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: Prevent double lock of
 accdet_lock mutex on wm1811
Date: Tue, 17 Jun 2014 15:48:25 +0100
Message-ID: <20140617144825.GY5099@sirena.org.uk>
References: <1402950243-3490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4613039420621841480=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EA732654A7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 16:48:50 +0200 (CEST)
In-Reply-To: <1402950243-3490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4613039420621841480==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qWQny9krlSHwPXz2"
Content-Disposition: inline


--qWQny9krlSHwPXz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 09:24:03PM +0100, Charles Keepax wrote:
> wm1811_micd_stop takes the accdet_lock mutex, and is called from two
> places, one of which is already holding the accdet_lock. This obviously
> causes a lock up.

Applied, thanks.

--qWQny9krlSHwPXz2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFU2AAoJELSic+t+oim9izIP/RkimR0y9hXObjbKNesAFtw9
660s68H2eIFCtu2MoFVl/6WdHqlzlVtXEARZywR+ou7daqxAx4Rt7ZVHGhTxKNRl
rzY62iiKWVV9KRhSJZaVGCKPo1rtxFqga93R3KvOz3gFp3xjgJk8mrlf4/ZLIWxb
2RTaznepO39sDPeLysdP+AWZG3lMTRw78CP7e4ucyfVnQi7ulkcE9SkHUxQxtjFP
ufUQytjtkSOP9gU65ly5E6N1fHkL1u6u1hX8LXFk418ldT+hlbYACcBpia/bcG8f
m7bu7jjmt6pOj+1kN1RDMHwtX/OTvKKZyhdvABTIbDZy6dthLUVIoiCOkknOPeRb
+B06S8k1HRfUv9kmfRi5OkfR15vgu+Mixh1jgdMTFC8WrgdOofwRcK0T3kvqh4B7
Ur5dEwuC7e9mFib+eLSm9Unlhqxdk7C+vqVYxeAyCAyBoYmOMAFYwR1u21UGr2nd
n6lFWr7CoNATFX+6BRw+vL6jqyLDicSFnT+2ByBvRGwB8ThfMOeFYd/UxQaSRECW
c+cDxn2J2UIcTUwXdURY5/vtFeaa+bqVoXGt6k2rdTT4oEd12t23VSFJBWM/R5vG
xYBKH61Vh1xlzc/B5926CopzIVZqziEG+2wHSchlHFAyIInjGu1G3cZ+AIhSrZDd
R82nnG3Pgsuv5wDIlktC
=1Q+L
-----END PGP SIGNATURE-----

--qWQny9krlSHwPXz2--

--===============4613039420621841480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4613039420621841480==--
