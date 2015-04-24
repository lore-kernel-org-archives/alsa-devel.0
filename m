From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Fri, 24 Apr 2015 18:33:31 +0100
Message-ID: <20150424173331.GY22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
 <20150420214638.GX14892@sirena.org.uk>
 <20150422035014.GD2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430528901722230875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 913C72606A7
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:33:35 +0200 (CEST)
In-Reply-To: <20150422035014.GD2738@intel.com>
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


--===============4430528901722230875==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yP26HYcdU/M+myrQ"
Content-Disposition: inline


--yP26HYcdU/M+myrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 09:20:14AM +0530, Vinod Koul wrote:
> On Mon, Apr 20, 2015 at 10:46:38PM +0100, Mark Brown wrote:

> > Much of this looks like a MMIO regmap, there's the memcpy() bits too
> > which aren't but otherwise...

> Yes they are. memcpy bits are to copy the IPC mailbox payload data to aDSP
> RAM which can range from few bytes to couple of KBs

Seems like we could use the block I/O stuff in regmap for that?

--yP26HYcdU/M+myrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn5qAAoJECTWi3JdVIfQ8lQH/1lrZK+8KCBmuxTBeyxbFQP0
3/P4fI0po1f2E7Iu0x11VmimIjCE60FQP/SHmnr2WQMMfOrDqkbr1g/3F+P1YBQg
0xE3LenDlR6h8Rp7b/PmDkFWCBQV+kv1TQ5qyk0y9Sv8siyHEejg0eFSyLqSHIvq
DIjOgcQCXkRNO/i+JGZMRu2VPiiOm0vFhaKS9XG89Z59PnOxbmpsXhmIN9ajGlYC
NjLt7JHk3l45t9CNI3AXEBOOoZh5sJbYIsRiV0f+9kMTHVzFuIgH0+iOdVvl4u4R
mGcAUw++nv2SMGA07Nw+py+tzAW5Fq4kLW6csVJTUggm2uFzYZFcFopUg4PrAbY=
=L6WU
-----END PGP SIGNATURE-----

--yP26HYcdU/M+myrQ--

--===============4430528901722230875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4430528901722230875==--
