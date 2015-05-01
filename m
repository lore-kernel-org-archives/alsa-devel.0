From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ALSA: hda: add hdac_adsp_enable module
 flag
Date: Fri, 1 May 2015 15:41:21 +0100
Message-ID: <20150501144121.GB22845@sirena.org.uk>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <5542520B.8080606@linux.intel.com>
 <20150430192726.GD22845@sirena.org.uk>
 <s5hmw1pjqhm.wl-tiwai@suse.de> <20150501043940.GR3521@localhost>
 <55438A6E.1030102@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4343432828475806204=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 018E42606C3
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 16:41:28 +0200 (CEST)
In-Reply-To: <55438A6E.1030102@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4343432828475806204==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e82EAmBhnWJLghdN"
Content-Disposition: inline


--e82EAmBhnWJLghdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 09:15:10AM -0500, Pierre-Louis Bossart wrote:

> Maybe I confused everyone, it's not complicated: there is a register that
> indicates if the DSP is enabled and that can be queried before launching the
> DSP driver. There is no guessing or need for DMI-based quirks, the
> capabilities are exposed and that should be used. You can then add a driver
> parameter to fall back to legacy mode, e.g. for testing, but that would be a
> second level disable. For once the hardware does tell us what to do, we need
> to use the information...

Oh, OK.  That sounds sensible!  If that's the case then surely we should
just have one driver for the PCI ID which just skips enabling the DSP
bits based on a combination of the register and the driver parameter?
We shouldn't need this multiple drivers for the same PCI ID stuff.

--e82EAmBhnWJLghdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ5CQAAoJECTWi3JdVIfQ0nMH/j3PjNpAAytvEFjRV/+kdUJS
aX3zDaKS6UVCqPu64PVD/iw2ZDsfiArlAjh1F4R8cCDspp8nYkRdITNUDAf7IOAI
/opsNk382mmjhQlO7Vf5hWuvG6UwE+wsGcwYflXwGG3RMHZAGACd5CkDDLC2jgbz
DP5J4u3ww4uZ+eH4LNn5ZaY6JkmeNOQMjZjETWgPpzVSLPROvdwDcxanj0MTP6pq
ImRp98MdUcTOi7B94OILqlte38KVZ/6h8h42vqagOmKSnf6hOnPA9r9J+sqYUwZ1
et0G9cRU4+fwOueAWSQvR46pAQEp40a65IzwESPKwM2GMA1qSs7Itsh0cinAqJQ=
=QP24
-----END PGP SIGNATURE-----

--e82EAmBhnWJLghdN--

--===============4343432828475806204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4343432828475806204==--
