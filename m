From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: fix error return code
 in imx_sgtl5000_probe()
Date: Tue, 16 Jul 2013 14:51:49 +0100
Message-ID: <20130716135149.GM22506@sirena.org.uk>
References: <CAPgLHd-cXmWwMq8DMhXbOhykZvnMzxb4HHZ-5ayNnkPU1fqfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8641771946592445011=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C34F1264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 15:52:11 +0200 (CEST)
In-Reply-To: <CAPgLHd-cXmWwMq8DMhXbOhykZvnMzxb4HHZ-5ayNnkPU1fqfQQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, lgirdwood@gmail.com, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, wfp5p@virginia.edu, grant.likely@linaro.org, shawn.guo@linaro.org, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org


--===============8641771946592445011==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ToWwKEyhugL+MAz"
Content-Disposition: inline


--9ToWwKEyhugL+MAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 08:05:07PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied, thanks.

--9ToWwKEyhugL+MAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5U/yAAoJELSic+t+oim9YNYQAIh5smhf1bjLdc/sMFmic1jE
YWbNcOC9ypSY+HDmQqm/nz0h2Mk/zjzGrZyDNCI0ce6Llv0SuTI8fCVg7IZauCWv
y8+ect573u9Hs+lU5JtYi9RWEyl5KsS0cBEBeg6LiOR/eEBYB1ecvKnLS/ZTRWde
6Qf8xC+B/Nu+/kyPU6vdxEG3IRsmq59pfBJQzDuJGrhoeYK04ibX+sKB0ORjWq2k
rm7AX+uys9+/CUWmRWRTUoDtW7nyZUIbmil/GB3KmOEiJk0fe7aIOW7DHqETXOI+
cbA/Vk61yW8dDYx1yURaiJ3W/jUZrvolaYfN3pae4j7qIa6W2R3uof2S8CEA40u+
xykyMqIOq5THtdUSk6tnAtClYksECfWJws14xQ1iGGBjX+ZP6J1XGyNDTxJPoyzr
cXFyB4Mcd/68W7C5dJlzKtvUScrFy+pTxRha3WtTPF6MDxNdgPUtAJcVjMm+4J+q
jyKIzy6WXu8BY/gEXWcYfbaRtiPBCCZl7HCwp+dNQPhcMmYeA72nox+BArT2weXA
c5NlNuSVRo0nREocLka50p0kbkCuMsR5EbA6czcSs0Ct3GQBuvTmyAV9YypKMLdf
Dznesa7oVZ5hhb6iCICfZoir1Euvkdp/LGvX7tXrBJEH8bmiqIYPAqVpBkCg8pMO
+DULGmMk8MS+Hcp+6H4X
=JRGW
-----END PGP SIGNATURE-----

--9ToWwKEyhugL+MAz--

--===============8641771946592445011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8641771946592445011==--
