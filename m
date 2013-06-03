From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm0010: Clear IRQ as wake source
 and include missing header
Date: Mon, 3 Jun 2013 16:38:20 +0100
Message-ID: <20130603153820.GN31367@sirena.org.uk>
References: <1370271475-24159-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8310693711492569665=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD4D261ABC
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 17:38:23 +0200 (CEST)
In-Reply-To: <1370271475-24159-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8310693711492569665==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2013 at 03:57:55PM +0100, Charles Keepax wrote:
> Both clear the IRQ as being a wake source when we are finished with it
> and include a missing header file that is required.

Applied, but patches 2-4 appear to have gone AWOL.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrLhpAAoJELSic+t+oim9N4kP/0U6Xo3rORm0Pdi/96u+auD5
sUofGtZjcUa1S/9YZ5SEC16z5XFX2zdXEcG+TPRhdE2/zbIY7NVsv9c5QjP08NCQ
nzdlQgJ7B8fJREW3G8nLAvHj7sMF4ns2yWXHUzAlZPnM4+hBdZaU0lefajKsGh2Y
jE3va++kLl+NW/38mE8JbMtn3Yled62Qa8sVPthX1Y8naNV7BA6oXWBElI+2RVT/
V10t+l5twjSlTDl3dW63VRCdzCVB/3bgeOR6KcjEiBAOsL/rid/h0ZnoEL1VOv1y
8juNDELtz8yjwFphhw6eiMKR9Gr633AYthgI5QQg5w257K550zS0l7GEHWk4WvV6
3CF9RSO/LM9PSVJsqZQ9/PlyLxcygh/X1o/6nU5v+FM8WSCAWj71JceqiUVl/sSe
TYz70OQGHNq/yow8eiy4GmVVuhS3spYLBnapmU/kzNKTrACpHze8bZ5bnARq5K3D
hiVTlZGpmsrp7cR3tm6DgK5N4ybC2pUveJ7wL54bqxSGspoxUwOflXOMniGaaago
GTpCTpkHGSPJZe+gwYv377TsIXAW3HalRTxUkReKOt/qAmv/VYzkKdmIkg9MLldu
5yQyKKMgcopS/v2xa93p/5DhS+aAGJgAShBPfK/BG5CTTFhBvECnlp+2ARsMljmH
S8AmIXCgpJnWyokglyD9
=e79l
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--

--===============8310693711492569665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8310693711492569665==--
