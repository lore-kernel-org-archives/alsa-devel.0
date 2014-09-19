From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Fri, 19 Sep 2014 13:40:47 +0530
Message-ID: <20140919081047.GB24663@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
 <20140918061237.GA24663@intel.com>
 <20140918172852.GY7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1300029627286466979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE73261643
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 10:37:16 +0200 (CEST)
In-Reply-To: <20140918172852.GY7960@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1300029627286466979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 10:28:52AM -0700, Mark Brown wrote:
> On Thu, Sep 18, 2014 at 11:42:37AM +0530, Vinod Koul wrote:
> > On Wed, Sep 17, 2014 at 12:37:06PM -0700, Mark Brown wrote:
>=20
> > > This doesn't really answer my concern - what happens if we're already
> > > active and making a change?
>=20
> > Since this is specfic to BE (SSP) port, the DSP FW doesnt allow us to r=
econfigure
> > the slots when it is active. These will take effect next time the BE
> > restarts.
>=20
> > Yes not ideal but thats something we have to live with!
>=20
> That's fine but in that case I would expect to see an error returned to
> userspace rather than just silently ignoring what it's doing until the
> next time we start a stream, or at the very least some sort of warning
> generated.  Silently ignoring things isn't great especially with no
> comments in the code, it ends up looking like a bug.
Error to usermode wont be apt as we accept the value and due to constraint
the value is applied at next BE start.

Yes definately makes sense to put a comment about this. Will update that

Thanks
--=20
~Vinod

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUG+UGAAoJEHwUBw8lI4NHB0gQANQFHTe1dDr0LEG2sXNUkjiu
wIBsrd14K+IID5m78khkwzH+hHEnghef+hoVfRuNXkHRTcD0WsIw64f5wlTgW/QK
PZ2YAsA/hBqS7jlvczM7iQrI3SfzfnI8mU/+3z0E3Bc1/rNK0V8X7k+Zx52S0HSC
1VMU3yYBUoiXIc7g3HSFAqDGPmKRvPKQ1849k5VYYGCSsFYIIV/+OwL35VD/Bb++
IxbtaHnOypQegOb91634pcPniqMAeIpxzN5fFAv3rOCTzMf9bf7YUcScJ4xgOrtn
h5GN2+rKKjL+X8l6emADKdbu1A+W8wxlT7ZNrQeE66K/BdIisgm6Ma26toig0PdQ
qWSQUQwz59o/EIJ+vRKlN2m1QQmJEZ5AIG/lTrGjnYFm9fY7EIPwrPdBfl49OMnG
AebR7bFBcACiyreZY4h0F+thVztPNxngXJlb/jHnnNDVN+4k2RTrD8MP2LyxJGje
yCKnjwcoxhQZMDFhcIGDCk/81giOJEDOxM7Po3o/Ox47MR0Wujcsn4l+63NWBxpp
nSCLdwiR4N28R2fkzdj5DIkStiQoiRY94lXK82yzFzgZFknPIxKYc50nIn9udxzN
S3gb9cGYU28vc7qCGGx27Drlx99mRDwLXnpaFSE4YFuaOZFwE22JCnNx7/kP1xB+
Pn3PwtkNuBYyx99HZlgZ
=I2gG
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

--===============1300029627286466979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1300029627286466979==--
