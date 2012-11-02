From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4: Add rstn gpio
 to platform data.
Date: Fri, 2 Nov 2012 14:40:27 +0000
Message-ID: <20121102144027.GB4413@opensource.wolfsonmicro.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
 <1351680814-13714-2-git-send-email-javier.martin@vista-silicon.com>
 <50913851.6060003@topic.nl>
 <20121101143514.GJ4413@opensource.wolfsonmicro.com>
 <5092953B.9080109@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2819933472421894070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E9E32650A0
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 15:40:29 +0100 (CET)
In-Reply-To: <5092953B.9080109@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Javier Martin <javier.martin@vista-silicon.com>, w.sang@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2819933472421894070==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5iEYumb6eglF6CEb"
Content-Disposition: inline


--5iEYumb6eglF6CEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 01, 2012 at 04:28:59PM +0100, Mike Looijmans wrote:

> >This breaks down if any of the drivers actually uses the reset pin to
> >reset the chip - if the reset might not actually happen but the driver
> >wants it to happen then things are going to go wrong.

> Good point. But in that case, the gpio cannot be "optional", the
> board file MUST supply it.

Well, what normally happens is that the driver has some alternative
ways of doing what it wants but if there's a reset signal present it
wants to actually use it and be able to rely on it doing the job.

> Do I understand correctly that I'm totally alone in this and that
> there is no point in uploading the code?

If you want to do something like this you should explictly model reset
lines like this rather than shoehorning them into a different subsystem.

--5iEYumb6eglF6CEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk9tQAAoJELSic+t+oim9FzsP/jYe1I/4UydGFPYLWm1ZpuXY
Hl+E+uMMcdN/N9lerpKUvtBXmV8dDFka3MObWrgIPrajykwwD1FMm1ZoyAXyxN+R
O0HURibwhc3BvjsPQrW46GSr7nKM4hszITi0cbcJ3uR+1kPA5QWhZEChcmpVfiI8
AjFqqTfqwjV1JUagKQ9axYD3sR4ltxAwSjw7bdLmo/c88uegZRvY2y//g9lfOLwC
ugOlrZNsU13xLCoB5HWyoZNW/iHeu1AWTBFk87QBMecfjUqSrD3/MxRV5SC6NXr7
vngAAEBl/3wGtp3sOKGS7QES+LcJBUyY6SiGcOdHskHu0KmCXI7Nfru7uC4Fxv19
+jyqWiiu9eIs4uzp6JS2GK6TBubiuZ0lufvBgWnmKDXUowIgkH17Cj8GSjF5lc3G
zjONolEEifA5rU3JxupvOdHmzoHj0YDVmgvLp/wkMHms9sHbPA2BeroixcUiRDeg
e0lSUNHpbvWXHLjJg+z69vqAerWq8cvs55kAL5WZy/5NjuyNkn6twFKfAkaieivd
LJPyazDjOHwJ4LzE/VtciWivI7uTKWJFTmQn1I8bSNaUU7ygtYNZusoHDxYwY9mm
mbByHRJj9fvA69RyzPOdojWXHJpC6XYLlgGhQ1aYMkIKm2mmJIpZ+v0+ybZZcgfd
0x+qGzbcTkPpLXESW1TV
=CAGh
-----END PGP SIGNATURE-----

--5iEYumb6eglF6CEb--

--===============2819933472421894070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2819933472421894070==--
