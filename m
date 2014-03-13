From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: don't select RT5640 if !I2C
Date: Thu, 13 Mar 2014 09:45:23 +0000
Message-ID: <20140313094523.GH366@sirena.org.uk>
References: <1394469520-22504-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2642265712976455817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51A1C265317
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 10:45:31 +0100 (CET)
In-Reply-To: <1394469520-22504-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Jim Davis <jim.epost@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2642265712976455817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 10:38:40AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The rt5640 driver won't compile without I2C enabled. Hence, the Intel
> Haswell and Baytrail+RT5640 ASoC drivers must also depend on I2C, since
> these select RT5640.

Applied, thanks.

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIX4wAAoJELSic+t+oim9Jb4P/i0/vypRHt/4sZTP4HuLLCrH
JNSqyuPrjYcJPxNnLMvkC64svm+495Rc6OoiGe8e9dr9AXSq1DyWU9txSb87XeSN
ZD2WkGTyhLfZlg1oaQ2tYErv5EkwybNfzBhdEf/Au6ADMgf7m6TuuwVIW6azhyLR
eKP0zXXcXMRQNFtjbENZtnjUGbvMSnBeslE/PhrKZN1BBmuQzj9Gl6Wii06P+A5Q
QUPxWIyIurFZRhlVxJJOhqqyvHCqe9/vvUZCLobXOk5f8Dx9OGkf3zxe3cxrc9Sd
BhWe3Y/iIUyPRinubMXcAtJpxFCKDcKrNO/o0V0AdIW0IM+CARTaYk6X94l9A9DO
nwkP5mw9HxZMaI6jKAtTRuyUwVz9XTfFqRROKllgc8HN/QYsrV7Oei6E/mFDEHEa
Xux3+fP73RTah1BNrkI0k1fhnOhTyZ+leMetics4pzIWmjfz2Er+K7hHZ6k027io
lL/SFpMWIJt8uJPwEoD2FlUO5ibjuvcufH7rueOORNKrGcu3MvWd50mkvpye1dvG
IL5uEkyZib13OD7grN6udbBO2O2Tba4MK0unr+r+IyOmMQJqjiPVlx5wVIBUFijt
z7wJ4hhYaDnAsBvELmHYVBM5E1l81qW90xzm7QDZv8NGT+kqHJqPp3j9FfbOLi3c
W1SKYuOJ4Y0VYPN7+g+I
=1tgw
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--

--===============2642265712976455817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2642265712976455817==--
