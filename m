From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: Implement DAI links in a list &
 define API to add/remove a link
Date: Tue, 1 Dec 2015 15:58:47 +0000
Message-ID: <20151201155847.GL1929@sirena.org.uk>
References: <cover.1448294077.git.mengdong.lin@linux.intel.com>
 <91d3898f62702fa255fc82c9cc3d1d14a1208263.1448294077.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4278606500516600323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CA7261A0A
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 16:58:55 +0100 (CET)
In-Reply-To: <91d3898f62702fa255fc82c9cc3d1d14a1208263.1448294077.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4278606500516600323==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1icXJ1HDib4AVtD"
Content-Disposition: inline


--k1icXJ1HDib4AVtD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2015 at 11:04:04AM -0500, mengdong.lin@linux.intel.com wrote:

A couple of small things but otherwise this looks fine:

> +	struct snd_soc_dai_link *dai_link;  /* predefined links only */
> +	int num_links;  /* predefined links only */
> +	struct list_head dai_link_list; /* all links */
> +	int num_dai_links;

Why are we keeping a count of num_dai_links?  I can't see any users.

> +	/* add predefined DAI links to the list */
> +	for (i = 0; i < card->num_links; i++)
> +		snd_soc_add_dai_link(card, card->dai_link+i);

Missing spaces around the + here.

--k1icXJ1HDib4AVtD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXcO3AAoJECTWi3JdVIfQONkH/i2ROIaJaQjMLiVmFoQkDA9E
3kFmtGTskw5+STALBzHZKiyF5RzD6Abnwi6YalvXQ5qyo53c2Vprye7xpyu538Aq
KMrdy1A9ten3yex6tMaxFdopMA8PpZ6b1TdDv053KPuDp4CqicS8sml6prJ+KXcC
nNK+xQs8bfLIFtxTP53Lpuzvbcu3Qw2F5VpBxbdxXL9yRAB+LWNMjawUiA2eRwYB
YwjPXatoIPwJWaMLAdQmgpBTbC2iouC0vICdgL5EgW+tjjUHDKjur3HbfGr2KuoJ
2lV2wTKtNvwdyt1eIOfNqGVoajtIhjZ2NczqhVlMXtIaMIFm7eRiux8lqjkayhE=
=tGIP
-----END PGP SIGNATURE-----

--k1icXJ1HDib4AVtD--

--===============4278606500516600323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4278606500516600323==--
