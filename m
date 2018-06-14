From: Mark Brown <broonie@kernel.org>
Subject: Re: Slow SPI reads in ALSA causing mic recording error
Date: Thu, 14 Jun 2018 11:42:23 +0100
Message-ID: <20180614104223.GA9660@sirena.org.uk>
References: <CAES_P+96hMOrbtVekpUC6dJg8Znmq9a8VSVU7hNAA5XG00eYjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4435354428460098822=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EC6E266E76
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 12:42:26 +0200 (CEST)
In-Reply-To: <CAES_P+96hMOrbtVekpUC6dJg8Znmq9a8VSVU7hNAA5XG00eYjg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4435354428460098822==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 14, 2018 at 02:12:35AM -0700, noman pouigt wrote:

> I have also used high priority workqueues but that didn't
> help either. Wondering if I can get some pointers to debug this?
> also if there any alsa-utility which can simulate closely audio flinger?

You probably just need to ensure that you've got more than one period
so there's always one ready, increase min_periods or possibly make the
individual periods bigger.  It's normally going to be very hard to get
everything scheduled reliably if there's no margin for error, ensuring
there's some grace in case things run over will tend to be more robust.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsiRo0ACgkQJNaLcl1U
h9DDxAf/abxRTl+2+lkOSmn/Um8iMZFoNfUX7fSaccUAksS5EBhkJNx5j0J6dd3b
mU2G3o81SYvD47nShvBd2+bjofMHRFQS/F8/RXDLvVoZX4kiIhWIBwOj1ARqVu5Y
zcjJ/2rEF1Hd3zp6iNtLqG1ybotNGuyW+xl6Ak7RItpMofwMRtyzj/T9xePPgonN
68AHwpD4bQfgBDl0YLQjM1LYrZFUux4JVxqr6B8BPBvQka516/nG9ssb0wZTLyGv
XkdaP3Hgd9LhjZjll5+73pLwMUBy+laY9gqVaHjV6RMsIfFriQbbg2QGwoSDSoKb
F0DsJzyBOnioe/9yWkM+MFdv4veTyA==
=MuRr
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--===============4435354428460098822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4435354428460098822==--
