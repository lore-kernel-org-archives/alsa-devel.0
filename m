From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 16:20:40 +0100
Message-ID: <20190621152040.GI5316@sirena.org.uk>
References: <20190621113357.8264-1-broonie@kernel.org>
 <20190621113357.8264-2-broonie@kernel.org>
 <20190621132222.GB10459@kroah.com>
 <20190621143053.GH5316@sirena.org.uk>
 <20190621145309.GA6313@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZfA+D/N/UnTE6S9V"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621145309.GA6313@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ZfA+D/N/UnTE6S9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2019 at 04:53:09PM +0200, Greg KH wrote:
> On Fri, Jun 21, 2019 at 03:30:53PM +0100, Mark Brown wrote:
> > On Fri, Jun 21, 2019 at 03:22:22PM +0200, Greg KH wrote:

> > This is a view I still hold and in any case debugfs as it stands (and
> > was in the kernel versions since this was broken) is still capable of
> > reporting errors so we should fix that.

> Sort story is, I am trying to change it so that it can not report errors :)

Yes, I know.  This is what I think is a bad idea.

> And even then, no kernel code should be doing anything different if
> debugfs calls fail or not, that is why I am I making these changes.  No
> "real" code should ever be affected, and right now, it is, if something
> goes wrong with debugfs.

> So removing those checks is the goal here.  Your driver code should not
> care if debugfs is working at all or not.

None of which addresses the issue which is that we should be telling
users who are trying to use debugfs to debug things that something went
wrong rather than silently failing and potentially confusing them with
corrupted data display.  This isn't something you can address through
API restrictions without hurting users unless you are prepared to add
user visible error reporting to the debugfs core.

The conditional code here beyond printing errors only affects the
creation of further debugfs files, it's just there to avoid spewing
secondary errors at people when something goes wrong so the underlying
problem is clearer and is entirely compatible with the idea of not
affecting real code.

--ZfA+D/N/UnTE6S9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0M9ccACgkQJNaLcl1U
h9Bq8Af+PVFkh3ZMQMAxpPrWk3rRg/BQFsbLERElZQ53DaijZATrwHksee798bg9
ydkEqv0JLIVhQIns1BagFBxuBnaPPpKVZvbAiIvHiDPj5qf8spP/mfM9r7PaI8n5
zquhdry2iTbY41p+oMW7GoSg744C750E/5UHHPiMr6+g75mvWQqO1K1GkOsQ3fky
0/ecXc9nfdMJ/KLXGEKdcpNtKYEjNM4QtpmIDcteStRXH6gV/qW3Hw6s5jSpQ1jf
4I2UdPBcPKvukjvxHos8fnKTBslUh35Yt4NmkZRDRjbozXo+Hc4D3U9mOvqkHcCV
eQVOX17U1jPYRiXVPNlh7Z+yDO1skQ==
=gvme
-----END PGP SIGNATURE-----

--ZfA+D/N/UnTE6S9V--
