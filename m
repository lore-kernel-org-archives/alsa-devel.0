From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix snd_soc_{new,
	free}_ac97_codec() locking removal
Date: Tue, 23 Sep 2014 14:45:28 +0100
Message-ID: <20140923134527.GI27755@sirena.org.uk>
References: <1411438548-8463-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3036148135072713870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9915126508D
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 15:45:56 +0200 (CEST)
In-Reply-To: <1411438548-8463-1-git-send-email-lars@metafoo.de>
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


--===============3036148135072713870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2014 at 04:15:48AM +0200, Lars-Peter Clausen wrote:
> Commit e3f205a72c45 ("ASoC: Remove locking in
> snd_soc_{new,free}_ac97_codec()") overlooked a unlock on one of the error
> paths.

Applied, thanks.

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIXlyAAoJECTWi3JdVIfQtVwH/39vBTYIHtZe9qp81ej2KmCP
RXhx7LImnQw67heFeow0tYktMsdI5vevdDiqHaXjvnjXjEf8hSID5DqaDkNgS0aB
1+f7g8PVzABabUre6R5UUU4GxwpChvKl0ARIVAvyDouH1QlRdoE7KpfYUZPr4ESq
QL1BmE45wuMzRu4M13xqESWW0QQGcVoqqF7XnUDUkD7tvj3KXIM820AcCE6bPNeN
4+u9H4O4cBzx5uMHvb3HS5FY79X+0AChAMT/0f0fX34oEEYTsT2XM/zfXzR/gOy6
lA5q7rBEQk9QIj505vBYYCf/6rFAEKlwsxFLuBQ9xDgV5Rfy9FESNvi7uaWB7/g=
=gNVf
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--

--===============3036148135072713870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3036148135072713870==--
