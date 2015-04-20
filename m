From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Mon, 20 Apr 2015 22:30:48 +0100
Message-ID: <20150420213048.GT14892@sirena.org.uk>
References: <1429217295.7100.19.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6802381355277748385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5CE2654FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:30:56 +0200 (CEST)
In-Reply-To: <1429217295.7100.19.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6802381355277748385==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CRjAHycgiaTQGSqU"
Content-Disposition: inline


--CRjAHycgiaTQGSqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 09:48:15PM +0100, Liam Girdwood wrote:

> +struct snd_soc_tplg_hdr {
> +	__le32 magic;
> +	__le32 abi;		/* ABI version */
> +	__le32 version;		/* optional vendor specific version details */
> +	__le32 type;		/* SND_SOC_TPLG_ */
> +	__le32 vendor_type;	/* optional vendor specific type info */
> +	__le32 size;		/* data bytes, excluding this header */
> +	__le32 id;		/* identifier for block */
> +	char reserved[128];
> +} __attribute__((packed));

Not got a massively strong opinion here but given that we have ABI
versioning can we just skip the 128 bytes of reserved space in most of
the structs?  Doesn't seem to be doing much except making the files
bigger.

> +/*
> + * Mixer kcontrol.
> + */
> +struct snd_soc_tplg_mixer_control {
> +	struct snd_soc_tplg_control_hdr hdr;
> +	__le32 min;
> +	__le32 max;
> +	__le32 platform_max;
> +	__le32 reg;
> +	__le32 rreg;
> +	__le32 shift;
> +	__le32 rshift;

Do we want to convert this into an array of reg/shift tuples for the
(dobutless forthcoming) 5.1 controls?  Not sure it's worth it.  I do
think we probably need some explicit documentation for things like what
to do with the left and right bits, I guess we hope other OSs or
whatever can make use of the same topology if we're trying to make it
standard.

--CRjAHycgiaTQGSqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXAHAAoJECTWi3JdVIfQVsUH/1lG86VDetqCka8eg5dc0PVM
m66MdN/y4ttW1Q0yyOcyekmpEO3xNZpK84iJGk2tUiM6A2/UaBZ+Yl9bA02/Pejs
2N0YJ3Ul6v5b0Ujfy+9RVv4qapQ6Km0GTXe5XzOin6gZPWvk5iEGC5GRTH/5LcKp
9h/OGYhtgBnRKiJRNjtNZnzk+8zrsFEhQr0B71pPYPVZCKgB00Q8cfrZQhRfAhCb
YhqGhx/EcdDQP+ID7rmLMieRn3vTIqp+/NNaZFeW7myFiSQw9khouqUUywaLZusE
nM6Ib2F3XcuFiziW0FvwdfYEmctrIQzurLBviMMTAIGNAYEaW0Wpgu/WTyFnX00=
=ccLY
-----END PGP SIGNATURE-----

--CRjAHycgiaTQGSqU--

--===============6802381355277748385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6802381355277748385==--
