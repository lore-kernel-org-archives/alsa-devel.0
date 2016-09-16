From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: topology: Able to create BE
	DAIs
Date: Fri, 16 Sep 2016 15:56:52 +0100
Message-ID: <20160916145651.GD27974@sirena.org.uk>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
 <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1784574212103558836=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D0B4266884
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 16:57:03 +0200 (CEST)
In-Reply-To: <084b7ba7ba3f0d4a97641b43fab26aee2dc20c5d.1473420558.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1784574212103558836==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mjeOt6n4R71vn6wN"
Content-Disposition: inline


--mjeOt6n4R71vn6wN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2016 at 07:43:11PM +0800, mengdong.lin@linux.intel.com wrote:

> From: Mengdong Lin <mengdong.lin@linux.intel.com>

> Topology will check with ASoC if a BE DAI already exists by checking
> its name. If the BE DAI doesn't exist, topology will create a new one
> and the dai_load ops will be called for device specific init.

I still remain fundamentally unconvinced that this is a good or scalable
idea and that it makes sense to have it be part of the standard topology
ABI.  We are not going to download a DSP firmware that creates a new
physical link in the system so having the topology be the thing creating
those physical links seems wrong.

> create the HDA DAIs. Ideally, the driver should query BIOS to get the
> physical pin output types and connections to peripherals for a specific
> platform, but unfortunately BIOS sometimes does not have accurate info,
> so there is still hard code of BE DAI & DAI links in driver. To share a

Having the connections to the DSP specified in the toplogy is of course
sensible but fundamentally this is always going to be choosing from a
list of physical DAIs that we already know about and potential
connections for those that are also already known.  If the driver wants
to do something in response to a DAI being hooked up into the topology
(which seems to be the actual goal here) that would be sensible but
attempting to create physical hardware in a topology does not seem like
a good idea as a generic feature.

--mjeOt6n4R71vn6wN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX3AgyAAoJECTWi3JdVIfQUY4H/0a67k0f06csHzry2e0LX6aU
jfeXbXtBa/255J7o77YhlmLludPfdZSJEADtLDmRkxr9FSvxISc2OQqDO8wcFtD0
LwiGOTf27pIzgbzI4c56rXi8L71qYUbPiUEZr7GXcJl87D6hLRuveGPfjdfXLAdC
Qm4tlg5MMvyKc3Jw5MwrsBuJFlckD+VWTpyZhyxtuiNeVVSg31r7zrQ+FP1SSXBp
o/CbHBtEwhONFB4YPy3WespSqL5lGpBiZyvp8NjGh8rUwyTr7YorfSlZN4oUN1al
vAKT7/6dMaNkC2RSX6XmzUC5aHo7eon/rx8UNGvYbFi26+n8elLnyamnv3MRrF8=
=0MhC
-----END PGP SIGNATURE-----

--mjeOt6n4R71vn6wN--

--===============1784574212103558836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784574212103558836==--
