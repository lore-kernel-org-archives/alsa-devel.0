From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: wm_adsp: Fix validation of
 firmware and coeff lengths
Date: Fri, 8 Dec 2017 17:16:54 +0000
Message-ID: <20171208171654.GD7606@sirena.org.uk>
References: <20171208161520.sxiz6s3qcms2jeis@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5082273056824734933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A92E6266D45
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 18:17:05 +0100 (CET)
In-Reply-To: <20171208161520.sxiz6s3qcms2jeis@xylophone.i.decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: patches@opensource.cirrus.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5082273056824734933==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2017 at 04:15:20PM +0000, Ben Hutchings wrote:
> The checks for whether another region/block header could be present
> are subtracting the size from the current offset.  Obviously we should
> instead subtract the offset from the size.

This is described as a resend but I checked and I've not been sent this
patch before :(

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloqyQUACgkQJNaLcl1U
h9BT8wf9HpuPZ0Xn+QYrH114JVoY/WCBVfWeTpqPa2tSDsfZU+3bMnhSzlnPW2n8
WrnqqjnTH3BlwHLE6rhs/m+RYqMtCOxgY5Z+PV7oPeKkv8DGsL1JEGjWJLUfisnt
o7D8LMV/xcKNzhzl8KLuurKTKdEmj3nyw+JLzjngoWr/5j+8m0r/gZnlO9CqJCrG
sHw9Uf1ou7NLvKI3hG/QGSyW6bSl7zi4zcAT5Bi4GdxA9KgjmhuESSRjwBy47hIR
9aUxGWsCnQd44/6ipVeCt6XYHn/xGReF7KJItMs1zeJCMwEHdvFcjvu/jFp9D+fo
Njpdi9lcM4zdGW9ROhsHZGLGfO8Cgg==
=PZcu
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--

--===============5082273056824734933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5082273056824734933==--
