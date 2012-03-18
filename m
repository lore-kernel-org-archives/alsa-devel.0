From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sun, 18 Mar 2012 21:27:11 +0000
Message-ID: <20120318212710.GA3074@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
	<20120316192231.GI3158@opensource.wolfsonmicro.com>
	<CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
	<20120317114856.GN3158@opensource.wolfsonmicro.com>
	<CA+7tXiheVO6FAypZU-yRuT=Cg3iPAgHeQOmVpZ_zJF_T5JdORw@mail.gmail.com>
	<CABb+yY1-tG9Mj9D13Kj3-M9ykEndwWijR8NOG8-TA-5Y+-jxUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7982059165958277271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 294EF103A5A
	for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2012 22:27:15 +0100 (CET)
In-Reply-To: <CABb+yY1-tG9Mj9D13Kj3-M9ykEndwWijR8NOG8-TA-5Y+-jxUA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7982059165958277271==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 18, 2012 at 11:52:01AM +0530, Jassi Brar wrote:

> Implementation wise, maybe two tightly coupled dais at machine level,
> could be represented as one virtual dai with independent virtual 'mute'
> switches for each physical path?

When I've considered implementing this in the past I've thought about
doing something like having DAI groups which own the physical link
configuration when you've got more than one logical link on the same
physical infrastructure.  The physical configuration would then get
punted up to the group level and we'd need some mechanism for the group
to start clocks when required.

I've only ever thought about it though so there may be some problems
there I've not come up with yet.  Might be useful to start the
refactoring for the clocks anyway, might be useful for the
reconfigurable channel allocation cases too.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZlMlAAoJEBus8iNuMP3dlgYP/3bVIY76rgv6Ob2XnyCizbhQ
w/0Z3XdwI46DUGHZakmuYZ6L2pKPvETuwuNQUZBhm3QqwHxEydBQhAJt4BXX6zC+
uCeFFfgs/xH1j5AJ5MKXGT5hmwLDgOGMTCxOerzyibmuHL4rkQdDFY4PixfRIGLt
XxhWFnGRkVLOjGjyQnJMrXRlho7r9vVPniQgUQRstJDNuNvenO1PQBej8dFjG7e5
DOO6YJCTkd/hgNm6Wns0G/Y8epvJuuSXYVj9Efr1J3AlMQGaKLOME0Bn4VqvkxQ8
imRjXCRh99yN2ERaCbB/O1WDXDo4xxKU9xX79HGzRRHlfV50QRxgxcj3Z8um5vXx
mRESrNuNO1wX1X4r139T4oQysXd+m52YFwi/XG5zbQq0MAIxKXHTuVEzAW2tguKI
R+QP8KsrWrZqz2+aAEKgNJ6RsR6ow6aBX45j9zllTz2MytwfEUSgjxD0LFJ5IJIc
suAEwHqJauttG8F6nE1mpHBwnI4SwAyoyI3//0qjVX8tj74wr2W8WAEwcbcMsvE6
+nDCEiVquwykg16tjtW61ScekHcC/URKcagtT9mhxNSPKKoLL/dQDgF7gWp2nYV5
mBvqQQR4W41spAnVVADH8NmDZ4WWvYrVkOEr6EsLWKWw+/vbv+oSKZkz1n4u481Y
APbCc8vAZdpFtC+ERa9h
=ExT0
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

--===============7982059165958277271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7982059165958277271==--
