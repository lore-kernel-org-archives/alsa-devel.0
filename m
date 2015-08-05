From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Update ABI with
 improvements for TLV, operations and private data.
Date: Wed, 5 Aug 2015 12:29:07 +0100
Message-ID: <20150805112907.GI20873@sirena.org.uk>
References: <1438769467-18729-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2706067511648277634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FE332614D6
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 13:29:23 +0200 (CEST)
In-Reply-To: <1438769467-18729-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2706067511648277634==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6caoKVhN0vwgdRDL"
Content-Disposition: inline


--6caoKVhN0vwgdRDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 11:11:07AM +0100, Liam Girdwood wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>=20
> This is the kernel patch - a corresponding alsa-lib patch has also been s=
ent.

This patch introduces multiple changes and should really have been sent
separately.  Please also try to keep your commit messages and especially
subject lines under 80 colummns so that they are legible.

> This patch updates the topology ABI version and adds support for private =
data
> types, specfic structures for each TLV data type and refactors the operat=
ions mapping
> structure to be generic (so that it can be used by other types). This cod=
e is only
> used within Intel atm and is not in an official alsa-lib release so impac=
t should be
> minimali for the ABI update.

Note that once v4.2 comes out then the kernel ABI will have been in a
kernel release and we're going to have to be a lot more conservative
about these things.

> Removed the following fields from topology TLV struct:
> - size/count: type can decide the size.

>  struct snd_soc_tplg_ctl_tlv {
> -	__le32 size;	/* in bytes aligned to 4 */
> -	__le32 numid;	/* control element numeric identification */
> -	__le32 count;	/* number of elem in data array */
> -	__le32 data[SND_SOC_TPLG_TLV_SIZE];
> +	__le32 size;	/* in bytes of this structure */
> +	__le32 type;	/* SNDRV_CTL_TLVT_*, type of TLV */
> +	union {
> +		struct snd_soc_tplg_tlv_dbscale scale;
> +	};

The combination of removing size fromm the struct and not having data
means that we can't in the future add a new type which has a larger size
than the current one without confusing older systems (Rather than just
having them drop the TLV information).  I'm not sure how likely that
really is but it's a consideration.

> +	if (tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)
> +		kc->tlv.c =3D snd_soc_bytes_tlv_callback;
> +	else {

Please remember to keep { } on both side of an if statement if they're
on one side.

--6caoKVhN0vwgdRDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwfN+AAoJECTWi3JdVIfQfcAH/RoWaQNnOEbJs96WdvBO1q0O
BXQAWwEXHBv2yYu6FIy8Q1uALgVKdyvsw0KEGj93iv5rN4uqDrZtqwmCXrHrkmHH
wJbwbZgrQmPed/HvQzfyphhhwI4iR7qQGRIu2bf8LwqPp16nstJRRqqv5LGreX91
MEtqwFeeQyrVAMZsDOJyznRzlUTIE1E1WPX2AYFUDg8z+Rd+purpIG+2tA+iLX0T
63Z4MhAom7NJttEJFBhSEVqtcNrK8/RzDQ+oE75QqJ7EkxBFGs0Reyo/9uqOOt7D
5olZDnvwLflkh0gK/tx4IURqADUqa8RlrWRUa1eK2Fqoj33xhiAKsCAZdRsrIe8=
=PJ21
-----END PGP SIGNATURE-----

--6caoKVhN0vwgdRDL--

--===============2706067511648277634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2706067511648277634==--
