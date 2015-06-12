From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item
 for soc-compress
Date: Fri, 12 Jun 2015 13:14:49 +0100
Message-ID: <20150612121449.GS1921@sirena.org.uk>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0312640206408407688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8408926681B
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:15:07 +0200 (CEST)
In-Reply-To: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: ramesh.babu@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, vivian.zhang@intel.com, vinod.koul@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0312640206408407688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFRfxei4j9xfgtfb"
Content-Disposition: inline


--UFRfxei4j9xfgtfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 07:59:15PM +0800, Jie Yang wrote:

> +config SND_SOC_COMPRESS
> +	tristate
> +	select SND_COMPRESS_OFFLOAD
> +	default n
> +

No need to specify default n, it is the default.  I'm not seeing any
change here to make the drivers that do use compressed support select
this symbol and since there's no config text there's no way for users to
enable this on a per system basis so this breaks all existing compressed
audio support.

--UFRfxei4j9xfgtfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVes04AAoJECTWi3JdVIfQq4IH/ixM0hody5e1dmI9SROFzIi1
wDiVdTz61XofgxTvP/5tiL3wo736sf7psO10PUCwr49SZypg4aKLpT4IX5SbcYtK
D/XDFQ9Pjsh5FagxD4URr6eWMm2PTS3P0nBmq78ygZhfU0EXLhHliwOIwiGG+vOg
ELgwgWZh0UmVFRqFshJ90rTijpXmrTHbWAv92OBtvSdkLfO1oq87BmFhuheENuB3
B3A9NoDb48K4pKktRbUQumPmZMMazlcnS5zMV9ur+SeEfXOKV4T8sPD6COC2bSE4
/aJqoohRhN8s6dhQCoaX+ZFZZgMYlNqO1a9/JUFfsGyc/XrzcnetNAwPZJsoTFc=
=5/jV
-----END PGP SIGNATURE-----

--UFRfxei4j9xfgtfb--

--===============0312640206408407688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0312640206408407688==--
