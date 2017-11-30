From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/15] regmap: Add SoundWire bus support
Date: Thu, 30 Nov 2017 17:17:26 +0000
Message-ID: <20171130171726.gx5j67i4bi6vvyjn@sirena.org.uk>
References: <1512035830-29161-1-git-send-email-vinod.koul@intel.com>
 <1512035830-29161-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6662540857191355668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3349A26698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 18:17:38 +0100 (CET)
In-Reply-To: <1512035830-29161-8-git-send-email-vinod.koul@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============6662540857191355668==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pma5lrtkumr6hvgg"
Content-Disposition: inline


--pma5lrtkumr6hvgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2017 at 03:27:02PM +0530, Vinod Koul wrote:

> +EXPORT_SYMBOL_GPL(__regmap_init_sdw);

Thanks for fixing this, this looks good now.  We'll need to work out how
this winds up getting merged in whenever that happens.

--pma5lrtkumr6hvgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlogPSUACgkQJNaLcl1U
h9DUtgf/af7VnlfAMa70VEwRIqAbttVqkl8+OEWJuAyZ3H5/bIe29kAubEJJpev+
bqADApgWHZ0qV4jEZLAotCgNoTTadWMdFJ0cebgEJR+aX4Ct25gH7tF/fQPTGJEk
E5zfLHCEPo4CmLU5Ok9icCwcgzQKMgwgySZ1fs75R75hshrDIP1a0qVk7fPj/Agl
2k2y8XGE6BL0NWj/1I5AI2viA/g1CIGWpzLRAak6GkSrvY024jR2OG3lxwK9V+3j
MIPziJuFOS4cff8+VtmmEGWj0WH6d0KPuoz5dd40u7I2hERW/kohOINYg96uD7m3
Zz/Hx9vgpFcH2rmAVMxm77+7Gah7OA==
=TZxf
-----END PGP SIGNATURE-----

--pma5lrtkumr6hvgg--

--===============6662540857191355668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6662540857191355668==--
