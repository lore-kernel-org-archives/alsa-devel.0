From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Fri, 31 Jul 2015 19:09:25 +0100
Message-ID: <20150731180925.GL20873@sirena.org.uk>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
 <20150729175631.GK11162@sirena.org.uk>
 <20150730031507.GI29916@localhost>
 <20150730190104.GA20873@sirena.org.uk>
 <20150731045350.GJ29916@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7257514118887391168=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0179A26171B
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 23:21:13 +0200 (CEST)
In-Reply-To: <20150731045350.GJ29916@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7257514118887391168==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2015 at 10:23:50AM +0530, Vinod Koul wrote:
> On Thu, Jul 30, 2015 at 08:01:04PM +0100, Mark Brown wrote:
> > On Thu, Jul 30, 2015 at 08:45:07AM +0530, Vinod Koul wrote:

> > | This series adds NHLT table support in the driver. This also adds support
> > | for dsp init, modules configuration and messaging support

One issue I should probably highlight is - what is a NHLT table and has
is it documented (I guess it is part of some part of some ACPI spec
given my understanding of the rules on publication of ACPI bindings).

> On your questions above, one thing I would like to point that typically we
> have alsa controls and dapm widgets to model the DSP, but now with topology
> core, we have moved these into the usermode.

I'm not sure how that's relevant?

> In driver we have handlers for the topology events, so yes it becomes little
> difficult to visualize but we can do better by adding comments.
> This series is mostly helper code for getting topology created in DSP and
> next (last series in current SKL driver work) series will add topology
> handlers which will use these helpers, so the big picture will be clear
> easily and complete flow can be visualized when these helpers are invoked.

Right, but you're sending all this stuff piecemeal with no advance
explanation of where we're going.  This is a recurring problem here -
there's lots of Intel specific abstraction layers which aren't terribly
clear and some of which seem to turn out to be redundant on review.

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVu7nQAAoJECTWi3JdVIfQFxEH/1RXSvMCAONaf2Xey4KOsCPs
ESxtBSZYlz0oydw/1LqIj441llfe0mN6YhibH6hthRuwFEoR5YdJ48OrtMt2Ska5
KJxSfkBV+jpU9ASPDu7u6RHICkgF4kzrm20EnLnL+nRPo3RY5+mOh5dl4QKx3k5c
4C+OED0lA/kcxmHPNGXX7ETUa0+zzbT74uSUnUpPxMKzraOmYDe0PQREa+WEmCW5
2ypevNmW35pD3GDxU44MPpa79k6usY5bdylw2bUMAp+d15zWrgSncW8pp8f7tXke
vknlRmLP46x6wWhlOhFnHVVXFdwFdWqwL2NWzMiKaamol9fZt/gKkGkqwYoZYg4=
=8VEK
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--

--===============7257514118887391168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7257514118887391168==--
