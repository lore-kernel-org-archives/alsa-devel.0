From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Fri, 12 Jun 2015 13:15:24 +0100
Message-ID: <20150612121524.GT1921@sirena.org.uk>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <1434110356-23516-2-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3078705165562836704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE05C2668E6
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 14:15:35 +0200 (CEST)
In-Reply-To: <1434110356-23516-2-git-send-email-yang.jie@intel.com>
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


--===============3078705165562836704==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MET8MpPxp2u2c48q"
Content-Disposition: inline


--MET8MpPxp2u2c48q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 07:59:16PM +0800, Jie Yang wrote:

> +static int __init soc_compress_init(void)
> +{
> +       return 0;
> +}
> +module_init(soc_compress_init);
> +
> +static void __exit soc_compress_exit(void)
> +{
> +}
> +module_exit(soc_compress_exit);

These are completely empty, why are they being added?

--MET8MpPxp2u2c48q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVes1bAAoJECTWi3JdVIfQ6E8H/jsyWOS7pOeGJVDxV5bVhv8S
uEtNcXqFzyDm2uoFMtV5h5a4SRkEgBx2nEJPNV2AOkL7iho3HenB464aGIC1gJOh
HtE7BerZx1UBq+fmLdDy0JZuAZT/FefTVDfMkw9YX0gOznesA3OJYq0ru4/YzCkd
bA2J91LOqqtFF+cmAxIoc4jUy6S84f+Z1k8Ti/StkxZo7Wdx3aG+5L11dN/X/YQu
KmoOF1CDL52+0z34VUnaTX3cnZou/4uEdfqZCTSQV3SMXYMWDmRRN1RagBaepbAK
70amFVSAXcHi2Fpg53BkXoIIXSKaGP3N02Sy3Q+27PvnLewztMPRKg+wiGuC/Xs=
=7dmk
-----END PGP SIGNATURE-----

--MET8MpPxp2u2c48q--

--===============3078705165562836704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3078705165562836704==--
