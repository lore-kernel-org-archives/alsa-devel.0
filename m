From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] ASoC: Move IO abstraction to the
	component level
Date: Tue, 22 Apr 2014 13:24:08 +0100
Message-ID: <20140422122408.GV12304@sirena.org.uk>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0273857815190388281=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3446E2625C4
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:24:24 +0200 (CEST)
In-Reply-To: <1398165797-22997-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0273857815190388281==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIr4TYI69vhiwa6U"
Content-Disposition: inline


--oIr4TYI69vhiwa6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 01:23:13PM +0200, Lars-Peter Clausen wrote:
> We currently have two very similar IO abstractions in ASoC, one for CODECs, the
> other for platforms. Moving this to the component level will allow us to unify
> those two. It will also enable us to move the standard kcontrol helpers as well
> as DAPM support to the component level.

Applied, thanks.

--oIr4TYI69vhiwa6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVl9kAAoJELSic+t+oim9Ey0P/00vtGhAydUTKcOnwdK1xF6Y
e8q7V+0aRXIcTJo8/NowIso6lHWXXHHXZEhA6+Plia4WCVCQDiSAaj5FArtG7Z3H
VPOAiSBN+74QzuD3JY5tOcRQXXfDB2nMx38fpkW24GFTQ8pUhtbJJDqKsVnVZDx+
kPn9+rIsWpYyPv7IFGCcOCVubDa4l1UB6rDmZ8eO0ePLYIyvexKdMl/nKhbEmaee
Lf6Ez+EGj9gHi2Mlv3nfLutstALNnrjjWmDHDLLY/g2NXPUqBUbcjxBuic2bkh/n
V3dFdn62WO5PIPQkN2/SPu6xuEqZ0iAgCqoEATHMw4HmxESGilswlcUmQaPxdimk
VpeleVg4YRBb/bIFZAsEFJVPF1y8/03LH2+Gz9k3MjuGtsYg4Q6hX4IXOFQS/gIC
I1QwKyGKbVWI9VWO3lF6oWF5fM28Ji/ibsfXwPkyB85Hu8z60SRdApEWsgzQ/Xuj
ohl8ipEnrFmK5zECUTx7v2PLvXQKfnjAF9gm9c4spG0APe2Hx+Sw/AyHTOIT9G23
HNiFJN2x2+sT3faYq7jdAiiSUIUQDqDdhncO+k2mmmaM8g6w38Fw+IITHU8YJkaA
CsZDJ7xlzqv4hb6m/pe6sI6d8KW7RB9lJAJaQz9YsATbrBHOUh1YPtq2CyWUbnxk
khuxzYHM+zGsa3pxop3Z
=CaRC
-----END PGP SIGNATURE-----

--oIr4TYI69vhiwa6U--

--===============0273857815190388281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0273857815190388281==--
