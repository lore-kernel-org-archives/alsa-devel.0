From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Fri, 7 Aug 2015 11:25:08 +0100
Message-ID: <20150807102508.GL20873@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5972134001976021133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F06D7260425
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 12:25:25 +0200 (CEST)
In-Reply-To: <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Chunming Zhou <david1.zhou@amd.com>, alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5972134001976021133==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WTGs9IdE6u5sCExC"
Content-Disposition: inline


--WTGs9IdE6u5sCExC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 10:25:02AM -0400, Alex Deucher wrote:
> From: Chunming Zhou <david1.zhou@amd.com>
>=20
> This is used by the incoming ACP driver.  The DMA
> engine for the i2s audio codec is part of the GPU.
>=20
> This exposes an amd gnb bus for the i2s codec to
> hang off of.

Could you be more specific about what an "amd gnd bus" is please?

> +enum amd_gnb_bus_ip {
> +	AMD_GNB_IP_ACP_DMA,
> +	AMD_GNB_IP_ACP_I2S,
> +	AMD_GNB_IP_ACP_PCM,
> +	AMD_GNB_IP_ISP,
> +	AMD_GNB_IP_NUM
> +};
> +
> +struct amd_gnb_bus_dev {
> +	struct device dev; /* generic device interface */
> +	enum amd_gnb_bus_ip ip;
> +	/* private data can be acp_handle/isp_handle etc.*/
> +	void *private_data;
> +};

Looking at the code I'm not seeing too much bus specific except for the
above which looks like the sort of device we usually represent as a MFD
(with the MFD providing resource distribution and arbitration between
various component devices which fit into the subsystem).  Why code a new
bus for this device?

--WTGs9IdE6u5sCExC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxIeAAAoJECTWi3JdVIfQzrwH/RdYxK+xYXh9ASWeMXbm7RUS
Rwub0QeOVgAC+WHhNFU+tJeQ7x+LnCKA+wvl7dvyrYwn7l73e484j5alqdd3qbgj
ZH3LMhXa26HmbVKsh50rkfPaEClk5VsxY9BlwnC0fSlumcF7P6Tc8a4f5nIsmRJ/
sK81gezrjukGi78pIsOXuzM9GZfr80sKPsMP1brLxfpHrW8t2cwiNaOrbqqbm7EA
HcE5LN+wtpXI6h6/uh+uzcmZizwvBcDIKr3vQZipaxxnfI2eaMduLlTMBg+as4h0
rRMvtaFtyn97LBhhCvFNK5TNE7J0Yx1/Q3ZCzVyf8wdIsET80wZ1oK/kZNQeRY0=
=LrvO
-----END PGP SIGNATURE-----

--WTGs9IdE6u5sCExC--

--===============5972134001976021133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5972134001976021133==--
