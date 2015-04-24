From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] Asoc: sti: add CPU DAI driver for
	capture
Date: Fri, 24 Apr 2015 19:20:11 +0100
Message-ID: <20150424182011.GH22845@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1804360220572454891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 976F22605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 20:20:16 +0200 (CEST)
In-Reply-To: <1429018531-29025-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1804360220572454891==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dQosGoreRE7ZTIn"
Content-Disposition: inline


--9dQosGoreRE7ZTIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 03:35:28PM +0200, Arnaud Pouliquen wrote:

> +const struct snd_pcm_hardware uni_reader_pcm_hw = {
> +	.info = (SNDRV_PCM_INFO_INTERLEAVED |
> +		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		 SNDRV_PCM_INFO_PAUSE),

The commit message says this is a CPU DAI but a snd_pcm_hardware is a
DMA controller.

> +static inline int get_property_hdl(struct device *dev, struct device_node *np,
> +				   const char *prop, int idx)

This appears to be duplicated from the previous patch, as does a *lot*
of the code here.  Can we not share more of the code between playback
and capture paths?

--9dQosGoreRE7ZTIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOolaAAoJECTWi3JdVIfQzJUH/2xanD+Uh7P+O4sHHSd7W4kU
x+yBW8N+r9p2WmJ86rRPijGQ8CFv9OL7YlnT1QMlPQdwhWeALFvMv2xji5l9OFgn
AeP3GwBy7vfSBnV3o90E9WCBaKIIGPyMKXrqXW6E4nlrpMmMWBOF15y5QTMdGsPU
4XMEHbT0OqZkZ0mhw/vRE6OSFh87lPWHnfR03OFC27FLZ6TD2AOiAOISrQCu1KUE
agOiWAyR5W+dSCbcoLUWjbagTQ7WQ7+8YINA3eIiSkDs9Z2sggZdMF/FBPCfCmQI
VCxEsKNadkk9zindVLjYmBw27mDc9xyE9jSTFMFL5shWnsHrSL+rGXUtDiPMDV0=
=Zm//
-----END PGP SIGNATURE-----

--9dQosGoreRE7ZTIn--

--===============1804360220572454891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1804360220572454891==--
