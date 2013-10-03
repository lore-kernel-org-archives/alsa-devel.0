From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tas5086: move two variables into
	private struct
Date: Thu, 3 Oct 2013 14:14:54 +0100
Message-ID: <20131003131454.GP27287@sirena.org.uk>
References: <1380631706-19365-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216664217997893309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C64F2608D4
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 15:14:58 +0200 (CEST)
In-Reply-To: <1380631706-19365-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, s.neumann@raumfeld.com
List-Id: alsa-devel@alsa-project.org


--===============1216664217997893309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Content-Disposition: inline


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2013 at 02:48:24PM +0200, Daniel Mack wrote:
> We need to access the charge_period and start_mid_z values from other
> places later, so move them to the private struct.

Applied all, thanks.

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTW3LAAoJELSic+t+oim9ao0P/1pzuQTMOIzTQotjv2mOcodo
E37hB2D6hwvezpoXl9CWjdi0EoVy5qnzjQUp/xhVjF258kq7jRwr3WAt1+so8FOH
/cU4T6cAK02luJc2fv/SCsm/9PKg/Yo1347I4W9tJ2Trzwa8OtOjncnjGFBieLQw
nhvSgirRo5x1qjM9HUUtnKr6zakKWgyeW6SBcCQNe0WjtIUi2RQIBlBr986hQ5CT
/pyAyLUOV5ggbtb6yDCOcuFIkCLfNI7YAqz+xP1I1zBjO/PJ1ibg0Zssvq//uIHQ
k5H8alwswViI8avDM1IoWS6df1vllbCeU2SY3osCtRz8M+CHps3CVDS653hQC36Y
rae5oRWFpTu8UzUeWZjPLMQZ6juisS/PlxLJD5fnr9UJ3ZF/BOBpwENaRav8ukkS
KXH9CPNCH5grO98TN0vDGs4CPwrruZ3mrE1FKaYb/kSNguxYLx95KKnJ7w0ZR/9A
XzRbwv5flNuu/wbwjT2VXNzD0mYLFCCaQKLO9dtJkYcWoQsWzmcbLGkQLkCjdeEK
HvBRM+nUzZs5zjOdOVUundFO4WG5FclE0h8qh/BykOIjylFpPc350EjJzXda+oif
hi8elpcivM6EIR2FyLdcpl5gHdR+D+NZYgNdM+CnGV91tZg8T2hDmV/01nt/Q05l
v/xup47VdX2Kk6iyTR5U
=dJtJ
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--

--===============1216664217997893309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1216664217997893309==--
