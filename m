From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8958-dsp: Fix firmware block
	loading
Date: Tue, 25 Feb 2014 13:37:58 +0900
Message-ID: <20140225043758.GV25940@sirena.org.uk>
References: <1393090213-10532-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738144687206536668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE7F265551
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:38:02 +0100 (CET)
In-Reply-To: <1393090213-10532-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0738144687206536668==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ac54cjuyezeSqVQ7"
Content-Disposition: inline


--ac54cjuyezeSqVQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:30:13PM +0100, Lars-Peter Clausen wrote:
> The codec->control_data contains a pointer to the device's regmap struct. But
> wm8994_bulk_write() expects a pointer to the parent wm8998 device.

Applied, thanks.

--ac54cjuyezeSqVQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB4jAAoJELSic+t+oim9IFcP/iw+B6A88kW8quubOTKN1REr
/7PBIrDNnUWepNbTJUx8DJLdukTUt7+NVVNRVdC0dRLU4OGDXvrND70DudCKbVnE
401e69ukHfN6nfEfLLRBCSzCDRp/5DDbOxKcujeYl145olHreJcIdpnyUZs4yPgq
ZoLGhtspVWaAIFDQzWyFWEh3CEIS9BQLdhU4JKIPO99A3zn7cuNKUNc8j5tQMFpW
E5thPT0NKcQnV38nUPnzhM7wuCPQs6+CVFoibbK0Kk/H853d4gwwmugG7kVsW/3c
Bhmfm7igfxmU18Gnoyx78UlcWy6Hukgo6PJQ7db/YKn2469oVMIsGbl8fVUQov8s
uYOhGJAS3EEwR/BB9RN94IpSDwzCKF4F9W0cF2VdE/ToG55SzbcR1LcySbqOf80J
fL90f1O/yTjWLGRv+iPBfh56ye/XXswYaEkXTHmKP1VRrRkFUuAiWfkA0ReN2O93
cKn/+2PCn97KRI1MYhm0Cc1E7unC+Qyx3SRbU7MyEeRy2BuKU7fuCT5EbVybSl3X
FxIaMHvt5wq/zcuiN2AYd9FhH5P99qpolGzCSQuOQdrV02WRonBPu4rzUi+D0Nk1
bY5zJ9vYiBB3CzcsbR5ZcicSWMhtjZmc8Wsg7dGnssKF9xXUAC6cE8ACY4IPSNW7
qPW13Wz/FY9k+BJBxWQE
=Xxn2
-----END PGP SIGNATURE-----

--ac54cjuyezeSqVQ7--

--===============0738144687206536668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0738144687206536668==--
