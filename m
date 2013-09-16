From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Add API for configuration of
	DAI BCLK ratio
Date: Tue, 17 Sep 2013 00:42:42 +0100
Message-ID: <20130916234242.GC21013@sirena.org.uk>
References: <1379332906-5894-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1145943662995778924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9297A26504A
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 01:42:45 +0200 (CEST)
In-Reply-To: <1379332906-5894-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1145943662995778924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2013 at 01:01:46PM +0100, Liam Girdwood wrote:
> Some codec drivers when running in slave mode require that BCLK to sample rate ratio
> is explicitly set by the machine driver as it may not be exactly rate * frame size.

Applied, thanks.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSN5dvAAoJELSic+t+oim92DQP/3t3L3EAsfRp32zG7dyWi/4s
dh0+S/RkWiK+OSixXof8MyC3H0j+qWDy42CibtjkimC8jK/BVny8xRt0ZmOB/cDP
OMIC9OdlxkN44FpK9BV1wJt4f5GBJl+7Fam+xAaIcf/f74zNU0TgE6yRHFh7u4Co
DfAo8cdNIjeey/BW8h/Sq9he1e6Aw3tsrqnYPzYWoOHZrK0YuENa2tDkcigYnH+I
4TG/DXu9LofNt7u0OoBkg/9v6AF+F5qzanzlOdsUot1ullewhWLXG8lW6/+SMt3s
LdbI3zeAS5cnnAVFEngJwAp2S6C37EcfRdA3sEXi7sowW06AuvNe3h1SS4naY3vh
SPSupz749wpdoIrh0dQHYcaJAq3OUvebPV3k6ddU1f5vuzlpZHA7/uu9Yto56ed8
U4QonS/ftFsSfmkm4pi2rWVF9iiFVHQNldXdQ540aKVTGXmOQvFXQI31xJlP3UO2
np8fnHlZPZGLYgG7LMaTftoaJUjdCiQo7+kU7Abs8Xu7UO0Gj3v4xOqUmSQCkNkw
QMYToMUAJi9ySBLNAmzqh8bkcAU1/UAGdlUElt+tAhgW5lEJ1ASCc8dakDRNQ4Dd
Uqy2ngV+uwLGchg5wntQJPEU++AupqYOo8+y6gFNpGG2AVVTNskQvQkxopNZ4A0t
zTavF9igKSbF2XhM3KhH
=CjM2
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--

--===============1145943662995778924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1145943662995778924==--
