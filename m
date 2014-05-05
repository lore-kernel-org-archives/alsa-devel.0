From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: fsl_spdif: Use clk_set_rate()
 for spdif root clock only
Date: Mon, 5 May 2014 12:26:37 -0700
Message-ID: <20140505192637.GM22111@sirena.org.uk>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
 <05eb492d162ee6173f813dbc6cfda6551de70108.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4372289257241811378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFC0E265071
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:57:52 +0200 (CEST)
In-Reply-To: <05eb492d162ee6173f813dbc6cfda6551de70108.1398853588.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4372289257241811378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RXc6EO4W1yUvSQ0X"
Content-Disposition: inline


--RXc6EO4W1yUvSQ0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2014 at 06:54:05PM +0800, Nicolin Chen wrote:
> The clock mux for the Freescale S/PDIF controller has eight clock sources
> while most of them are from other moudles and even system clocks that do
> not allow a rate-changing operation.

Applied, thanks.

--RXc6EO4W1yUvSQ0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+XqAAoJELSic+t+oim9SyEP/irBxfFCAYoJPMRGswElajD3
dEPxqQ1XyKgBWiwoN7+p9xQGN5AVFfcjh7XE7UkUzdD0fbSxm4kGjVccx5KpxaqC
qtgPC3JCCs3yGZj2xOafeAUc5Lpq3kDG6/+TmQsuixvU0zLImyxTaPIyVrvsBSNQ
Q9PYjbC3e78hPrGvKULUsr1azxrW7M1OJuAeDofvVRrNx+kCjW1prIEjVbRx/lOY
MqAV0WO5i5cPNetYcxQYZADQ8lh0E3bNnQ9rfQX6Zbvx0KG/mSYPWW/b64wpjFnG
yp/t6mIY5boYHwnEURfM9SDzgjVn6CzITTIJIogWM5aqRYazt58HSFjmtq4gdPyq
q6MrqfzKU2R0EXSr5L/w8wi8mThEec8sZhIX6+8sKSlznMDKbnbv1cKfVBaXlddq
yzPeqzUhDLu/zFlc8p1Qa2zFzlxSuTq3pFWxfQzIkaVETLGp1iz0WSKjslq4OLkf
581ySYjtifdyJu1Umv66fngm+dpJYPW/PZ8sPKjbZCcUoVPM5r7WtYuIAcRfeCvE
FNED+TFDdzMb4+bXPt/m5f51xDu5b32kOk3+mJR9+nSjf41940xvKp/e8Jg+9nvT
UWzWkEnWQe2mSrSvanikLdWWkRzPgwaQL0jipW30YTZHnPD4NQwqsgBzu5KeYBPH
tOYPx/FuipCmajPseJ5Q
=zExO
-----END PGP SIGNATURE-----

--RXc6EO4W1yUvSQ0X--

--===============4372289257241811378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4372289257241811378==--
