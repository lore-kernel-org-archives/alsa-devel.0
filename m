From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Add hw_params support for hostless stream BE
	DAIs
Date: Fri, 11 Mar 2016 10:59:27 +0700
Message-ID: <20160311035927.GQ3898@sirena.org.uk>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
 <20160302020215.GN18327@sirena.org.uk>
 <20160310205703.GA26632@jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7152616537553633211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75EED260541
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 04:59:34 +0100 (CET)
In-Reply-To: <20160310205703.GA26632@jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7152616537553633211==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Content-Disposition: inline


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2016 at 02:27:03AM +0530, Jeeja KP wrote:
> On Wed, Mar 02, 2016 at 11:02:15AM +0900, Mark Brown wrote:
> > On Tue, Feb 16, 2016 at 09:47:47PM +0530, Jeeja KP wrote:

> > Like I keep saying if you're thinking about this in terms of DPCM you're
> > solving the wrong problem - we already support supplying parameters for
> > device<->device links, we already have systems that need to configure
> > things for device<->device links so we can already see that if we're
> > doing something that only works for things that are on SoC and can use
> > DPCM then we're not solving the problem.

> No this is not exactly about DPCM. It is about the device<->device links that
> assume you can have only codecs as hostless and thus change the direction
> for the link. Since we are rendering from SoC we don't need direction change.

You're routing them via DSP though?

> > This is clearly confused, if we can't figure out what the two devices we
> > are connecting are based on just looking at the devices then that's
> > really not a good sign that our interfaces are sensible and easy to work
> > with.

> Right now dai_link assumes device<->device links based on params so we
> cannot specify params for anything where we dont want direction change and would
> like to treat as normal direction dai_link. So we propose this to move to
> codec_link flag and use params only for creating controls based on params
> provided.

What I'm telling you is that you shouldn't be writing hacks like this to
bodge things but coming up with scalable and maintainable solutions.  I
already discussed this with Vinod several times, we've discussed the
idea that if you're having trouble with the asymmetries in the
definitions of DAI links you should make the DAI links symmetric so
things like this just work.  We need clear, comprehensible abstractions
which work robustly not some mess of special case handling.

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4kKaAAoJECTWi3JdVIfQ1LQH/R9keiVgfaC9Td4kC0czeH75
T3v32DxQJvOdDfvAbq4ch1QiuP5Dtce3jAB0ducROH+Y6+phXpM9jZ09GGDFlry5
b9gZ09WUBDUJEZ4uhwY4SLHAuXyL8VDv4a0YL14L2Iz1I9sf2Bkr4BrroQqpR2S3
+R0Yo9PP6AaYgj6APlKbIEwYZis+dX0/T3eYiWm65TgRcetJByl+L4VfRf/IU1KZ
EFrJzjM/9MR9hvWJP0WJJLkCfjXU8/pFJexlVhgDB+xoIIlc2B1wauv3zE/NN1X3
t3cCxa5A0K75JMbGQV0KQuRidWXy1F1Lvfd1sIhsdl39UwBIEDbt1R9uhSd5TGY=
=KHXE
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--

--===============7152616537553633211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7152616537553633211==--
