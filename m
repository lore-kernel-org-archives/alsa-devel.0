From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: Intel: Skylake: Add DSP module
 init and binding routines
Date: Wed, 29 Jul 2015 13:35:14 +0100
Message-ID: <20150729123514.GD20130@sirena.org.uk>
References: <1437503040-7392-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4372721105361596628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E21812605DD
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 14:35:23 +0200 (CEST)
In-Reply-To: <1437503040-7392-6-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4372721105361596628==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2015 at 11:53:59PM +0530, Vinod Koul wrote:

> +int skl_bind_unbind_modules(struct skl_sst *ctx, struct skl_module_cfg
> +	*src_module, struct skl_module_cfg *dst_module, bool bind)
> +{
> +	dev_dbg(ctx->dev, "%s: src module_id = %d  src_instance=%d\n",
> +		__func__, src_module->id.module_id, src_module->id.instance_id);
> +	dev_dbg(ctx->dev, "%s: dst_module=%d dst_instacne=%d\n", __func__,
> +		 dst_module->id.module_id, dst_module->id.instance_id);
> +
> +	dev_dbg(ctx->dev, "src_module state = %d dst module state = %d\n",
> +		src_module->m_state, dst_module->m_state);
> +
> +	if (bind)
> +		return skl_bind_modules(ctx, src_module, dst_module);
> +	else
> +		return skl_unbind_modules(ctx, src_module, dst_module);
> +}

I'm not sure I understand the purpose of this function - why not just
use the bind and unbind functions directly if they share nothing?

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuMiBAAoJECTWi3JdVIfQHfQH/3vFGkPR120ruzJaPOkds+WT
uGcFfDJ3ya0WEwJ+QoN8H29G/FGq55rUewESIpKgXeuYDNdZ2sZHvL4nShF2AcEb
COTp/3GZMvbhvFLjQbOIfGEXeTPBDo0tIz5+SZPwZVhyX1EHBXJFmIKF9HPI3vYW
3fppA3jgg/aJK1QcZul4dVTK+y87BS53q0L3oGOmS7zp06yT0Akr8Dnpzw7RE9y+
SU0WhVt1XWkKC61AbkSPB9GFEBCoVahW/CufEhjfHD/wvjUcUl93R07bRWcJZ7lD
RDwMKvl+3RLMZSoXzW0vuY7UBbLCTSFTcJODWKr+8JbUYAWaLWLCHBZdR2/zVFY=
=J8et
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

--===============4372721105361596628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4372721105361596628==--
