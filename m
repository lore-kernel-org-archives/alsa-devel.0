From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Thu, 20 Feb 2014 01:22:58 +0900
Message-ID: <20140219162258.GN2669@sirena.org.uk>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140219150040.GD2669@sirena.org.uk>
 <s5h1tyzw2la.wl%tiwai@suse.de>
 <20140219155758.GK2669@sirena.org.uk>
 <s5hy517ulhr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1887341598183818385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 89646265A72
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:23:13 +0100 (CET)
In-Reply-To: <s5hy517ulhr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1887341598183818385==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lJhfsPy4o8B7pjPr"
Content-Disposition: inline


--lJhfsPy4o8B7pjPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 05:15:44PM +0100, Takashi Iwai wrote:

> memcpy_toio() is supposed to be defined in all architecture.  If the
> arch doesn't support it properly, it still should take from
> asm-generic/io.h.  So, it's a good test coverage for such archs ;)

Ah, so it is - in that case it's just the include that needs to be added
(and ideally the depends X86 || COMPILE_TEST).

--lJhfsPy4o8B7pjPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBNpfAAoJELSic+t+oim93RUP/ibWzU2jtoMZ1oEqaq7OV9q6
2mGugqbB9mVt7L2jVkG1xNMlvZlJmwWYhBviG80LEpj8ZPbPRZXpKNXKHEA2woxi
xMvLquIteLhurJvDWxYeHGt9JLA7dTaGTuwpnkF11NQnQSn40PCqUC9S8QY3g/Pg
ZmwISYBYy/Qv2FjDOwI/h6KGmwItoBbNNI89Rcxa7AGnJFuA2WN5eI6L1sHbOqID
sAbG4EQFY3Kbs8ccfPze9LDMfpZpIWb3L0I71G0gYb+WLg+ieuv8I++kOodc+1Tr
DVxxfImijTSSh/R5hEeOqUMd39+eaHFLVoMYp8EwSXtUAY7hqbXZyIWYpHycR1Cv
9CtWN7IPTA5jtT6Zi3tk9IScqj4Uc0irMwva89+U224Q+LUVCnxmiKuAwPOYiuOz
nVaFNKAoz2pLEj4WCikf95PZv90IQPaCYbDmIf80pTxvSFWe+g3CidbnQbA4VA3L
a+Ww7bB2dBDRmcNJqUoWXGYNp3DPn7NHp3EJ+XNeo8BTeIVEKryFJTckUTMyTyz5
GBK67fqZVr2Bhp/cl9W7M/7Vhtu5EHK0p74YPLt0tVA7vNwdLFFGOSnjGEz59Kqi
AdbHGOaWHN6JRF1RkhKKbGrYMEzvneOzN1WmilAwsHLe3c7bzi+M56Rv1xl3zoxU
nEUpJ09+eCPMOoa/9Tqs
=u8NM
-----END PGP SIGNATURE-----

--lJhfsPy4o8B7pjPr--

--===============1887341598183818385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1887341598183818385==--
