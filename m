From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 14:33:05 +0100
Message-ID: <20120326133305.GR3098@opensource.wolfsonmicro.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
	<4F7031AD.3090202@linux.intel.com>
	<20120326102650.GC3098@opensource.wolfsonmicro.com>
	<4F705BF3.5080905@linux.intel.com>
	<20120326120853.GP3098@opensource.wolfsonmicro.com>
	<4F706F47.2090306@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4370813343356562740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77E24249DF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 15:31:31 +0200 (CEST)
In-Reply-To: <4F706F47.2090306@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4370813343356562740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nQUlLD2FJeKEtFpv"
Content-Disposition: inline


--nQUlLD2FJeKEtFpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 06:59:43PM +0530, Omair Mohammed Abdullah wrote:
> On Monday 26 March 2012 05:38 PM, Mark Brown wrote:

> >Sorry, that's not really clarifying things.  It looks like "long frame
> >sync" is just I2S but presumably there's some difference?

> Yes, in I2S mode, according to the spec I have, the frame sync leads
> the MSB of the data by 1 bit clock cycle. Whereas the 'long frame
> sync' mode starts with the MSB of the data.

This is probably left justified mode but I'm really not clear what
your question is here.  Please ask a *specific* question, with reference
to what you find unclear in the code.

--nQUlLD2FJeKEtFpv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcG/uAAoJEBus8iNuMP3db8MP/35eviDDChiQltWK2xkj7I3H
w3uezI7vNAMXEKWHkAtynlAa9H9Uoqp652Sl99H/e2kGvIxHsLTQrdl3eLo5o2h7
7gh+IBBB9ynSbg9MILuV5z9Dn0e+zalfGFLWQ3TXLseWtwd1IjRU6HN+pomhLr9M
MsTvYRt6LPzapIN80fq/BIHUZ1ltAEBxHSLjWAE5+dfmKBaqSbrITTh8fuAKq1+i
nfS9lE6Fn2H1AxMIXtNd+Nh5hWmVF7pm/MWmPKNhRIJF1T5voaJYX5U165LoeT7f
oWYB9td6YwyQMgTohPKztJxzvaWjJUUbK4YPyFg37je7xTrviUrSrbWIftqEm+tO
Y3/iKTrN2ML69/JX3MhBTEe9B3uAtNr8owQGAp3BrKlz8EMTWN+rWaUp66MLBS/n
J+IriwIm6ysj41UMb96/S8Y+dnj5D1Tvuj1Qldg4YmQWrU+/4y6qnRfbrLs/H8Tl
m2GbjFmQUzdWplQzolb4Mn5GP1KoULgakEzhVICI28n6IwIIQ3+prF67tlvMCFUr
UWCVuC81IQRaiH/zNWxA8fWNltk4hk+Nt+e2ohajDRryYdmoZ3gCeq8cpW/rwinf
t3WklAJihHA3H+I8EzD+H7we81xFpb+ucAPII3qprOz9ZzxDKKfTcZleBZPwjhUM
4+Qtxwtpj4s+NTLXMwDn
=Qxxx
-----END PGP SIGNATURE-----

--nQUlLD2FJeKEtFpv--

--===============4370813343356562740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4370813343356562740==--
