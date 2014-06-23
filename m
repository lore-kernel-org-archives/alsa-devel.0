From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/19]: add mrfld DSP support
Date: Mon, 23 Jun 2014 11:09:57 +0100
Message-ID: <20140623100957.GX24291@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <53A3EB23.4050302@metafoo.de> <20140620082041.GG22053@intel.com>
 <53A3F775.80303@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6567820447229847866=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 963ED261683
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 12:10:02 +0200 (CEST)
In-Reply-To: <53A3F775.80303@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6567820447229847866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhxWStFQ84VXWhXs"
Content-Disposition: inline


--FhxWStFQ84VXWhXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 10:57:25AM +0200, Lars-Peter Clausen wrote:

> The idea is to get rid of the IO abstraction layer inside ASoC and only rely
> on regmap for this. This is a process this has been going on ever since the
> regmap framework was added to the kernel and we are almost there now. The
> best is to implement a regmap bus or a bus-less regmap instance that
> implements the IPC for the DSP. If the IPC does not map nicely onto a
> register map, we need to come up with something better. It's basically the
> same problem that that HDA CODEC by RT has.

Well, it depends.  If the device looks like it has a register map that's
sensible but if it looks nothing like that then we should be
implementing the widgets differently.  It may be that we need to be
constructing and destructing objects on the DSP for example.

--FhxWStFQ84VXWhXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTp/zxAAoJELSic+t+oim9wnoP/0bkJiMp5RAbWS44vkZDIcf0
2YCDpkm2zgT3SwyYZh6Ai6UXHADbDyrxYh5aWmZicb5McMKacLapoBmrnrKSTZ/G
tZzXqKepdbwuerc9ksgGjMlzF4MxnJjEZSiVpdI+CQcO4lfxGR0KcT1MAQxaWfZw
njSa/MvpZsSBR35fAmxMJYFgp33uKzOHj8SRgTBOG3Ght1VR4UKzZsfjJmeaLxCM
+TfYh9xyOLFtiOKtORiMLGAMgdCMYb4Qsl1PPnT+1baoOzFMOlzojn/aIdqqm+SG
N8K4MHv7oyXk23FNsDwH8lrtcY5vIWWFOXoSNNFV8VP3US+rx+azKQyO/EyHaSLn
6WPncv5SpeA5ezowDXcUZ83DI6HDvqCPSB/x0FoD5bnHqX3NbJAwPbTmBMNzvcWJ
FPGP1Diapbr5q70Yiwm3jUsMnUlJGvK+m2UYMlGIix5c7ueD9YTfTgk84QkjAdNN
WGYnotA0nf4rPB0NraTeKITPoUWYlImk5R/YA/tKaingriRhqsa8CMqgnjSpq/Vr
x2bgESBZw/aMGmsJLk4jxK3ryLcp8siq3+mygjMCz/iloGkRySD8XT5koGaEg7l4
IcjokaqmraSKGQ66AElcGmzKxdjUwIbicmkW0bgrJh5ulc5+XvNJ6inYE21udekP
lom/NFOV0r3KXDHZybZN
=gqFq
-----END PGP SIGNATURE-----

--FhxWStFQ84VXWhXs--

--===============6567820447229847866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6567820447229847866==--
