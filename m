From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 16:07:20 +0100
Message-ID: <20120821150720.GS7995@opensource.wolfsonmicro.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
 <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <5033A0AD.2010403@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5937165666862741587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 875B4265F25
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 17:07:20 +0200 (CEST)
In-Reply-To: <5033A0AD.2010403@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============5937165666862741587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Content-Disposition: inline


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 04:52:29PM +0200, David Henningsson wrote:
> On 08/21/2012 04:18 PM, Mark Brown wrote:

> >Or perhaps what we want to do here is define the channel mapping in
> >terms of saying "I'm connecting to this input/output" and then use the
> >jack interface to describe all inputs and outputs rather than just jacks
> >(making sure it's easy to see which ones can change state)?

> That's an interesting idea. The possible drawback is that it would
> require all drivers that want to use this to implement jacks also.

I'm not sure that's a big deal, we should be able to make the fixed data
case easy enough to do.

> In the ctljack interface for HDA, we already describe all inputs and
> outputs - with the nonchangable ones having the additional "Phantom"
> suffix, so the result becomes e g "Internal Mic Phantom Jack".

Which of course is also replicated with the calls into the original
jack API.

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM6QdAAoJEFJkBDiqVpZ4GL0P/in6RPjix548Q8M3gePT2OiC
Mc02CSil+kGVZuT7F3sA2CGqhuvUh34uvwY6c9QAeuTEDYdrCwNEkTt6mvML/ZTh
wqkK2QMIRNjbgUI9DRe5Joi4smlxdlgrdc1M47CQHVvlXZH53vm5Bzr9t/FO3wpi
VWXfIFOdZYgNyCoeYU7MOWNH8lsPRaShhvmlaNjIu67vgVtNxB3cRptO7+FUg57c
eLPyY7TQc29qPhE6s3hKosrL+pk/mkO3Af2+rYqbxiaXTwyUleaPUs1uIYZP+JXQ
cA4oRSfMqZYPGt2JNkf/fwVUrBHgx9RXa2ZXouls8GfBc1fVYpXBlu/lS5Jp9yGI
/mazeq6XqWxP3MIWFqsIACQjgBUNSEJ/ZP42IK3l/9VxW5iteAkv2QZzv8pBrwmG
8R9YCxJkxt7N8gPMWTThEWzITkk+36UQ9F0NWM4zwwxhcRZMH3pu/18rZXHcW2eW
j3gH6pIdy/1qFB0nMgSpZmwPTlgC50lMthKGAtv338ZLAUS7pBUHDo/p6e/O7DJZ
TikIQDHpZLp47MXKrTi6btGTarXYAtJ6oAbZo03jPQ93g/01M98yI4+Daci92/He
GXdACSBAbu1y9YNGlvRTr4Z27BRdfaQoNam0meQDbZWwOYROttQUROelPySJTM7n
m0fi3kLSiyw52QWFf0SX
=zQmZ
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--

--===============5937165666862741587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5937165666862741587==--
