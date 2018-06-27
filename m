From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 27 Jun 2018 12:23:35 +0100
Message-ID: <20180627112335.GI1779@sirena.org.uk>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 <8736xhqzmn.fsf@belgarion.home>
 <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
 <87y3f9peyb.fsf@belgarion.home>
 <CAL_JsqKBOdZBuDnRUAcpARP1fFquc7vpcUayYRaJAMSPrhsPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3770734897306970529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF6E267610
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:23:39 +0200 (CEST)
In-Reply-To: <CAL_JsqKBOdZBuDnRUAcpARP1fFquc7vpcUayYRaJAMSPrhsPdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3770734897306970529==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 11:16:15AM -0600, Rob Herring wrote:

> Does AC97 specify a common programming model? That's were a common
> compatible is used (though experience has proven things like
> "generic-ehci" are don't work).

Yes, there is a standard register interface which all AC'97 CODECs
implemented and which does work effectively for drivers that only use
that.  Devices can offer extensions which do need specific drivers, and
there are ID registers which can be used to enumerate.  However one of
the things that some of the devices targetted at embedded systems do is
offer non-standard clocking features that need some configuration during
initialization (and may need to work with input clocks too) which
complicates things, especially in the context of DT.

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlszc7cACgkQJNaLcl1U
h9BahQf/ZczIHdyfC6r/Khks82FtXbEYPr1hq25SF8ExEQLpZMJXNMS4M2hFFPNV
EgZknbfoQAjMlVYijJKos61wcDihhzi1BH8KW6KpM6mJzEjRpgSQjmMHfIlEmJtH
4vsdpbvrwwSwdmPNWWduGnE4zNNzdzxBbHPaQvol7dAhxXNTawrvSolj/B9fv3Sj
mal8w/k2Kt1zk3f34A/VfBGxTmTcpFH/pvxEjCEhJZgQIYY3SlTDCa6CG9qtfbEO
6XcRVIwsOlQbYCGUBDK+d8gBQMuJ6uLpFu86IXob7bapETbHTk1Ve1DsWkSQHW5F
9Qh2wU2xEVa6kEJKwgbh6YyQo1J2Kw==
=I1Py
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

--===============3770734897306970529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3770734897306970529==--
