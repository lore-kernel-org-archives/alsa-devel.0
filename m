From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to handle parameter variation across different
 boards but same platform
Date: Wed, 4 Jul 2012 14:17:50 +0100
Message-ID: <20120704131749.GZ4111@opensource.wolfsonmicro.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8565264268830019316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACA48245D6
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 15:18:01 +0200 (CEST)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "'sudhakar.raj@ti.com" <'sudhakar.raj@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8565264268830019316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/1sb/HZzV9blKCG"
Content-Disposition: inline


--b/1sb/HZzV9blKCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 12:45:03PM +0000, Hebbar, Gururaja wrote:

You should fix your mailer to word wrap at less than 80 columns.

> Using machine_is_xxx() is not sufficient because there are 2 other
> boards on same Platform/machine but with different values.

> So, how to specify these parameters for the new board?

What do you mean by "board"?  If these are plugin modules for your
platform you need to either identify this at runtime and register a
different machine driver or select at compile time.

--b/1sb/HZzV9blKCG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9EJAAAoJEBus8iNuMP3dSk8P/0cc5p0xsVV3L0GmsjVDSScn
e7E1iPyI2ppbfAEn8Zha4fmUAxgZSshzXqZ8BM8mFWkW+9B5/YOTelqoAEqhFYau
nRj8fNyBOR2x4sZHWFaMYxGaRZ7uYcYgqjFNA75ZcLMu3iLserXFYOLa3Zxpjoss
FFUYw3MaLMc+yKs//JMzWENbzGNyNDiirk/nao/C85xxEHrUwQWuX/YvgWTBNS+c
4R7n/8xJidfmOCm+0lC6W26DFdnpQn68qXBMLVUXAv1817Bhsac4Oa4LxQDIPUg3
CINf6OXnEB2xewx287gye0ucBHegR6fsHlSco4bphmq6ocF15DF4iwAtiktqh8HI
FC/TdUPw0LKA5x2at6vrVYL3t9N2NrPnanO4h9TwF4hQgJfSjvmzt2iZ29/SBzOm
xynmT3roscBFc+XZ27vISyuhNeXGxyfmFJF5RFUAhzMys36U2CO6mUE3Ae7unGxD
WSx6J+/WrSP75DVSBr7MrMbyNcWENSyN+W2Oj3qF9/GHCBle96tcmHIOVn7wEHZR
qQVxym3+BRo5KrMXwukX+rwgIDfMZSVx1MzDTpB0gYKt8qhKjlKSHHfYSaGxLmTj
y4CcXmhMOfwH3BPYImsnFVxnqWCFppEE8RZESrp1FUz1hm2tNWbuIRqHpyTDHC/d
86ZullQ/JVJfhaQF7QYB
=uhgf
-----END PGP SIGNATURE-----

--b/1sb/HZzV9blKCG--

--===============8565264268830019316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8565264268830019316==--
