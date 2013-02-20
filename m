From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: max98088: Add TLV data for volume
	controls.
Date: Wed, 20 Feb 2013 17:26:57 +0000
Message-ID: <20130220172657.GS2726@opensource.wolfsonmicro.com>
References: <1360947310-15217-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5232885497722774229=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 565A426171D
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:26:59 +0100 (CET)
In-Reply-To: <1360947310-15217-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, evan.ragsdale@maxim-ic.com
List-Id: alsa-devel@alsa-project.org


--===============5232885497722774229==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHrxbAcqt/LxKPZN"
Content-Disposition: inline


--eHrxbAcqt/LxKPZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2013 at 08:55:10AM -0800, Dylan Reid wrote:
> Specify volumes as defined in the MAX98088/9 data sheet.  Allows ALSA
> lib snd_mixer_selem_get_playback_dB_range and related functions to
> work.

Applied, thanks.

--eHrxbAcqt/LxKPZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJQdSAAoJELSic+t+oim9cq0P/0N6A79dDk1qA4771hz8D5gE
8NdOBjoN3Zzrh94DkQWtSvHpGr5iqqNadQCAgVEnpO0IF53rhIIfNojx3oE+WLqp
bjtavsOOIuoPRKpopt7a/FzWogH7ONDG0vWu+gou+JrbqIyDYiJXvvnv8LwA09T7
QxGmTHqjgv5GZQLQCjrQh1AVJ+smY1DgCpuMGGJQtHit2SdFNiOTkWaBXSvdticS
kI4yknpRb/wv2KEA7GmH/9+v+yBhtYYNkPByey6eu0yVqycdLoKou2DBihUpC5G3
ktr6Xvh/FI+EKXwft8uiRp66hvzw9DDlkY1gQCtKY2bRASs52xTLLLoQ4/wm4pd+
fO06LJ+zckTmnv0u5c3wGD27HKBbeVD2neGaYrovfIBxJnagQrKDPSLD7SC5H8oO
gNwl2mG6RnR11T3LsMAX0OOsXuj8DYV4RJUHxiBFHX4Nzyx7ylhAoqlY/lNJHA0z
ITSAwIIKE+wOst24TjCYDBI2wAw6kCpP7uuPgZGCcnBnfCaov18sRQ2YOal7nD4I
fRDvq1GEowYz2Ies6GnBF9M/8BktPdpJAEtSJBRXrjpnCp9xFaaUJm1WhyeywaDq
jEPDd02pWKMjua69HAqXiy7Fb6puBfehDWYqGzKc3Ix0IwiTt/IB0Iii+SEMTE7C
gRVhx/O2uGdAcVpagcI1
=/YLi
-----END PGP SIGNATURE-----

--eHrxbAcqt/LxKPZN--

--===============5232885497722774229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5232885497722774229==--
