From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] codecs: mc13783: add spi errate fix
Date: Mon, 9 Sep 2013 15:57:30 +0100
Message-ID: <20130909145730.GF29403@sirena.org.uk>
References: <1378735956-17318-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0577158405482022457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 016CD2650D1
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 16:57:33 +0200 (CEST)
In-Reply-To: <1378735956-17318-1-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0577158405482022457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NpJxosW6I2mTcxQ7"
Content-Disposition: inline


--NpJxosW6I2mTcxQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2013 at 04:12:36PM +0200, Steffen Trumtrar wrote:
> The MC13783 Chip Errata, Rev. 4 says, that depending on SPI clock
> and main audio clock speed, the Audio Codec or Stereo DAC do sometimes
> not start when programmed to do so. This is due to an internal clock
> timing issue related to the loading of the SPI bits into the audio block.

Applied, thanks.

--NpJxosW6I2mTcxQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLeHXAAoJELSic+t+oim9W4IP/3VsmyvgKHqKIKR2duTcRwFw
SQbRDFD1K4ricMxiZP0pdDEALwEbGk+XktwWXTK/Y96a252QbPmE6Z1McNi0Jptf
Zvrn0SL9deRqSvIA8YYz9Y+c6t6KdeABoek8aIhS3p1p/+mHntt7qcBqPnoTa071
InBn6J7omokBT/At6hzuUzuOlK/iG+LZTnp0/4lfpyo3kaWT5sNNVczxMW8rlSS3
yenUBRx5iIzy45VtKXrCKGeIeJeaCZ63S3PCTVdXIeLljc/bqixqS8hSDlNySZAa
c5giRrcLGb2afvWDMkGlbHd76G3Y5DbL4exFuucuA9U97e4bv1ltROTw1fsTPNxQ
onPeucsrIetgx4D/qqlGJ8EHDjFtNmdrCdsWNhhLMSg9nXsoE++iYIEDwIXl/Amx
+0ZZasSxyqQZ5D1NZ69234U/B45DGdFLbci9yUNUREpdUH5otlmLRVopESuMBXPo
Fkyy70pSGBVgOMnBwA0TSaD8y+ECQ1RGli5ITkRwO1XME1I0odUHeFn6f2bb+jdJ
05AoAsiRDBh3N4Cu+wPdU0x2ywe5mycceaEGaTyAGQn+cZGWQV4HVPZn01tRseNR
iKu29nNryu1WfvVYZGovhO9KFjBUvleOn3THhWM2DPU04Algr3X0nio7MBoJZHZG
MtTp77A4mQx1AmdI8Vao
=Wqxq
-----END PGP SIGNATURE-----

--NpJxosW6I2mTcxQ7--

--===============0577158405482022457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0577158405482022457==--
