From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Thu, 15 Mar 2012 17:53:11 +0000
Message-ID: <20120315175310.GR3138@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5729138346813195529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C680810461B
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 18:53:16 +0100 (CET)
In-Reply-To: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5729138346813195529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Content-Disposition: inline


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 03:23:04PM +0530, Ramesh Babu wrote:

> I need to make sure that all simultaneous playback and capture (across the
> all dai_links) needs to be of same frequency family.
> If the sampling frequency of  a new request is different from ongoing
> playback/capture, then it needs to be rejected.

> How do I handle it in machine driver?

Why do you need to do this in the machine driver?  Such a constraint
sounds like it's coming from one of the chips in the system rather than
=66rom the machine itself so it'd seem sensible for the chip itself to
impose the constraint so that other machines don't need to replicate the
code.

See wm8988 for an example of adding sample rate constraints, obviously
you can change the criteria dynamically.

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYix2AAoJEBus8iNuMP3df+UP/3ES5AXXOKOu7iNMmreco3f6
2aTCAeXywueDrDYErZswuB0NHZwtbPdt0u44pbk+hV96GYDyNJd9jHwbiU6Ed8tK
63N6WT50hzMQV6FWrEiMzNMMIjKQIG/zD559HLDLoI+7VjXb8jedTGgHluLqlzFo
vRjDPWwsq6JprRYBwb4teva+swO5H8a+s2eWiskOCto7qtT7hA+ANj166UnCXlkk
/xcRzPf6g745qyESfgSaSpKERERBUxpG9PvW4AuNlV7PY66d7k6w2fOwfj/Wbs28
c3l42rlspeq4VdazMzGL02xE9OvNJN9N7Zb8V8qSDZ8Hoo/6asZoFtBcmfiNVyiL
8Yu391y3cH5Mpts6siwiMFmzpl8rgznwBrg/2yNwUHXId3Qsk3sKz4X2Uy/YYjM4
Wj+HU6sgqqAjvHawp6wdwqCPyqKstZqyRmL8/J/PkWIym9ahrkq4q0aLbhrsiJmT
MpcPPLixE8Eaj2BU+dA53CvqgfV8Nhwzadzr9TlbVqJJxtJrz94Fk9pLAc7cgnPO
yoSswNbTlmcJNOA1ftu/+hTseIdpFxVvEV0tTpWrxe/dVnO+AuK58ieC3EWPwBnL
c2jn98pUoCpkIfHl0KtuX98CQZqQksri5w/B6XL4zfbKIjh7+ie4UVdDGfCo0R9a
KeW1DleVGiAQSkmk39N9
=3VUd
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--

--===============5729138346813195529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5729138346813195529==--
