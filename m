From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct rx format
	unit configuration
Date: Thu, 4 Sep 2014 12:45:16 +0100
Message-ID: <20140904114516.GK29327@sirena.org.uk>
References: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683389031742227294=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74BEB2657D4
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 13:45:25 +0200 (CEST)
In-Reply-To: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0683389031742227294==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJQbLzJV/QPBkXzU"
Content-Disposition: inline


--kJQbLzJV/QPBkXzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2014 at 10:52:53AM +0300, Peter Ujfalusi wrote:
> In case of capture we should not use rotation. The reverse and mask is
> enough to get the data align correctly from the bus to MCU:

Applied, thanks.

--kJQbLzJV/QPBkXzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCFDIAAoJELSic+t+oim9qOgQAIdIetEiRUYele9RYUCXwRHc
/BORMpTRel/EP7j55aZ6aHwMlVlfwQnXS1UtWdfl2T8w66TZB9zTc7HeJjfDWylD
DbM1ppxCMkrsY31HR+2JX4SWFE6Hz80xNuHupPdpOY7AYgfxe7/dZpTObihG/5b4
pEE9GI7NfoRpah0+1GGbM63z9Sb4vycvnGtD+zKlFHOWm22cswYtBNuuzPcuGmy7
QJYMYN7AExed8BIIyA10DkbjEjWV/ofseuA4lE1peMcaJw1SyfeWMFON7JYia2Wg
ASePJ/micF1Gghc6O57nvZne183aDK5wbv0khT7EO2LSdA8sjPNLYUZVUOZsOzKl
nwiHhFNHPNtvVqdiyvjUJ6RtyBCDaA1uRACMvLTMCQQG2+TJjM+s/xG//ZNum6I7
uG3T7TCY7b2n35twUBqYEnoby5u6uPTmLx1Tgp+dgbVqTYIopvjo1NTxQ6o8xQYx
Jx62u67IqYB5p9BtTHqaUV8Mw5Y3+s5WSvTOwp6ePWJjlnx2hjruazsif57PNhgC
TuSGlyUkJ8FgXllhkGoKvVmJ3Y/OWvpeYH/dYlqrERj/C7qY72nLz6MJCJqhb6/W
ME0Fj37c2yZIMk2hQwHJAat80OEvGK75RcdE43+z/++pZ5x8NCKnbmRB0Si2TkHU
2HCEJMSOVU8mODYGPSyU
=zd90
-----END PGP SIGNATURE-----

--kJQbLzJV/QPBkXzU--

--===============0683389031742227294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0683389031742227294==--
