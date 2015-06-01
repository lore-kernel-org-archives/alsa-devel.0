From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/47] ASoC: cs42l52: Replace direct
 snd_soc_codec dapm field access
Date: Mon, 1 Jun 2015 16:46:34 +0100
Message-ID: <20150601154634.GB14071@sirena.org.uk>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0310190254522986837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7182026062E
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 17:47:47 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============0310190254522986837==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 10:10:20AM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
> other manual access to codec->dapm with snd_soc_codec_get_dapm().

Applied all, thanks.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbH5aAAoJECTWi3JdVIfQ4fMH/Rq6UA2FfFsLlKEaRZ0ucSLB
r3uB2agNA0KMUDOyxv7FdriX7HNfKI+CdbArYkUpDBSf23cmMVLw88IfpVnTGEMp
iRxflDa3H981laOWZr4SIA6a8LaJCumlKpGA82RTyNXR9YC3D3Kx+dDE369gAS/y
WT1VPE3aQw9KgpbcfWcvYE5smDvqcwLHVfExZFwkMgHX+9hzpaxYt2UkNBZRi9q+
LV5qWiiaQxsQfcjYbN+D8t6jridzp/iEuLM57yfAWExIg6D6XDzT139U5v/NBp8S
UEA6A6xjJgUYJtNjaYeExz6QICahvDzWHvPhrZeFp02AP+j4AsNcXwvUCc3gUuA=
=CqH8
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

--===============0310190254522986837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0310190254522986837==--
