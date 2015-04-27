From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 6/9] ASoC: hda: Add Code Loader DMA support
Date: Mon, 27 Apr 2015 15:17:17 +0100
Message-ID: <20150427141717.GT22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
 <20150424171838.GV22845@sirena.org.uk>
 <20150426142822.GU2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6298562012380577901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 126732605C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 16:17:22 +0200 (CEST)
In-Reply-To: <20150426142822.GU2738@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6298562012380577901==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Vz7pjwpooMoMvmu"
Content-Disposition: inline


--9Vz7pjwpooMoMvmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2015 at 07:58:22PM +0530, Vinod Koul wrote:
> On Fri, Apr 24, 2015 at 06:18:38PM +0100, Mark Brown wrote:

> > > +		goto cleanup;
> > > +	}

> > What if the buffer is just too big?  Looks like this would loop for
> > ever.

> DMA is started, so link_pos get updated and we keep reading it. Since its
> DMA a big buffer will get done fairly soon.

No, two separate questions there - what if the buffer is bigger than the
maximum size (it looked like there was one) and what about error
handling (if some clock gets stopped and we don't transfer data for
example)?

--9Vz7pjwpooMoMvmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPkTsAAoJECTWi3JdVIfQHGgH/0mnQBz9l62uP7XfYjwBhrTn
/Xw15cZ27QOFB2IlTjFNPgw2DAFFaX7VX+m5oxvBjxcPC5ErZ/Jtu2IR2BBnJcKl
p+AJTOZz+3GjEqLvb9Sbbfnk4LMkitA0cPo5WaSrWQe0PMMfEennHxKWFJAJ/5cp
nQjrEF790MTn2yLTwEOujmYq5p7F9EnVBkkmRwU9LuLFrPYThdfbA6rLtvhvSB5q
vxcQPeGcfZ5YGX6UlMRztobkMSb2OUWkHVnWMwkD8jlSrNyvt+58Jm+ZTUPyz7bk
7kHtBwZ7pqOUTWajv3iNgKQCahtF2ad3EKYK1blKH+CG95kOdHdw6wZPRkc6ywk=
=rkZw
-----END PGP SIGNATURE-----

--9Vz7pjwpooMoMvmu--

--===============6298562012380577901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6298562012380577901==--
