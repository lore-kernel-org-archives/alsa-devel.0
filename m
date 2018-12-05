From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on
 reg read and write
Date: Wed, 5 Dec 2018 11:28:32 +0000
Message-ID: <20181205112832.GA6205@sirena.org.uk>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
 <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com>
 <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8891999526694040869=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 890D526789B
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 12:28:35 +0100 (CET)
In-Reply-To: <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============8891999526694040869==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 05, 2018 at 10:21:04AM +0000, Adam Thomson wrote:

> If the previous I2C access failed, how can we be sure that the write back to HW
> of 0xFF even succeeds? More importantly these error returns won't necessarily
> stop subsequent calls to controls within the Codec I believe, so you could still
> see unwanted writes to HW via I2C, if I2C is sporadically operational. Again I
> don't see this update resolving that. The key thing is to resolve why even just
> one I2C transaction fails.

Right, it's just not clear what we can constructively do if the I2C bus
falls to bits other than log things and the I2C controllers will
generally do that themselves.  There's no guarantee what made it
through to the device or what will in future make it through to the
device.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwHtl8ACgkQJNaLcl1U
h9DiPgf/dRdws2pJQNwVjMZCeXaIWamfcvHKqKCY0obEy89cZkRWM/SWVu/M1bj3
5pzLBIjk5b/tJh4/yFcK1ioJjiEpCk76HGlFnUp9+wDFeO8TOJVNppe72gmN9QrA
fq2PjmoDPV3STxHwDzy0/5Q4pCiS3K1qFLTfY/pK8PFowuk+y/SLVNnsb34HlH7c
6OOIGiUJNn3a6cKBTeyN2VH9tasRbsBeap4q8DZJRt2Q6+6Jp3/cLtSO7HKqLghK
hDkNILIx9pymLYIn9zGntO46IyP+R28+TP6lGafnFvfj/eoz+BJTYsxg26qdRP+0
WIuaOyr/YmzRZ3yjFs8Pn7SdVXj1Kw==
=0djV
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============8891999526694040869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8891999526694040869==--
