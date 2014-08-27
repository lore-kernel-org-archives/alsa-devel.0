From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 08/11] ASoC: Intel: sst: add power management
	handling
Date: Wed, 27 Aug 2014 21:46:54 +0100
Message-ID: <20140827204654.GA17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-9-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8227855362066698227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B71C22681BD
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:47:09 +0200 (CEST)
In-Reply-To: <1408625450-32315-9-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8227855362066698227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XIDYJB0fhGlMCTQ"
Content-Disposition: inline


--0XIDYJB0fhGlMCTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:47PM +0530, Subhransu S. Prusty wrote:

> +	/* When fw_clear_cache is set, clear the cached firmware copy */
> +	/* fw_clear_cache is set through debugfs support */

Not in this patch series!

> +	if (atomic_read(&ctx->fw_clear_cache) && ctx->fw_in_mem) {

Why is this an atomic operation?  They're a bit of an alarm bell for
correctness and it'd seem useful if the clear just happened immediately
anyway.

> +	if (ret) {
> +		pr_err("FW download fail %x\n", ret);
> +		ctx->sst_state = SST_RESET;
> +		mutex_unlock(&ctx->sst_lock);
> +		sst_pm_runtime_put(ctx);

This is a runtime_pm_put() in the runtime PM callback?  That doesn't
look right.

--0XIDYJB0fhGlMCTQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/kO6AAoJELSic+t+oim9RcoP/ih+lcEI//bXPRwps39si3IR
q3SI1gzwCm8Fa8wrLmIcS+y5zgXgzykLec0/pmmbSN/IqsQAA6bK8ZytmccmFuo7
X4gITrE5gq7kYhFwACzO7rxPpfJzkBV7FyRcm1IuHbzU7mxT2Jb9CR9+QM4KgE/e
TU5nftThQxdaZUPUp9a9zR+KKc6IF8DAlK7Y07rCHTZdVgbFsWfK0XRO60A2jxag
2cFQXLx5IRVSLHYZnqd2gj0H/BytoYzwKKOpyg8eznJ22VQvoZA/C33hgFWkFD0A
sZIK+zSQZIFvpIjZLZTldlANqvqk69Nnn4nwHgIgpz0Zh+c+8ZxdVvke/VcZJvj5
n7YzOdXSjKWd4915cBk50soGd0t3DR+SucDeZV1RHDZ5Uk4owySetcul8AgefpwG
iQRTBu0x0CMbaXK0Ssl/aVAaXITpwq7uXZCfFRbt9W441E7AMvNLuK5kuotArIca
QjQatTGMCzNSutzfgLsiErceB68fzedzt6yNMCBmDdtCdUPtIdHTN0bcOp4HYj2/
r7fAbkLkUvb+WVSCE59iUilaodnbrrP3TjngLvzLDFv86aH0MvPz8RD7ucbAihGE
XhS3boSYb3N+suU4U/GK3q+mxVj0NdLpiARDIezR4cz/HrIVdoJbmJeeBkNbgFzh
UnBMSZbTfp5r/1AymUz6
=cB/b
-----END PGP SIGNATURE-----

--0XIDYJB0fhGlMCTQ--

--===============8227855362066698227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8227855362066698227==--
