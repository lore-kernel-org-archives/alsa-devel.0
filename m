From: Mark Brown <broonie@kernel.org>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Thu, 31 May 2018 11:22:50 +0100
Message-ID: <20180531102250.GA13319@sirena.org.uk>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
 <20180530092445.GC6920@sirena.org.uk>
 <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
 <20180530102028.GF6920@sirena.org.uk>
 <87tvqprm3q.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6734382667301890611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 807062678F5
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 12:22:52 +0200 (CEST)
In-Reply-To: <87tvqprm3q.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============6734382667301890611==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:15:37PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > No, I doubt anyone does - it was the PXA32x reference platform.  The
> > ones I'm aware of unfortunately got thrown out.

> I have a zylonite based on a pxa310 in my non-regression bench, if that can
> help. That's one of the targets I use to validate patches against the PXA tree.

Ah, that's excellent!

> I'll let you come up with a patch. Meanwhile I'll try to figure out if I can
> make the audio alive again.

Probably worth taking a look at the big AC'97 refactoring that happened
a while ago I guess...

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsPzPkACgkQJNaLcl1U
h9Dn3wf/UbttOergVOasJz9hHaekCwdp2DjNuuOalVwpWHwQ65jQphlhasv3Xk5y
2zprFijpJ9Me3VwEH7tM4yo0dKzoi0lU2hwnj8F9fTTEs/K5lZJgB4liGgGNIe7g
d4tegolppIxKARdV31zTilHSWmVjdsIbq59OdZNzCqV2Lpk8Or7s+PNJoDmGuK0l
x3gOErgeu1a6Mmm0/JbpcRHWVYJ0WTRbp4qTltwjAfcJztmFo5SdJjN6ojnCK7d3
fEWbQbEgixm0E83qXyF/+UMFdGuOHYTE9ijKHwS3pLoTAO+OiwrteBKsIYzI20oG
EmK0cM3poC8OBl/6bvwRlm5WEEHwDA==
=wqgN
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============6734382667301890611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6734382667301890611==--
