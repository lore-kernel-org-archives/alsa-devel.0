From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 9/9] ASoC: hda: Export API to change DSP
	power state
Date: Fri, 24 Apr 2015 18:33:04 +0100
Message-ID: <20150424173304.GX22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6627409807111419033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A161B2605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:33:08 +0200 (CEST)
In-Reply-To: <1429276567-29007-10-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6627409807111419033==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BxRsd5upxLmhizSM"
Content-Disposition: inline


--BxRsd5upxLmhizSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:46:07PM +0530, Vinod Koul wrote:

> +	if (state == SST_DSP_POWER_D0)
> +		ret = ctx->ops.set_state_D0(ctx);
> +	else if (state == SST_DSP_POWER_D3)
> +		ret = ctx->ops.set_state_D3(ctx);
> +	else
> +		dev_err(ctx->dev, "Power State=%x not supported", state);

Can we have a switch statement please?  I'm a bit unclear why this is
being exported as it is, shouldn't things be wrapped up more so that the
DSP code owns its own power state.

--BxRsd5upxLmhizSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn5PAAoJECTWi3JdVIfQNSQH/35nmexRao8HT2fFcpK7o2vg
pYYYcU9dSir4z9zt7Z/RyTplwakzkovZh/gMg77ZdaIzTPC9cqoRXsJ5eCc3CMVR
u2mHLo/CsjDvHGEwSLgj6RHp0YUE2MHVEYEKE15H7QZjYco3XjVvl9alVBOfmkoH
sc3o2ApLCN4PZyeJW+0huRGjgdiK8aBlCbAVLkFDs088ioRPJz9uMNX0Aifmq/AV
dRRKwhNtiTg8hx+fLhT6WjnOKnxLkA2hJfURPjspRFcF+PZ5/fLZgKHT/xFpX1jo
8N0LkyKX2AmeixqJ6YX8Opm8WD3+tKkJPeeIzJOt/dfl17teQEnN2Isjw3rUkF8=
=6gi9
-----END PGP SIGNATURE-----

--BxRsd5upxLmhizSM--

--===============6627409807111419033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6627409807111419033==--
