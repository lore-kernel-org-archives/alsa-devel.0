From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: ad1836: Replace direct
 snd_soc_codec dapm field access
Date: Mon, 4 May 2015 18:44:46 +0100
Message-ID: <20150504174446.GV22845@sirena.org.uk>
References: <1430757974-7432-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3708539075443521033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE4E260617
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 19:44:55 +0200 (CEST)
In-Reply-To: <1430757974-7432-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3708539075443521033==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghitYs98853OZ3zU"
Content-Disposition: inline


--ghitYs98853OZ3zU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 06:46:08PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm with snd_soc_codec_get_dapm().

Applied all, thanks.

--ghitYs98853OZ3zU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR7AOAAoJECTWi3JdVIfQBy8H/1YA0WKIxeWGbxo22IP+jmVx
nzPeigi5869HM8KNJxdORMg02Ppsdw3i5QUomOd1trvUgtzRIFrBNJBeWDvugi4E
T93+cam7BrSjbW+Tu/W/OqsmwMlzTjsAD896ig8nSwwGalAakRvRzR+1HFtNbH9P
VZ4Y68wvLNRLtVoyAMb8FzNjWsJF3eEkkY1FDPGBX2BvXmfLNg1EQ4vDY/CeceRc
vf+Gjy6JQsiHkIfrcIgzXxElGySVvVeCvNSZsx3UNCe2Md5lye3lqLktXRMq3uxX
vLeUPlgSuCbiSWtoWXLx7Av+SgctzHrvVLKHiHhFXoB7q8WftL4yG/MdtBIgJwo=
=3/U/
-----END PGP SIGNATURE-----

--ghitYs98853OZ3zU--

--===============3708539075443521033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3708539075443521033==--
