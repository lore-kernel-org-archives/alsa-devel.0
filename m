From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sam9g20ek: Let device core handle
	pinctrl
Date: Tue, 7 May 2013 10:01:16 +0100
Message-ID: <20130507090116.GO7478@sirena.org.uk>
References: <1367868508-12329-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <51886282.8060106@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918716098637782106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8523426262D
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 11:01:20 +0200 (CEST)
In-Reply-To: <51886282.8060106@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1918716098637782106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Content-Disposition: inline


--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2013 at 10:10:10AM +0800, Bo Shen wrote:
> On 5/7/2013 03:28, Mark Brown wrote:

> >Since commit ab78029 (drivers/pinctrl: grab default handles from device
> >core) we can rely on device core for handling pinctrl so remove
> >devm_pinctrl_get_select_default() from the driver.

> I have one question: with this patch, if lose default pinctrl
> configuration in dts/dtsi file, how should we know that?

I'd hope the core does something sensible with this, though I've not
checked.

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiMLZAAoJELSic+t+oim9SxUP/ipEzF12SASpwiBIOn0NkURG
qOXYp3K7oIjHY1iNY5ztMDWVAS8wN03OS3LYTjxeO+jXM6cQb0tQyx7RWLyeIBy8
jCmC6iBAcZyXPtz96HfM/O/OVr0l+xHwYDLJ6KPmKqqKAzePNzpllwLqSCdRk3r3
K8k5n9hDFe89V6nXFgBrpw0dShgizZBVCDeq37rTUZiH041UOz+3FeXodcWNo1zg
qzXk6/f1I1krrkfXN5H++pnfcjv1pq11P7MNxd5BG07UZiyVK0LABCiIJ9FX7Jmh
lVPHCdCt3GcVwRJvLhxfbdnZR0cr+vYjzI5rnr+eLPrHRddFIkEbjfWk93sXIJ5n
fZXe0rl0fMKheBvARHgwG5a2Qs0ZrRYKwnfiNdjDFLy56+KBRhoCqf+lIXcVbW8x
OP+8/0Ux0n6eTFpdngtmzFd6b9PhgphTllxyk9s8J30Zm9za3Szc0aeaGZNu1XDw
rae7mJBwKG8Gx1nDsRYd0YRqP24GhL/YKB+Lvbb862OtR50tIrwtTyOCQGFuJIWP
NCbLUp/ugevU6Nh0Sn8lgoNb3Iaa1eN7DiGPzi/V1eeEgjSoz++yNFIe0D9TFiyv
0gcaS1QhVnE/2EOFdb8Iem19PN/rnrBXCK3RA2G5L7sUkxEGK7PIUOFf8L/hTlQG
8Qft8y2xJod7CWcIOGrm
=u2M1
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--

--===============1918716098637782106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1918716098637782106==--
