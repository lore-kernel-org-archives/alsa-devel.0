From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Wed, 29 Jul 2015 13:33:23 +0100
Message-ID: <20150729123323.GC20130@sirena.org.uk>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5753336240405002078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 903A526060A
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 14:33:38 +0200 (CEST)
In-Reply-To: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
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


--===============5753336240405002078==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2015 at 11:53:57PM +0530, Vinod Koul wrote:

> +	case SKL_CH_CFG_I2S_DUAL_STEREO_1:
> +		config = (0xFFFF00FF | (SKL_CHANNEL_LEFT << 8)
> +			| (SKL_CHANNEL_RIGHT << 12));
> +		break;
> +
> +	default:
> +		config =  0xFFFFFFFF;
> +	}

Missing break.

> +/*
> + * Allocates queue for each module.
> + * if dynamic, the pin_index is allocated 0 to max_pin.
> + * In static, the pin_index is fixed based on module_id and instance id
> + */
> +static int skl_alloc_queue(struct skl_module_pin *mpin,
> +			struct skl_module_inst_id id, int max)
> +{
> +	struct skl_module_pin m_pin = skl_get_queue(mpin, id, max);
> +
> +	if (m_pin.pin_index < 0)
> +		return -EINVAL;
> +
> +	if (m_pin.is_dynamic) {
> +			m_pin.in_use = true;
> +			m_pin.id.module_id = id.module_id;
> +			m_pin.id.instance_id = id.instance_id;
> +	}

Double indentation here.  It's really unclear to me why a static pin
doesn't need to get merked as in use?

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuMgSAAoJECTWi3JdVIfQ8I0H/1r/UhRA4irnG01yOUV62qq7
MPRO/q+N7+iFZz0wKOP14EPr5IMCQkIJTXGeC23WlbBonQPozFM9zbCZNvRpjqEN
uPgKYyDFRPIeVvq4+7IR+2egzqwgNFVKght4WFuTDB+/bZzYRif7AASLEUhMWPo7
0L/3VO5j4TE3Eiq/6+gncBmcQ+fYlm+sJPp6qbpfJdwaeYkPqvstlTIET1pZuQ+i
La4iCyROfUW7yjRAXDb5JWW+8MHS+ueTZLTiqtMsg6MSvTrI2ZjXzO+L1yEeWjUM
FZsMGaW4mh5v8DQB2LHXDAq4F6xi3XaJohOn6wB0HFu/M9H2pFMU+cQBpjakliI=
=wjBL
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

--===============5753336240405002078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5753336240405002078==--
