From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] ASoC: Intel: Skylake: Add helper
 function to setup host/link dma
Date: Mon, 5 Dec 2016 11:35:32 +0000
Message-ID: <20161205113532.e76i7xs246bddgc4@sirena.org.uk>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
 <1480700509-23380-2-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4340086557525239439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1B11266667
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 12:35:42 +0100 (CET)
In-Reply-To: <1480700509-23380-2-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4340086557525239439==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fdcc4upjjefdk4b"
Content-Disposition: inline


--2fdcc4upjjefdk4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 02, 2016 at 11:11:38PM +0530, jeeja.kp@intel.com wrote:

> This patch adds helper function to configure the host/link DMA when the
> DMA is in decoupled mode.

This isn't just adding a helper function...

> +	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
> +	if (!link)
> +		return -EINVAL;
> +

...it's also doing some things that appear to use that helper function.

--2fdcc4upjjefdk4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFUQQACgkQJNaLcl1U
h9BKpAf7BDNK4QRfSTpNGpMQH3NX35VKxAbfu/JA06TPQg/fKIBDAXvo+PsGsg3H
lZHMQySTmlDMmsCirytgjTh5FexWEBi5k5J5c2u9pUKXTGt00P8/HLo1YmN9G7qJ
pIExh8RAP0qBzvHQUmDLhqZE3BG4ynUDS+lzDQYJAgIHkSZB8fjqVjl4uPMu67Z2
/PFGzoTX4DdsY6w7S4s5ixYOaeBWEriM2hYWZLglHIRWHGs0UVcSc/d59V6C7/Sf
geWz3Pqsc6ZG2ZD9IKxlZn0wSg3TyOPx1P0FewdyBtL6B5hI5/VRgBT2GxUe9YFs
Hduag3GETqIi9OC0UWoSwU7r4YHQjQ==
=bvM0
-----END PGP SIGNATURE-----

--2fdcc4upjjefdk4b--

--===============4340086557525239439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4340086557525239439==--
