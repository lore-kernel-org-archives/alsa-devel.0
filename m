From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: davinci-mcasp: Assign the
 dma_data earlier in dai_probe callback
Date: Wed, 19 Mar 2014 13:19:06 +0000
Message-ID: <20140319131906.GM11706@sirena.org.uk>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7928819173497717262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5A2265087
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 14:19:14 +0100 (CET)
In-Reply-To: <1395148837-20850-3-git-send-email-peter.ujfalusi@ti.com>
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


--===============7928819173497717262==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xy34oCnk+Kho6V6v"
Content-Disposition: inline


--xy34oCnk+Kho6V6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 03:20:36PM +0200, Peter Ujfalusi wrote:
> Set up the playback_dma_data/capture_dma_data for the dai at probe
> time since the generic dmaengine PCM stack needs to have access to
> this information early.

This looks good but seems to depend on the first patch so I'll skip it
for now.

--xy34oCnk+Kho6V6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZlGAAoJELSic+t+oim960sP/RYdIYepmZ/lQl6fyFgs6rlW
rioiMnNYxEviDgZ/aJo2IYH3oQLplpMZb4HR6Ft5qGY2/z47lXjij+LHO+mXaM3b
qYV229G3w86vjA/5o52rXw0JBZCN0s6paUZoRFOBaxUoenqwQesBRTGx+vXHlZNu
IrqOX3xXlqklECFcLUBidb56jSvtctIsrzYTpug3PaKBz3gJQWqM35YNR4M/K/oC
dZZI1CnQ1UgBc0R58L5pStp0MzGty2QL7tj0yVHJGkblfNxCnuZtAyIiTVJvy9WC
4TY+aH+cs2sMvuT1Huw3J/iqB6l0SCiyeCRTu4schiyBsFH9eInYP3eeVrCvfd5W
rk4eIoxtTFZdQJTFB/aQIAipqCNsQYsL7I55Y7debo/YBTJwy3CNSljRsnnv9SQW
dP/5LwHcRaFioFzqKu3M+JX4fpCVL546VvmAYkG80qDc2cD7Vd5Z1rI1/ujjIQXC
Bf6y0w9gE5MyQR/T/8akPe/hZvTXF0HmRiqOa7eTD0NeqrtdCdDYa5BMyXS2n4Wv
/rNdLxJ9jvDZG/wn4/57Yhf7Bvfqm4NMf0fo/KB9/DenExPrYIT7SfZW57Cpuw6n
Jv77ZR0p6Gs4o4b1bZFSka1d971jwJ1dmd97m6KEN0h8izq3I/UhuSIMomGCdxL0
yu0J5Mgl2foZTiigIU1s
=eCYi
-----END PGP SIGNATURE-----

--xy34oCnk+Kho6V6v--

--===============7928819173497717262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7928819173497717262==--
