From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Update FW version readback
Date: Wed, 16 Jul 2014 22:27:50 +0100
Message-ID: <20140716212750.GA17528@sirena.org.uk>
References: <1405385472-32743-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4704953275643288479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 413C32654B0
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:28:02 +0200 (CEST)
In-Reply-To: <1405385472-32743-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4704953275643288479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4HoONH8zr3Mj5MZN"
Content-Disposition: inline


--4HoONH8zr3Mj5MZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2014 at 08:51:12AM +0800, Jie Yang wrote:
> Update FW version readback. IPC_GLB_GET_FW_VERSION reads back
> the ABI version whilst the release version is in the mailbox.
> Update to use mailbox version for info logging.

Applied, thanks.  As I think I mentioned previously arranging for this
to be readable via proc or sysfs would be good, it would allow the
information to be picked up by alsa-info.sh which might be helpful for
debugging.

--4HoONH8zr3Mj5MZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxu5SAAoJELSic+t+oim9e0kP/2D/qHKAZYiag2hgJyjVTppo
2Oc3ewrFlZsmalxZO0M6X0DhGNLzOE01vHASJCQfnaJpkb1zPyCLKDhhDFaaqvXL
q8jOdKxhgFRrwdqm4wANA9B0CFwh5I2fU2Tq2TxMe+43a9pDf6LREkwwWI3HIsQr
wwUkIqnSxYsEun7Mt3McoHEmIyIug1Dbw/sdw8kGM6UvfYrU5TzmwKbuemuZVvBE
Z3MpOEdSLpGa2Gd9792ASKbitXhIe+gXQpUqt4kaarBrPGCfHl19kjOL9nSSqIGn
/S4gxVwhN0NYPpLYRXndu99nltQxw+W3rfMWOeZ4QHLaIGebyAHhrn94OBDNjl/3
j8W6daDbOA4yX/E6r2DgAeVN0ieSJxJT9Wksws+w47fY43SJAaDwynb4uuxvUm4O
tgLVBUHGbXy6Q171Ui1BQpgouHl5wsC3RwxCq/VInQsIXYVsTPf1UPD1TB76tAav
KT8V1yoQkoKPnNBy4hls34FakgKHaPONOLZGnnQYYfo7ClS4bF89BjzM3iXS+i+F
k/VWx19Knq6wglY8ekE9KHtKZSgveLdBDlfN53n6QvPhWmgmNkUOk9ACTFXmjQL7
HxQq+2FB7K5BPSvGCCdRnOgbQ0d593obQQeAgr6ScKNr1sou6Jk0hFY8GR52ZFMM
xryLAKX/3BEjTrRaZtd3
=zHBh
-----END PGP SIGNATURE-----

--4HoONH8zr3Mj5MZN--

--===============4704953275643288479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4704953275643288479==--
