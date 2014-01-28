From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas Gen2
 DMAEngine support
Date: Tue, 28 Jan 2014 11:34:29 +0000
Message-ID: <20140128113429.GK11841@sirena.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194902.GU11841@sirena.org.uk>
 <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com>
 <52E75DD5.6040605@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8498972431641266646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A0D265185
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 12:34:40 +0100 (CET)
In-Reply-To: <52E75DD5.6040605@metafoo.de>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8498972431641266646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zAsEw5WKmA08pk2W"
Content-Disposition: inline


--zAsEw5WKmA08pk2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2014 at 08:35:49AM +0100, Lars-Peter Clausen wrote:

> I still think the emulation of the transfers is better done in the
> DMA driver rather than in the audio driver. The DMA driver has much
> more state information available than the audio driver, which should
> make the implementation on one hand simpler and on the other hand
> more reliable.

On the other hand it's a problem that several devices have so we should
be able to factor out the interface matching so it should have at least
some of the code in one of the frameworks, dmaengine would seem natural
too me too but apparently audio is about the only user of cyclic DMA so
IIRC the DMA guys were pushing back on doing it there.

--zAsEw5WKmA08pk2W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS55XCAAoJELSic+t+oim935sP/1suo9jiI4pvb1x+I6nfllOZ
t+yHwVukVcIuMKmrz5w043GJ/KjSfZ1jbOEdEIhnsrKFABV0krSmt9oSNSMbxcdm
RBXlJs5HYyL4KJcWsUr2JJfpk8jkRfvT2SvjQfH6wxqNt0GlzN+jAyq6+RWtIAUp
vhUSRrBy6poCkeexvSe0x5krmA+LowMRpRTRXcN3DHHy+No2jk3TOt4326VxdPpf
K3Y1nOxLpJTZa31yJ5XrJ6Ek/N4aEit+d5SfnwOg8diWxXdhNuZGyt09WCvv8p4d
tD/ir+mEMZjifNnATCsRDd653VYZp8FIacbh+bS0+tnVENqLdwGoPmJQo3v9Vj82
C/rUy7liMgBiOjS94Gp0hsa/F5gD6XEgu9oCJ7vCmeDLfU7wtD1wJW+BUBhWZckg
xECQK63kkk78njagpxhnxudN8V3+xxi5tmI6rKNT7ltyZL+S7PtOyY7uSMnzregW
9/uqQn+Xftz+xnZ/8rHLe2pRI/VTLwInrXTnrE+tPOTn37oWbFHxis4+CF3Y3up0
V02usVgihHwDUL97oqEWMkbpQN0EtAfdrkmxkVaX/Xx2ywXgke2+l0JAFXvrhf+J
rCCsmWYAC9omEJ3nU2yAZTBSvWgb9xXR/mpJj8ETflnPWH+NCcaPCNZPFwcZZP27
Ebfyk+bbPeUUjrf2ymwy
=5YBm
-----END PGP SIGNATURE-----

--zAsEw5WKmA08pk2W--

--===============8498972431641266646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8498972431641266646==--
