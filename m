From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: codecs: mt6358: change return type of
 mt6358_codec_init_reg
Date: Fri, 12 Jul 2019 11:56:19 +0100
Message-ID: <20190712105619.GL14859@sirena.co.uk>
References: <20190709182543.GA6611@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8401874863308806493=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190709182543.GA6611@hari-Inspiron-1545>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Tzung-Bi Shih <tzungbi@google.com>, linux-mediatek@lists.infradead.org, Shunli Wang <shunli.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8401874863308806493==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2019 at 11:55:43PM +0530, Hariprasad Kelam wrote:
> As mt6358_codec_init_reg function always returns 0 , change return type
> from int to void.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0oZ1IACgkQJNaLcl1U
h9DBvQf/bEOPmabOAkiJN59jKdo0Gi0w05y+5JDO15GfjfCufMDcc4Ul9bl0aH0X
sBwwlklO0yJM4Szsx4dy8rVPtdU6GldTUUIprkzTyzb+e2jO63BxyTzR85GKXwkt
0UFKK8ZOp74xrpxkc3ViFRwnfKNQ8qm2eqcoszNwUH8xrqPOFYhrmIjBrmlikuEB
+ojxODhzc18uqCo8YUHrqFHW85L/bxomSFWVP5Uyv+R1STDaZHJC/8uXlBdNu8C/
B+DDhV8hBV8YLAS8fYeNTARUhBf/IX9Yukc4h6hECKdK80l4mhqK/mOVeMXvtSUW
E+3CB4XK/4FDzc1nlg01L9omlgrGAw==
=pELE
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--


--===============8401874863308806493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8401874863308806493==--
