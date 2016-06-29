From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Wed, 29 Jun 2016 19:50:23 +0100
Message-ID: <20160629185023.GQ6247@sirena.org.uk>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
 <20160628111520.GL17217@sirena.org.uk>
 <20160629040810.GN14022@subhransu-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237366508345608445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2A6926575E
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 20:50:44 +0200 (CEST)
In-Reply-To: <20160629040810.GN14022@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1237366508345608445==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 09:38:11AM +0530, Subhransu S. Prusty wrote:
> On Tue, Jun 28, 2016 at 12:15:20PM +0100, Mark Brown wrote:
> > On Tue, Jun 28, 2016 at 10:51:38AM +0530, Subhransu S. Prusty wrote:

> > > This is HDA specific and the tag is to support use of same DMA channel by
> > > both host and codec.

> > What is a "DMA channel"?

> Ok. I agree this looks like TDM and we should model it like that :)

> Now, the issue is how? The current TDM API doesn't seem so intutive to
> invoke for this case. What do you suggest...

Without knowing what tags and DMA channels are it's hard to make
suggestions...

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdBhtAAoJECTWi3JdVIfQvZ0H/0mGzF0h1NV3Yoj3G4TGg3vt
YljvWrZ1VoUMoVTug5Cx+hXj+iAV6a8iJXJZeQsCFEt7+RMxnXNe6uLgS0ZpXQkz
VsgQ2KSFV7LaJzXv6f4TeetKn0gdpe0zUUx+Udmexu1lkDMP6Ry/KYcmo2tMpaIm
JmvGHD26rfU8XczfpwAeByXLIugUnvME2pZZi9Ph9RBi9/KX2cJGa+CkxjKJIgJT
8O9j7qlyQZ0KQsnQYz7cUP34JBzYgGPocom4D5x13ME5/d0pxsIsOrpNVjmLn0bH
U/BMI+pKsNwMyo32BXnsxh/ECd9PwRdh34NrilhRuWdZpR1cgL34wTZFb9kYfL4=
=t0Q9
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--

--===============1237366508345608445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1237366508345608445==--
