From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: change the compatible
 string of the kirkwood-i2s driver
Date: Fri, 6 Sep 2013 10:31:11 +0100
Message-ID: <20130906093111.GA18774@sirena.org.uk>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6009518017546012564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ED9A6260850
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 11:31:22 +0200 (CEST)
In-Reply-To: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6009518017546012564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2013 at 02:56:31PM +0200, Thomas Petazzoni wrote:
> The compatible string of the kirkwood-i2s driver was chosen as
> "marvell,mvebu-audio". Using such a compatible string is not a good
> idea, since "mvebu" is the name of a large family of SOCs, in which
> new, unknown SOCs will be coming in the future. It is therefore

Applied, thanks.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSKaDcAAoJELSic+t+oim9d7EP/R+fU4/kO3iGSA1dXN55L70P
kk9P9RHkGI9Id2K/UmkKvEAZ1gxD2bEEPNeO5LbJ4Ewex4t4Bch2ruMI+uQ+XzUW
PJDej+fOjNcqvqDuWShWzv9eqN7clMmW848RWFRyo8STNIhTw5QXqJWb1Dse5Jzc
saPAOOKoRWJBtCHBzbOgZubGv1MKulWW9yvifSenlZEjTUe9leztYOHVh2Pr3/mf
GsGOKRIogRNiA3TkX+f/dNX+RhLfCHC6z+NQDqpz4/PVO2jFwsTTK4QMUXrBoWjj
ofcAXHy1BmOlQhcvA6GsRzbSqTeZX5NTARsse5mzgX4AHCOC4iBcpVrT7pjqrZ2R
JwK+ZcaLhxU/9CemEzVN/qLI6qnDMVkPLmjZUrQo0YCI1dJiHsULZuPhnWsgrb8w
jQZcipM4cgVtOMCx4rEhyxv6L2bLGgjJFHn40OeNbagh9jmvWT9ywDGEO39TgCvY
KruWOBY7bMpKTlhm2TMd8AQ1LiltXQoBUh0uZ3RTYN2lz9a8Or0pOrIMPySxVitq
XcyuW8t3Mkj/2RaImEJ5qClh389Gne8LN2u1xzZ4mLs3+n+xlNHE1XAUk5rSf57M
gV3CfuomG281S1g+J9MHoIc0IYZ2a+VoEwGriEsDBpOMoY/GsvR9+Hi79btwea6T
X4vDhNnp//5HNEL05WB3
=g+Y4
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============6009518017546012564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6009518017546012564==--
