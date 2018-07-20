From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Increase
	SND_SOC_TPLG_NUM_TEXTS to 32
Date: Fri, 20 Jul 2018 13:38:20 +0100
Message-ID: <20180720123820.GG10784@sirena.org.uk>
References: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6078435662413477264=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB0526772E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 14:38:28 +0200 (CEST)
In-Reply-To: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Puneeth Prabhu <puneethx.prabhu@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, pardha.saradhi.kesapragada@intel.com, cezary.rojewski@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6078435662413477264==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 03:57:06PM +0530, Puneeth Prabhu wrote:

>  /* string sizes */
> -#define SND_SOC_TPLG_NUM_TEXTS		16
> +#define SND_SOC_TPLG_NUM_TEXTS		32

This will increase the size of the texts and values fields of at least
snd_soc_tplg_enum_control which on the face of it appears to be an
incompatible ABI change, topology files created with the old value will
have a different layout for these structures to those created with the
new one.

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR17sACgkQJNaLcl1U
h9CjWAf9G53cEZOsqhX5nMA1XxdaTh2yhZzllVIsT4QQ1+HeLX2zSA8BrydPbPP0
mlcA9wYKTLZWlIQre/fb3VK42XUBrgh1Eas193X+JpZYJBriGCudpxiv4OaIqs0P
SMWb/FV3/3blsrtst3leifvwE8VbUWrZ8jGr5496gITePACkrBigVmANqkoeNPK0
FmKQsLOqlULNr5boV6Z3LhB1c/qvdXigmZHxvd3DssMVgdNwwYE5UFXWZgGONbxl
dLvGzifrr9ysu5v4l+xzxV2UMbuBVJXC1fz9rVvbJUIx7S0QWz4D+7HXghfyAXaC
Tns2wy9uQq5n+IGJ6HRgHac12nOnhw==
=HM3S
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--

--===============6078435662413477264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6078435662413477264==--
