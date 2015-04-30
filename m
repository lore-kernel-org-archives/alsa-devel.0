From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ALSA: hda: add hdac_adsp_enable module
 flag
Date: Thu, 30 Apr 2015 20:27:26 +0100
Message-ID: <20150430192726.GD22845@sirena.org.uk>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <5542520B.8080606@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144783236416895587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632062604F8
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 21:27:34 +0200 (CEST)
In-Reply-To: <5542520B.8080606@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1144783236416895587==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sPDkDMdRS1PSJyum"
Content-Disposition: inline


--sPDkDMdRS1PSJyum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 11:02:19AM -0500, Pierre-Louis Bossart wrote:
> On 4/30/15 9:52 AM, Vinod Koul wrote:

> >Some Intel HDA controllers sport a DSP. These systems can also be enabled
> >with ASoC HDA driver as well. So add a flag in hda-core to enable/disable
> >aDSP This flag for now is false, and should be true once the ASoC based
> >systems mature.  The integrators/OS vendors can configure this flag based on
> >system preference.

> This choice is contingent on the BIOS options, you can't enable the DSP if
> the BIOS said no DSP...

Presumably this flag should be coming from the BIOS by default and this
providing a disable only setting for test/development?

--sPDkDMdRS1PSJyum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQoIdAAoJECTWi3JdVIfQD2wH/AmRCHo/JICsVJ+1ABf13q6c
tKZechUO8JAmq03xickEOD5GmwX1S2yAy8aTTD3wu1VxmqepiHBmKKE3YXjyA3gu
Km5+hesaX6ceopGWaXsji7A1pyvwRyVb9ew8rC79Hd+WtEoxN2Mnvlbyas9Le2UI
6DqR5LtEvcXgEm42yCp5J2GkwgwZowCajF3xQ3LXKLr5v6W6McMFh1Tt9hzz/GPJ
5G/vkZrUOiU3Y4cgk6hvEICso4Op47Ac2eTdF1sVtB1CQlRw3/YcbLBLss6WSOQX
/f5QTDovwVGGY7B9jmHHftTVEs7SAR/26zE0qLg6u9Ut+XiVeouPJt4Ng6rsVTA=
=Fxad
-----END PGP SIGNATURE-----

--sPDkDMdRS1PSJyum--

--===============1144783236416895587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1144783236416895587==--
