From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: wm8580: Remove #if
	IS_ENABLED(CONFIG_I2C)
Date: Tue, 22 Nov 2016 16:35:54 +0000
Message-ID: <20161122163554.74wrtmpxajl7rrpm@sirena.org.uk>
References: <87d1hu7vz4.wl%kuninori.morimoto.gx@renesas.com>
 <878tsi7vv1.wl%kuninori.morimoto.gx@renesas.com>
 <20161121192608.tzgj77gf7xigk2ms@sirena.org.uk>
 <87shqkl1as.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0896456669248389240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB5672665B0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 17:36:04 +0100 (CET)
In-Reply-To: <87shqkl1as.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============0896456669248389240==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oto37vbuzv3hubyg"
Content-Disposition: inline


--oto37vbuzv3hubyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2016 at 02:03:25AM +0000, Kuninori Morimoto wrote:
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> > > wm8580 driver doesn't work without CONFIG_I2C anyway.
> > > Let's remove #if IS_ENABLED(CONFIG_I2C), and use module_i2c_driver().

> > This doesn't apply against current code, please check and resend.

> How about -C1 option ? it works for me.
> If not, I can send v3 patch, please let me know

> 	git am -C1 0003-ASoC-wm8580-Remove-if-IS_ENABLED-CONFIG_I2C.patch

So, I happened to still have the patch sitting there in my apply folder
and that worked but in future please do resend things as I've usually
deleted the mail from my inbox when I say that.

--oto37vbuzv3hubyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNHPpAAoJECTWi3JdVIfQEiMH/iHcNsktik7GLK0AHTIflsd9
i6R3V/x4Uu1f3N9ybZc+L8+bkBolBDEYxSq2z8Xklt96CX1pELbmO/vifgJGEPRi
bwayw+p+YfJmE/JKdrPXump8lue4xb95GqCda5y/pDcc31el8DlybL5zTaF5ke7k
uiDibfkUZ4uyAl8Fe+qFeChvZCkGYPPBUiFQN8QJUo65bnrvPQAHl/1K094d+Lxs
JzIr1CfTXVEXT3q4dStPKkqPGG+ilaIFKQa93WfptDE4B6GRt0baCH1vWPuPrn4p
3UMgYDRRhuN4jFzC3X1kLgh2nXzY0tI+2lpXS6eSRgB1OW0dh69DKUM6p+kyBXU=
=/Cvb
-----END PGP SIGNATURE-----

--oto37vbuzv3hubyg--

--===============0896456669248389240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0896456669248389240==--
