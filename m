From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
	event support
Date: Tue, 4 Sep 2018 16:03:33 +0100
Message-ID: <20180904150333.GF12993@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
 <20180903162503.GS10302@sirena.org.uk>
 <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6833731270034447732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 654362678DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:03:35 +0200 (CEST)
In-Reply-To: <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6833731270034447732==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 02:21:20PM +0100, Liam Girdwood wrote:
> On Mon, 2018-09-03 at 17:25 +0100, Mark Brown wrote:

> > Should this be integrated into the Linux trace event mechanism rather
> > than open coded?  It would at least be nice to not call this a trace
> > event buffer - when I initially read this I was expecting it to be for
> > the standard Linux stuff which obviously it isn't.

> Your right, I'll rename. The eventual aim is to make it more like Linux trace
> but we are constrained somewhat as some DSPs only 96kB or instruction RAM, hence
> it's a simple and raw trace infrastructure.

I was thinking the code could read it like it's doing now and then just
have a trace event to dump it into the core trace infrastructure as it
reads things in.

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOnsUACgkQJNaLcl1U
h9CoSQf9GvGwJy5pTu928XOftfsf3uRZHlkVKC37aFLERvvp5THdTKEKHhIGY9F3
qtTo1jH3v0DI1V2FxI2plrLzGRJ7AF2XZUpKOIZ0SbWnTPDPIYVPsVhoJEAgcLin
2kO4G0T7FWAOsvjTdWhwsW/ZpAo6e1YOISQPfHFsNMVxJU63yMwXydf0Nqewbfa1
ptMjJ2DUdO8L5DeOXxshKLg2KCpk9fhkouLFbipzEYaq7RKBXnDL+qNMt8i7/jdB
fe9lP+zFUFjf5oBWp4SyINM4WtlYdb4Q0NivK97qjVKlZKJPTclRetWdyZX/wUfD
3Yc0Bzacd2n1HzDRFIPWJ/n5cj2SaQ==
=acwc
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--

--===============6833731270034447732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6833731270034447732==--
