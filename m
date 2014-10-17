From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/7] ASoC: Intel: sst: Add IPC handling
Date: Fri, 17 Oct 2014 14:09:18 +0200
Message-ID: <20141017120918.GH1820@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3043452465440438009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C5F26064C
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:09:28 +0200 (CEST)
In-Reply-To: <1413469819-18775-5-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3043452465440438009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 08:00:16PM +0530, Vinod Koul wrote:

> +	spin_unlock_bh(&ctx->block_lock);
> +	dev_dbg(ctx->dev,
> +		"Block not found or a response received for a short msg for ipc %d, drv_id %d\n",
> +		ipc, drv_id);
> +	return -EINVAL;

Shouldn't this be a dev_err() or something?

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQQbtAAoJECTWi3JdVIfQoOsIAIJXFK+x+KXSWo/e+WMe1E+r
nc8B9dzHuFzMqHwWmVlbQ+IuQmcLKsZVsklu4CXLWlz4iWSI5eOFTYzCdxyF3d/L
1ovouUiw1C+d9NDj/5BSHCymEvIAyTM1GWMOOGAZ1Gx63lXfk91m3X1g0RHq8DQ1
z/dAPdz7gEXUOgJh9ccOs7mQBLNnxxkBOJC4orO6iWR/coNclt7x9aoRTYw9KjmC
i/pGHPP88lKUu1cCPJWjM6eW9ktf+6rv2extSxmYH6xcV9DkcvSm+TWl2RGh05l3
tRLbTcP0tjFhF6t04MLtCq5zBzUfKzHB44cxHdQbGwxVjnET0iaL0zW43rYsCM8=
=9XqS
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

--===============3043452465440438009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3043452465440438009==--
