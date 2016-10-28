From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: atom: Add debug information
 related to FW version
Date: Fri, 28 Oct 2016 17:33:44 +0100
Message-ID: <20161028163344.llazgdgico5qu26t@sirena.org.uk>
References: <20161028143250.10711-1-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7196555006888034105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62841266B24
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 18:34:04 +0200 (CEST)
In-Reply-To: <20161028143250.10711-1-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7196555006888034105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffm3qruaxci4bvos"
Content-Disposition: inline


--ffm3qruaxci4bvos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2016 at 04:32:50PM +0200, Sebastien Guiriec wrote:

> +	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
> +			init->fw_version.type, init->fw_version.major,
> +			init->fw_version.minor, init->fw_version.build);
> +	dev_dbg(sst_drv_ctx->dev, "Build date %s Time %s\n",
> +			init->build_info.date, init->build_info.time);

Seems like an odd mix of info/dbg but whatever.  I'd also recommend
adding sysfs or at least debugfs files exposing this information, that
way you can still get at it even if the kernel log has been filled with
other things.

--ffm3qruaxci4bvos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE33lAAoJECTWi3JdVIfQiD0H/2uxLlAXNnZiHQAmBQ7y/hzo
4ZQZsn5PwuC2pnOCHPPeprmYCsC/sazp4vPEJQoXArc7M7wE9z2nAudriXokkBAi
Yxv0zQiKZZUB5/X6roD4hxhg0vQhgkmjsFJhaJkKfpKV3UOlENhRBg87m/mldq+8
1eZ1d6yRjRPu6gMVY7lNeAxcUXWG8ZSffyUvT6WzUs+Mw3TIFxjZhiQMnmPXxLfB
X5FdCiPm3DKRHAxSGwMIxUB6e1H7BNaku1340fyasA0M8WNGCiWTUs5GA+35utMa
rKl8zUDS8jYmbvbSmyZlY0IzMuV6PTOl+4iz0Vbjt7apyGfP/ddKQmcr+ZuZCNY=
=EPE7
-----END PGP SIGNATURE-----

--ffm3qruaxci4bvos--

--===============7196555006888034105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7196555006888034105==--
