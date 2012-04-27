From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm9712: Microphone doesn't work,
	"Capture Volume" inverted
Date: Fri, 27 Apr 2012 14:46:39 +0100
Message-ID: <20120427134638.GI18260@opensource.wolfsonmicro.com>
References: <1335384469.14096.203.camel@mars>
	<20120426112726.GF3207@opensource.wolfsonmicro.com>
	<1335448142.20000.40.camel@mars>
	<20120426172010.GP3207@opensource.wolfsonmicro.com>
	<1335474693.3628.26.camel@lovely>
	<20120426213745.GA18260@opensource.wolfsonmicro.com>
	<1335513602.3504.4.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5285045811757043025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C378243B7
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 15:46:41 +0200 (CEST)
In-Reply-To: <1335513602.3504.4.camel@mars>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: alsa-devel@alsa-project.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5285045811757043025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Content-Disposition: inline


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2012 at 10:00:02AM +0200, Christoph Fritz wrote:
> On Thu, 2012-04-26 at 22:37 +0100, Mark Brown wrote:

> >   The write will be suppresed if the register contents don't
> > change which looks like what you're seeing here -=20

> Can you imagine why the registers don't change?

I can't immediately think of any reason, no - I'd step through or
annotate the code and have a look.

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmqGuAAoJEBus8iNuMP3dfjEP/3psgN1KmB/QfHWrOxj0lZ2b
jMK4dLKmJEi04Y2gtQQ5KxUtjOtAgoOajmJTVbDP9IS4DdYNmOtOGtNlFmyGD0/T
QdU6zCyCFNK80tc29OTgcpHBtaiZyGvfwzGkd2XmIhFnrlBE8KoS/WIhA+K/NTqh
zsl1H+MFxPOgTExfIwzJaXKlVsS6GOPyfALHWVakOK1UaAzT6nFezyBDc/F+l9/M
/nI0vQHJNMPD7Na8fxx2n3wAdLGshbKNx2rYnPfkHv9+8wtOPj4nxNATCpksqzVD
fQ+xw02knX05DjviqHKQL2zCoOkGSQAx2J36sT/wLxLaMuZ2c44BNOMkKP+CM1yN
uZjCkyUlUuWa+kgtfiFo2JosOHNL/DEE4T21LOAIXKVSvKiUQqnhlRwzODkEWd3l
3Wq93NxFgWTa6+QwTVGxHEkPV32zhaopUNbqqyIFU/6WL7BcPTAApwp6A4vjvoI1
wvLXgzy9YHvfO1DfkfUccWRy2632AiCl84kiVLz5t4mIZZzfQPOg0aaNfk8pF9QI
870uEoyDunsIgxyivNToiIsqVSVSS0oUk47jX+JFEkROjdKw/y2DuEyUWlg/Sn1D
2jT33tXi9f04kk6OoKdMZyHsOEGX5VXBkotpQ4b8s0APfU0cj9XebMF+G1Mo36RN
BkIvFAjsS+BPxtFl2Y3p
=B6PX
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--

--===============5285045811757043025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5285045811757043025==--
