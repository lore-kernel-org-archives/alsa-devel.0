From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: Intel: add runtime power
 management support
Date: Fri, 31 Oct 2014 15:30:05 +0530
Message-ID: <20141031100005.GJ28745@intel.com>
References: <1414739301-12659-1-git-send-email-vinod.koul@intel.com>
 <20141031103451.GK18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0642402180334851594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5DB260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 11:41:28 +0100 (CET)
In-Reply-To: <20141031103451.GK18557@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0642402180334851594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 10:34:51AM +0000, Mark Brown wrote:
> On Fri, Oct 31, 2014 at 12:38:18PM +0530, Vinod Koul wrote:
> > This series fixes the device open pm handling and adds the runtime pm
> > support. Also we fix lock usage while changing the driver state
>=20
> Can you please stop sending so many different patch serieses for the
> same code simultaneously?  I'm assuming that these are mostly orthogonal
> but it's making it hard to keep track of what's going on and I expect at
> some point they'll end up conflicting with each other.
The cover mentions the dependency for a series. This one is the first one,
thats why I resent after your comments, you cant apply the other two without
this one.

The compressed is second series, still applies on top of this. ACPI is third
one.

If it helps, pls process this one, and I can resend the remaining ones one =
at
a time.

Thanks
--=20
~Vinod

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUU12lAAoJEHwUBw8lI4NH68cQALCkqLncLKtkXtGGZ/lvexV5
l1cuZAlCN9swRJBjx6/GF29W8xm+zccaHRua+oSlSTXV1cteLjZc0HWsrp/DDg+A
r9234OWIv6+QlFYR1gZNTNuHFuGpiyubyKFPA7kgFX8v7EPWcb3xopk/T/2C9QXE
2iPHIAOQdsmnMnd4JPS+8Css6g/4HM5A2iFQqjYk2cia9TP3TzJY1TqhOsHAE3qq
qWNrdJ4uR5/xE5o+2frpo0ce0PxAZAlQN9LW12AXewIYF6z6ISqPtNACQvBLIV5m
VUv41CXpeMw1k/lQ+mU4yatIwK7Pzrwd3x+Pz5wH18WehK+JM9ERuDpiJqnCqZiX
3btMX6ltUuUYF2FBTSCmraGgaXgzQqXFWGiI/hBW/90RIWEreQq9Ope+DbATFjfT
nlobj8xPNV5DWeqQ61DL3yeglQZE86dHsQdlc+QY8BuUVZ1V8m+p+pMpvT05r6Ka
DCI1DYjRSbzuN34z/CGsp5ClrsP1t01C+DBo2eRH93WlvDwC0wuKh0UUfXG4LApb
vdp/TIoiBeBUqjea3XhZKRrAb0U4jz5wCHuRizeK4BeY+vpNd5iwTXaTI2lYyqhA
iuqcaozHEF9zFxxJMGZfiCn6+g+FMjjEoSrauThmAv2orvyUhiwFZbhD/xsNl40P
90pSsspTBoGQdxKh1BZO
=VqrS
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--

--===============0642402180334851594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0642402180334851594==--
