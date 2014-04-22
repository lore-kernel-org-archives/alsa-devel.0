From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: davinci-mcasp: Convert to use
 devm_snd_soc_register_component()
Date: Tue, 22 Apr 2014 12:51:50 +0100
Message-ID: <20140422115150.GQ12304@sirena.org.uk>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
 <1398164594-29169-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8445539682389982347=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66048261ABB
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:51:57 +0200 (CEST)
In-Reply-To: <1398164594-29169-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8445539682389982347==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NUsTMsuqYZgNcP2k"
Content-Disposition: inline


--NUsTMsuqYZgNcP2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 02:03:13PM +0300, Peter Ujfalusi wrote:
> It allows to remove code from the cleanup paths.

Applied, thanks.

--NUsTMsuqYZgNcP2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVlfTAAoJELSic+t+oim9djsQAIOzZ+uv9wYk1e4CFJryU8WC
XoG6PkvyIIXCFker8E7aRNEJM0N0T0VxZ5FwzULknFLfDSOl8WvVIT+ySmguB8qB
hKVnR0O6Pd199R86ngR72Vij6PfYtEzDXpESn+TzvEH1dCnZQ7auXg4WfBDHR9oe
Y98gfa3xaR9oknn+6qwz3cjcHI6JM1cXDYYIisWMsVgxRq4PY1gUNZ/MVqsvHlq9
vPIUVdBA49Qplcp9pLwS0Mj6VnjKrGgcHmJ2LB6IMYa23dd8RnWSxuCAxyImwonZ
UqAY3NblvBmGgs/vmOJyY7qdX/JM5BOfLe3O08Yx8vkpbTSf9Ku2LjTAb+Mzg+RY
02ku2swuoBYCgRuMSJ/zYLkhVykwS6vsZdtqkqPah4JPpNh0DvRINkBEiwT2/SWu
QvR3Mz9nrjJMK0F4s2lhUACQSrlmvTP0MEoUTSJbcttPgNKI84OG7MyofHzeBMPd
6FFcxI2JB9ZC4Jfi0SEjnFmEb6sFDgcXMsauwaoxtDOi8AiDDzuEhuv7aXgMrtMn
Ma/l99ZshGli2bDikzS7hPg9PjnfJ2sXISnYHLz6MRtbr1BIEOo+nub811qJCwY5
WyamBaCNwipY/XtJsp010BX6f8nnFtGL+uMxZlJ9qr9aGmO4UJxf87sYZpH+x/zC
Y9BbUAmjZZ25FviAmBv6
=wJeN
-----END PGP SIGNATURE-----

--NUsTMsuqYZgNcP2k--

--===============8445539682389982347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8445539682389982347==--
