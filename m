From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Update register
 CLASS_D_CONTROL_1 to be non-volatile
Date: Tue, 13 May 2014 19:02:17 +0100
Message-ID: <20140513180217.GN12304@sirena.org.uk>
References: <1399985115-29117-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6815659307127221759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C01A2650D8
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 20:02:40 +0200 (CEST)
In-Reply-To: <1399985115-29117-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lgirdwood@gmail.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6815659307127221759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwuWB/+Ski4Vd4IX"
Content-Disposition: inline


--rwuWB/+Ski4Vd4IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2014 at 01:45:15PM +0100, Charles Keepax wrote:
> The register CLASS_D_CONTROL_1 is marked as volatile because it contains
> a bit, DAC_MUTE, which is also mirrored in the ADC_DAC_CONTROL_1
> register. This causes problems for the "Speaker Switch" control, which
> will report an error if the CODEC is suspended because it relies on a
> volatile register.

Applied, thanks.  I had thought there was one of the user visible
controls affected too but I guess not.

--rwuWB/+Ski4Vd4IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcl4mAAoJELSic+t+oim9p0kQAIfbw3dawU2TMOaPSiejjC5y
QEdl4ytWfHW7NhROrNxzHR/X3XoRaOT0CK5sqgZ1Ig87SXA0ggYB0E2O+qVcgD3X
C+juEgPOvsp+T/2aVyo18jnOpuEOSJH/sP+47IEzZrqYSm1y4LTg1nqzN+IPpD6j
YGROx0Y0TikeTEaC/AW87sU0A0w/8R2tUqI+IvnwG5eu7ZXT9WRcqnD+H1nTatGd
xJrDD2uCKy8dzCV+es6lXH0I0cFEtN22wOhizntrmjJu82vtLbdLVXHnZ9XYTKha
0M/Hi2plbawkO4Vh9ao5a6am2kauaeYSaK3PRJw/CQH19Quu3Fz3G4m+QtGTFZ+c
c3PmffPUQFgs99FHY5ExPb2P9eZWXMNK5/PYyr6s29ta2lDtQ6HS/RkewU1cSX5G
cxhHhhsc05XFy9opei4JYnHlmXP7RAWfKPhkw+7OJaU4v57MysxaSYXDEH/D4AI0
uaEOOtq0Eg5MS2IBKqjgMZCulwfUH9xigjX2zQukgwGcpNkhRrkGHrINBQbYozcq
Y4aEsmZcv8J0l2kl2Ze6HJdRNJiQj63CBYmMdDYojrJSHzHhzsTX8AA7lnywv2dz
n5GzV0El7g6vc38KdWlj/gIwqm85aIjPfZtY/swNvdBlJUhGPm1oHJLWykoqnd9+
3h0cbPKZ1X882My5qWPa
=A/UC
-----END PGP SIGNATURE-----

--rwuWB/+Ski4Vd4IX--

--===============6815659307127221759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6815659307127221759==--
