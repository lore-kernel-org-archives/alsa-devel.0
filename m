From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix a compiling issue
Date: Sat, 18 Apr 2015 13:11:06 +0100
Message-ID: <20150418121106.GM26185@sirena.org.uk>
References: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6761655290676811524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1706C2619D9
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 14:11:11 +0200 (CEST)
In-Reply-To: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6761655290676811524==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Content-Disposition: inline


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 10:47:30AM +0800, Jie Yang wrote:
> Fix the compiling issue that we don't have snd_soc_suspend/resume()
> when CONFIG_PM_SLEEP is not defined.

> +#ifdef CONFIG_PM_SLEEP
>  	snd_soc_resume(pdata->soc_card->dev);
> -
> +#endif

Rather than have the ifdefs in the users it seems like it'd be better to
fix this by providing static inline stub functions in the headers.  That
way nothing else will run into the same trouble.

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMknZAAoJECTWi3JdVIfQvdYH/3r/FjwBJHOISl8ewZuObU+e
c3oadls5pivcQBlrdHuNnshH66Qr7fEtt0+1GT6trdmHdCtbrPWrBgUZ1fFnGCbW
l90fcnLmTsC/VF3FFNZRB9Xl6YZ+CQc6Ubemdd7d/RmIwAiJF8tqvkqNVYM7EPmR
UKEXLFmoJWesPuZc1zMhohuyJ9wLdOl53qcLHvQdKp+Os4Ex20zzYZzZrrNzrzR1
Nl8v6NGbQjESnH5WE2kbkijENjqdaCR9TGGQhriFxAbRZfWNrZJZiUnGaLKuSdQo
zUxz+/lR+wY+K4RRnsagJ/DjqUtJugcT4xEtAvXhBX0pdr0tUOFQs65y4Lxgc9c=
=uQ1D
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--

--===============6761655290676811524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6761655290676811524==--
