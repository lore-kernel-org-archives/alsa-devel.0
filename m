From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 05/14] ASoC: hdac_hdmi: Apply
	constraints based on ELD
Date: Fri, 8 Jan 2016 14:09:33 +0000
Message-ID: <20160108140933.GT6588@sirena.org.uk>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2309002017186759471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2780C26040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 15:09:38 +0100 (CET)
In-Reply-To: <1449677781-7997-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2309002017186759471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JlQgkxKsF3TswZob"
Content-Disposition: inline


--JlQgkxKsF3TswZob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 09:46:12PM +0530, Subhransu S. Prusty wrote:

> +static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
> +						void *eld)
> +{
> +	u64 formats = SNDRV_PCM_FMTBIT_S16;
> +	int i;
> +	const u8 *sad, *eld_buf = eld;
> +
> +	sad = drm_eld_sad(eld_buf);
> +	if (!sad)
> +		goto format_constraint;
> +
> +	for (i = drm_eld_sad_count(eld_buf); i > 0; i--, sad += 3) {
> +		if (sad_format(sad) == 1) { /* AUDIO_CODING_TYPE_LPCM */

	switch (sad_format(sad))  {
	case AUDIO_CODING_TYPE_LPCM:

> +
> +			/* 20 bit and 24 bit */
> +			if (sad_sample_bits_lpcm(sad) & 0x6)
> +				formats |= SNDRV_PCM_FMTBIT_S32;
> +		}
> +	}

I really don't have a clear idea what the above is supposed to do or why
this is specific to HDAC and not handled...

> -	return 0;
> +	return snd_pcm_hw_constraint_eld(substream->runtime,
> +				dai_map->pin->eld.eld_buffer);


...here.

--JlQgkxKsF3TswZob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj8MdAAoJECTWi3JdVIfQ8JkH/RTpzLRboYCD4//sw7LdbMMX
NSQ4ksRry+4S9vVdXcj+Bj8Ax7XslrRhG8SfjwMN9RGQ0/Wm3CTQ4D5+DDITnpeB
5BnqcXSg5lD/WltGWuJ7EG6XSxv2TaipSvBgMoAoL8GxewkzQzKNP1iJGB8ZNnoM
NzDgJGEqKfuytGIltZN9u8oCfC/kK43X4lYNnXW6jb6TnaoVriOeCgO13INRfDFc
M0UpCX98YVQyOsULeTXUbiHN50EL0vl+ObExtSzt4BKFzF2Dh5U8ezQ/cGYKXkwb
2OEHpkt+6rIDLlIskNBZAgaZp217Jk7rmdoWvIx/HUR27mkbAGZelTRcEDeJqvU=
=PtXl
-----END PGP SIGNATURE-----

--JlQgkxKsF3TswZob--

--===============2309002017186759471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2309002017186759471==--
