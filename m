From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound/sgtl5000: fix codec clock source
 transition to avoid clockless moment
Date: Mon, 5 Aug 2013 17:07:43 +0100
Message-ID: <20130805160743.GN9858@sirena.org.uk>
References: <1375688163-1935-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5771322581078747086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 603C1265020
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 18:07:48 +0200 (CEST)
In-Reply-To: <1375688163-1935-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5771322581078747086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pg9nAr2jDD6ER3CP"
Content-Disposition: inline


--pg9nAr2jDD6ER3CP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 07:36:02AM +0000, Oskar Schirmer wrote:
> Powering down PLL before switching to a mode that does not use it
> is a bad idea. It would cause the SGTL5000 be without internal
> clock supply, especially on the I2C interface, which would make
> subsequent access to it fail.

Applied, thanks.  Please do use subject lines corresponding to the
subsystem.

--pg9nAr2jDD6ER3CP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/83MAAoJELSic+t+oim90gwP/05OSKqmA64Edt7u1o+G5SPN
VnxcvE1cjDGatdqc/dcAZXiG3IXDAxgpaItnZ2ZkgRlXCL1TktBIOf6bwnLjC1Po
unSasjx8IIYVXKb86w+39BRx5MbWYP3+nWsbv2WY0u7C25iLwElWpOASrJvTfnUk
K9kcRmO2aGu5kSz07a2+WXiviWu524gcyIs+3Zt8Z8i6T30E5rx3nc+vWGajAWaM
486eS2Y+s+ArroHNm1NG8PwND3oOg0EYx3FQ23/IE0aTsYt1YYyFhEQjddgtx0ZP
8vpZxAFO3FDuDZr40xj+mhdqfFeqk3GJJKAJWX0x0arTLkLS8ulHNXW8wW2sYFrt
Crrm37MCuNG0FeFlGaMZZx02QuHCbYiruAGu4FGI7Iv8gpQISdUkNBUiv7fUbaSC
Z5/oNq2crdG5GiOu8VtrTytd8fic7g3Ks6KLEUngSbyepvfgDUi9q5b401d98DmY
b6aOrYB0vc1X8bZicafqaV+ZEzFo14g3MG+J2KRH0/4mNJrpPrNE/nGOToOrtH4n
YLU0j16xkVd+07i4xRB5b4T0z1/7xN9hUWMVmn+7nXNpulfpOUelgmuUWfo3dJK9
ntASXl/S6DzIrD62YdYzQIqMykd9HJaEupuwiedKIWNDWvw33qLiRWJwwbagifmg
CAcO0VuIJubPA2Y6+i5I
=vjiF
-----END PGP SIGNATURE-----

--pg9nAr2jDD6ER3CP--

--===============5771322581078747086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5771322581078747086==--
