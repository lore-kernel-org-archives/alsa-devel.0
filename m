From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend] ASoC: simple-card: fix one bug to
 writing to the platform data
Date: Tue, 14 Jan 2014 21:25:59 +0000
Message-ID: <20140114212559.GA15567@sirena.org.uk>
References: <1389674132-14928-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0338439667755819164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50251265015
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 22:26:09 +0100 (CET)
In-Reply-To: <1389674132-14928-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0338439667755819164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HwY7O+GdaLKMYOv"
Content-Disposition: inline


--+HwY7O+GdaLKMYOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 12:35:32PM +0800, Xiubo Li wrote:
> It's a bug that writing to the platform data directly, for it should
> be constant. So just copy it before writing.

Applied, thanks.

--+HwY7O+GdaLKMYOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1atkAAoJELSic+t+oim9v4kP/1CKThpq8yWxL5LUK5o4jfEn
j5hMRHxgPJt57l+60MmAVRsxgRErRMNcIZ4mm9/mne9eNuYp9F3jjbBupkz2CCCn
a2GtBB3p2i2NvuUL2geV5XnVkCKsawrKWZI1yyCmbQMppcPMfB0+IaMDJ7AqY3h8
Sz/UywLnXsyNwEc9k08W6wwwrsg7u71okhdDQvYvd5k1nHC+ewlGpk+R7WmPZ5VT
JF/fNhPc0TutQ1xuplybLAUvhLp8ZIICxoKVwdWz+bmfqCqtxc2q33W86+NbtRRU
Zszq8bTy1pYHncK3QMGE8j79861nrscCA9x++e1sADZ47DFarXocw5Tow1jPcTGN
qvgHo1YAB0g4r1tflxUZ6LG/ynX4pR+aNJaVaiqOFA0bK9LXpgd67zc+vx69j3C5
lb2GPNrLG+ceN9sjVI6krvvQIxreStip1AsVq7x9daWtlK/oDnmZrUBmdQfKa+S3
05scdU/3P1KBUoGNcY8tIvXrHQ5hJjlGukOeHiMJEn1tfSCFlldsU6vZltFpNPEi
HFf1Bl25kzIiXb7HU98+Qi4yMWQYH8ff12sIpQQXehxXPamPcXzfkoj16hWCfraV
/zNko921EBzXuzkFTcnywoRZaANhSEAM2H6AYTyzVkoxdSmjsjFtnVnRbWnsIL4+
O20j8iMeKUTIm0BdILaf
=xQEr
-----END PGP SIGNATURE-----

--+HwY7O+GdaLKMYOv--

--===============0338439667755819164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0338439667755819164==--
