From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm0010: Split out the firmware
 file parsing from the boot.
Date: Fri, 9 Nov 2012 11:43:28 +0000
Message-ID: <20121109114328.GC23807@opensource.wolfsonmicro.com>
References: <1352307198-6699-1-git-send-email-sl@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7338986476406173389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B3E0261689
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 12:52:16 +0100 (CET)
In-Reply-To: <1352307198-6699-1-git-send-email-sl@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Ling <sl@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7338986476406173389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 04:53:17PM +0000, Scott Ling wrote:
> Move the firmware load and record parsing functionality out into
> a separate function from the boot function.

Applied both, thanks.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnOw0AAoJELSic+t+oim9IiUP/iavokLuZBpAzZ1bvyRHEhbU
LqIgojU82kuE7XUgeXmUeGGw8QV/tv1wrN1SLDCFH/HsI02eQbJ0VYORmalgvdl3
rSAsf+Dqd6YEFWDYi9Ic5Hez29tk1xmVgAtIzyOIafdVI3/fZUSn/r8wFIj5cVxv
Jttr2lnrG+1TZNnslLkTLoRo00JohZss2ku1asN68GKYts0TNe7vWiaG/oo/y/GX
Zu9vMdOlHiyuHeZ6jowXkloDxPEnKxGA22JFfunwqExP7xfIC3CvXonsDr4bB418
pSTaSpUBxF6bxniyPG3nS8u0bq2KpcpFxsz8BpMt5VQlIJNZqBOZ7nGAoDQZhSh8
MuMeLWmwRrlpDTmx5NYPIFqL5FymXBij6X8MZpM02LumnzLnfm8WRSk0U+bjfo6T
YMRlL7n7Tbk0iGotXGCPPS35C95yO3PdXH00WH41iPuQyxdjXDJhU+/UAPPNIREl
52zuXyB2USTPvjjSYoV5XOOyNxiogVHMEK3m4dmWkg7cNmGpP+0Vc66xYDrf8pbh
oHlPkV+AhhaeWS/kJg+xDBH5L9OOWQa8poAzu5iwXRpcw0elZHTIm0/hEPe57fuZ
tBH/4fEyjQlY3QprEz5HGwp+3NjHVyUHRazf09UGHNn06C+UwDr+pAbzCE34cLHx
G0R3tvsPLLMFAWuzsTZc
=zKMD
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============7338986476406173389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7338986476406173389==--
