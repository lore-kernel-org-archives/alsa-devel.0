From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove IS_ENABLED for INPUT in
	CS42L52 and WM8962
Date: Fri, 2 May 2014 09:41:28 -0700
Message-ID: <20140502164128.GG3245@sirena.org.uk>
References: <1399041041-32261-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2261685747129221355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CFBD6261AC1
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:41:42 +0200 (CEST)
In-Reply-To: <1399041041-32261-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============2261685747129221355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jHwcxWEthkc1rt9P"
Content-Disposition: inline


--jHwcxWEthkc1rt9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 09:30:41AM -0500, Brian Austin wrote:
> Now that INPUT is required for the CS42L52 and WM8962 we can remove
> the IS_ENABLED(INPUT) check in the drivers.

Applied, thanks.

--jHwcxWEthkc1rt9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY8qwAAoJELSic+t+oim9k1sP/iaSq8FMvMn4Z4NNjmtYwVD8
KuVODyhrzf7BZW0zR2EWoaGKb16gzMqDwob8NLxbzhk1YQvk7/62LaOT/m8N6ugH
0Pc4ShktBbs0T+mSP7WRUMyRVkPVVrDLmaIEcL1zzFwf09N/foPzOJ3Q195tIOhf
xFhbg4T/i4V0GyPxRQXojFUep4t1K8WeJA33i47h0FJ6UdcSZCgkMsclpK7Tp3Y9
TvOnvXq5qbACUeBLN4HzKieWMMlq80J8SWn524WNjMETGtHObe5JTZiV542IX20G
tQjfo2qmi24PBcWVSiWDim7dQiTJ+t7m8IVksNJ8nnAdOUv4853KQ+o7qecWrVdn
LwG5fPMwy3yec683LaTCU1b8xTrJ1oWYVDuPNFh16UbyFU+HFp+NYmoPyPBItRSN
+MwVef1Qh5xZjpIgOYLDs0FM+dW/ha66NQaa9wxnfZnYTk55lUEJ5PirzQdQiSpr
+NKIXNZNePcWAQYJIHvPX3WVGQnlhO861lZ0SE/C7sKVdC4+4oF46AKwCwDAe+o1
0JdPSGkfelJEj98wQgaWEISSk38L1XIzagGZkN1Fe2vGwVH19yJsqWSulMU4gDgm
XTmC25elGxEMxnLB8ZjF5KbzpxidPSWtI6+HFv7CVT9cBt6k9CEdUgHcodUZpqIX
PwMUY99YCpHFas8dgz2h
=GgCz
-----END PGP SIGNATURE-----

--jHwcxWEthkc1rt9P--

--===============2261685747129221355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2261685747129221355==--
