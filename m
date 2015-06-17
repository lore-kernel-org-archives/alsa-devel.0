From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Wed, 17 Jun 2015 17:38:12 +0100
Message-ID: <20150617163812.GV14071@sirena.org.uk>
References: <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk>
 <s5hlhfj8wb3.wl-tiwai@suse.de> <s5hioan8w6v.wl-tiwai@suse.de>
 <20150616162507.GA28601@localhost> <s5h7fr38vax.wl-tiwai@suse.de>
 <20150617025448.GB28601@localhost>
 <20150617122340.GC3214@sirena.org.uk>
 <20150617162256.GE28601@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3223232151475594495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6441D265E04
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 18:38:20 +0200 (CEST)
In-Reply-To: <20150617162256.GE28601@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zhang,
 Vivian" <vivian.zhang@intel.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3223232151475594495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="plyNSP3Xah3rydZw"
Content-Disposition: inline


--plyNSP3Xah3rydZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2015 at 09:52:56PM +0530, Vinod Koul wrote:
> On Wed, Jun 17, 2015 at 01:23:40PM +0100, Mark Brown wrote:

> > I'm not sure this fully helps.  This will put the reference in the CPU
> > driver which if there's sharing with non-compressed DAIs means that any
> > machine driver using the platform needs to select the compressed audio
> > code.  It also means that we're still in the situation whre if a machine
> > *can* support compressed audio it *must* support compressed audio, it's
> > not clear to me that people doing this sort of memory optimisation are
> > always going to be doing it on hardware that doesn't have the capacity
> > for compressed audio (or won't in the future).  But then I don't know
> > exactly how much memory is being saved here...

> Yes this is a good point but then driver can define the compressed dai only
> when SND_SOC_COMPRESS is enabled. So if machine has enabled this symbol then
> only dai get added and machine can create dai-link

Well, if it's a user configurable thing then the stubs start to make
sense - the driver defines the DAI and then the core doesn't bother to
instantiate it.

> Also for the size question, in sound-next we have 248KB soc-compress.o

How big is the actual code - that sounds like it's got the debug
symbols?  I suppose I should go look myself...

--plyNSP3Xah3rydZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgaJ0AAoJECTWi3JdVIfQRcEH/3EKKzUL/ktNfr9lSvmzRzHP
/93Orh6Fy6Yq7XB+N38iF8ev/fEnvVoDQHbzAe3Ynh6jpH7SV2+SIiq0jtDwt2do
GycSHeiVvNFN2oWhrYDuFizkdeJCr+q/ZPBAHLHNC8bvj4QhxxO35TXBGKs15U5j
QsfmQez7TW2flJV9tsqYC1BEEAb3EF/9w1/baNGV4DdzRBIQJVJoEf+01pPO1eyr
AwU8vasdmVdGQZCVn9QpdLjKcJbs6BM3sDf6HkEGpq/cQ9X9F7VGrJfvLquqRmov
rVepFjh2Z5n2mYpRargmnKOTBBGNU2cwZVe8J0WZxJ+qDLRCYqovv2NvmChpVGs=
=vsRg
-----END PGP SIGNATURE-----

--plyNSP3Xah3rydZw--

--===============3223232151475594495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3223232151475594495==--
