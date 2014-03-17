From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: davinci: Add edma dmaengine
	platform driver
Date: Mon, 17 Mar 2014 16:20:56 +0000
Message-ID: <20140317162056.GM11706@sirena.org.uk>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
 <1394808168-32608-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6176186618652764248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5B92617A4
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 17:21:07 +0100 (CET)
In-Reply-To: <1394808168-32608-2-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6176186618652764248==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Content-Disposition: inline


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 14, 2014 at 04:42:45PM +0200, Peter Ujfalusi wrote:
> Platform driver glue for SoC using eDMA3 to use dmaengine PCM.
> The maximum number of periods need to be limited to 19 since the
> edma dmaengine driver limits the paRAM slot use for audio at
> in cyclic mode.

Applied, thanks.

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJyDkAAoJELSic+t+oim9fj0P/AwsE3ufxg2Mbtpssif6elB6
ZlglWQ+KjQOsQPPJAF6i0D4EChKv1EEh0glAv1VoxMAMrxWTk7j3qVPYx7G/MPh9
+cNCwdTaHR6qI4QDSMdxkr2ebJ2FB4RWZkc83k/4Ag7vjBGP1AHQtiUb21VEke4f
dwdSICJ8E5YUYfdjgSEdyd9CbPx/ECJ52dtX7I6tS2nnYD/1MdLK3D1oKDn1S1f6
q0tW8lU6QZjXrgkeNK8aKvRS/HztBDHXSsITDLhagD95v2BJ96VjOvghATKS2IKE
+EoIDRSD4zLTqJBzGtu0SZwvmk+togSSEqGradQInnekTdwnOcDNJ9vRKV5+72Tx
jRxZXNT0lhw5bCkCH5xfd/psqfcFfOq+kT1Qgn1yrDf1Mr9HX1s8D6sDI3VPazR4
OWwH1tW5qW1bifysEJ9465yee6JiYMTBUObYRTcHEtzW2PCuyIg0inplU7h3EFcB
f4KiKi2UCBC5MUn1WV2zo/JJo8TMlAAYtoc8TTGkvztCOm3wVl42htw9CA7EkcwB
L/E1/Zjtz9sWfDu8iQ3fC2g4Anocrh4nA7nF2Rby/uPR7ui32y6s2mQv0FJqYYmM
yowZjWapVx6q4hCzxHdgK1yHL0Q10T9kEzoUnzEr/jwp8rwSgjWJYGhdpf1vOku9
3aUrQhC7AJRIQl7prwEA
=SXv3
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--

--===============6176186618652764248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6176186618652764248==--
