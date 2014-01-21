From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic32x4: Use signed int
	mixer controls
Date: Tue, 21 Jan 2014 21:14:55 +0000
Message-ID: <20140121211455.GZ17314@sirena.org.uk>
References: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
 <1390219558-25341-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7659258514390354983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA83E261A01
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 22:15:07 +0100 (CET)
In-Reply-To: <1390219558-25341-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============7659258514390354983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6mjziG+ONat+OS9O"
Content-Disposition: inline


--6mjziG+ONat+OS9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2014 at 01:05:55PM +0100, Markus Pargmann wrote:

> +	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
> +			AIC32X4_RDACVOL, 0, (s8)0x81, 0x30, 7, 0, tlv_pcm),

These casts are icky - I'd expect either signed numbers being used here
or the macros to deal with any required casting.  On the other hand
there's fun and games with the type sizes...

Also this seems to depend on the patch series adding these controls,
please note such dependencies when submitting.

--6mjziG+ONat+OS9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3uNMAAoJELSic+t+oim96OAQAIjddN+2ZlToVt2J3aWmd4Ar
099Z/5oXLZ/IY9H30N1u5HL8QuE8BwEb+6y0LAA5glrs9PBL/VUDjfp5snW1B01v
vck+IrN/8GlwYvrwLc7BDxmDKUqiN2lR1RHxMFdgbDvj1r9DglTebCgchAI36tCr
D9g2nuQ6tsT6vSzLKfzteeOMLvBa19SNJ/p5e16n0jK4Y11sOYQTxeAnYjYoxDbU
PvLT9oNFMEdF7mMsgE5HX7R2jWO0SFsLzc+kmyn8787Yq65a25d7NOQYrIDxgzDk
yJPfVDo9WrpLzj9gpY8bZYFtYmDTk22SdnnSniQ32tqkCAJbhq3986TlOBhCQ41l
HO+WhB2K0jN1EEF5/m4ADsh/EWtqAz0EjcTwJ+SbDNk8BIMZqhlbk5Nufl1QfxQL
0QEKNdMNNeEXqi9iNhdzsyZd5A1At7xFEX7B6fE5UrxUf0pM5AVYXGpTmZXucoWt
smDm4imWXNV7ndEhB19fsi6f8m2tvXkvm8alpejsKMX8dEz9Rv4XXHXG2Gsap+DE
Vt4Diz0TALCi4CK0XL1JIWw1T7BI/DSVh+wDVNMZqjQP+xMGSpXR1w+iP4h6Jex2
gWMB3sAVRnbBcUd/2kti3xFrMAnCaZOS5wyeLkUIQ1wIgRZ2lxVJLbdWdpM7zStu
JABHnj3NfTk7BxOoGojZ
=qZbU
-----END PGP SIGNATURE-----

--6mjziG+ONat+OS9O--

--===============7659258514390354983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7659258514390354983==--
