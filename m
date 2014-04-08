From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH Resend 1/1] ASoC: Samsung: Fix build on
	multiplatform
Date: Tue, 8 Apr 2014 18:38:16 +0100
Message-ID: <20140408173816.GL6518@sirena.org.uk>
References: <1396957264-2247-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7703256516233983701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3C2B261ABB
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 19:38:34 +0200 (CEST)
In-Reply-To: <1396957264-2247-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7703256516233983701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 05:11:04PM +0530, Sachin Kamat wrote:
> PCM and S/PDIF drivers referenced mach headers for a trivial
> data structure. This caused build errors on multiplatform builds
> as machine headers are not accessible from driver files. Move the data
> structure definition to the driver header and remove the dependency.
> While at it rename the structure to avoid multiple definition errors
> as the same structure is also used by the platform code.

Applied, thanks.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRDQFAAoJELSic+t+oim9NpAP/36zlOfgbDfs7ZeDM8682G5N
Clhu9+A/s32etJW6ROl3peZB0e/GJol8A2Ph8DvjyVZuawASTVSvarj9tN+6P7ow
XcAnnGHTvY02aIs6cOKj8Xll6KSToFDD0tjS9GIZ8U2LUpbd8tn/J9mTa14b+eyU
MTy0R+9kFbTCU/b2qGe6oYZltYwcPL9t9wlhV9YMI0yajjNaWqP4eg5dwbfRGbPZ
b/3OEAvil75CFbdfvtttPLVp98ek/bGWnVL/Ur1S+hJIv6TFuE7x77ed+9sYoKV8
fSxtEbsTUo0S4tF50p/FWQbk0mEK2Lu0ZZj1ar5GLjltMPJekXFBJb5xLLA7xDpo
Q3wguk7QQlwMi7kqgTC1YNVzbKIicKn6UYzyApwoCf79MsjJ5EWsHWFnI9YMC1/c
S3Zjh9+UFUmoZBDiwH0COQ2JcWX4ix/NO6BQGyIbrKelbiXVwB1cIyTaexJ3zo91
2vBr5UAgE7ayvXed04l2GGVHTGdyTRFvBNYcvVcOMkmTFyX8aDtsZlFWxYYJivak
dgwCr6rHyQD6JX12qAyMJ4MoXkKu0bOACOW6jpDX7gkC6kXOu670ALRWBMKU1Bfy
X5LJYsc7Nr9n1mtRbK5gHYqEkkUYJjEETIQ4D52cx0QXKfY6EcPMwEyW6LneYpv3
ilb1q7CN/AKvqZrvdoot
=YA9s
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--

--===============7703256516233983701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7703256516233983701==--
