From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Sat, 20 Jun 2015 10:15:35 +0100
Message-ID: <20150620091535.GM14071@sirena.org.uk>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
 <1434546055-28866-4-git-send-email-vinod.koul@intel.com>
 <20150619152748.GJ14071@sirena.org.uk>
 <20150619164824.GM28601@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1963882969901592420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E34F2606A2
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 11:15:44 +0200 (CEST)
In-Reply-To: <20150619164824.GM28601@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1963882969901592420==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aud9EHxdAK8dTD3F"
Content-Disposition: inline


--Aud9EHxdAK8dTD3F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 19, 2015 at 10:18:24PM +0530, Vinod Koul wrote:
> On Fri, Jun 19, 2015 at 04:27:48PM +0100, Mark Brown wrote:

> > Should this be _SKYLAKE_HDA or something?  I may be confused on product
> > naming and terminology but I thought these processors had both HDA and
> > non-HDA support (possibly in the same silicon at times)?

> Unlike haswell or previous controllers, we dont have a separate HDA only
> controller and a separate I2S based controller, it is integrated now :)

> So there will be only one Skylake controller :)

But this is specifically the HDA bits - I'd expect that there will be
systems where people want Sky Lake support but don't need the HDA bits
(possibly some of these more memory constrained ones)?

--Aud9EHxdAK8dTD3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVhS82AAoJECTWi3JdVIfQElIH/iyeT0tRM6C0l3xpi14d3dS1
2R8B5aevSfmBa4mbyXCy5ftXl9KypRaeKX2Qx0QENetv5YnGDI2b7QEW5AIpLSui
cjKAznxiw5JZExBWhBprz7FhC3EZdLEON3uno4c+T1ClNr45/b07p4d6reTq+SyE
DtVAhmjKZhlNL4xU9IOqt5R3WhB97vfSFm5iE7LHOcIDaguIr5Oe9p6eqeN+Calf
NMPZXsCNWRAPmKhY4SUYwbxFKsCZkIfMn/WXWy/3uotrkvaXvAiA87Na8s9GguRw
f/rSQJxopR73DYpEMi4DEmhJzvzLpP7DWMqlnWdbm240CJlUWh4sgGaeStSHUp8=
=pVmA
-----END PGP SIGNATURE-----

--Aud9EHxdAK8dTD3F--

--===============1963882969901592420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1963882969901592420==--
