From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs42l73: If Internal MCLK is >=
 6.4MHz, then set SCLK to 64*Fs.
Date: Wed, 6 Mar 2013 12:51:47 +0800
Message-ID: <20130306045144.GD4896@opensource.wolfsonmicro.com>
References: <1362510776-14408-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1794345986092289775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9BCB8265311
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 05:52:13 +0100 (CET)
In-Reply-To: <1362510776-14408-1-git-send-email-Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, brian.austin@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============1794345986092289775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 01:12:56PM -0600, Paul Handrigan wrote:
> Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>

Applied, thanks.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNstZAAoJELSic+t+oim92RsP/ixldpT9Vzos3Zu8+W7lx2m5
XnRPRbAaugkc3RFXJbdoyvM7cxJmB/Q33qzkj8bIU+2nyI/MPPHwEOaU56VdkXkD
Pf3mCykOk8+zuLe7yQagxR6kAWoE3bIbZ2lvd2UjJ3NY4YHalYFmxPYEikFZ+B7/
s30vmWtydAht2Ibvka4Z4h8WRwXUqg966dz+OHoOcvf+T8mCQB9z/7ubtsKEzw+W
wQHfJqLdew1plNWUKIOn/IKSbh5AGHBvSMLZwL9xA7H6KuaRmGTi6CuViki/Amhy
kj1YtxWVhVBnH5mYKyJ8f9y5k40KQIGLj4lvUFS2S0KFxr3IvFHq+Glr5iXoEDKR
ibJyUFT9Us6i8ML/D7r3v7P9UW0RahnThVkwylnGW8pkFLkXN69CS6T28libiWsv
VeSGkmyn2IjVJqiftmJYZ4USn2uoQ5MK5cviCbiAjA/WwCjDEnyzeW+QYPX9wJbN
3bmsE9+fO60U9935JFKjq6+CQglLgSHOadNQcdQqPuApESZr8Z6taz2dbUALidPX
EE4tBLGMo5WG7nF3lhNuXJLtR1nlzZBwSkyQKGlHKC+i6rAEgsKC7TgjnxNQsCVZ
9cgZMmVd/pwzvYRgFjNvnc2hTJRHHxbl504aFnoOxwLDrcVEYw0r3W5jKnpEZbJA
HhxMeOyY/yTMyTgH4dtR
=s5FB
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--

--===============1794345986092289775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1794345986092289775==--
