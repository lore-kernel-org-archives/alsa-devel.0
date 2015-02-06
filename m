From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] soc: intel: sst-haswell-ipc: Remove unused functions
Date: Sat, 7 Feb 2015 07:11:11 +0800
Message-ID: <20150206231111.GM31311@finisterre.sirena.org.uk>
References: <1421537927-16567-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XlS4q8O07AKt4+K1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421537927-16567-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jie Yang <yang.jie@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, Christian Engelmayer <cengelma@gmx.at>, =?utf-8?B?UGF3ZcWC?= Piskorski <pawel.piskorski@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--XlS4q8O07AKt4+K1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 18, 2015 at 12:38:46AM +0100, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> sst_hsw_stream_unmute() sst_hsw_stream_mute() msg_set_stage_type()
> sst_hsw_dx_get_state() sst_hsw_stream_set_write_position()
> sst_hsw_stream_get_vol_reg() sst_hsw_stream_get_peak_reg()
> sst_hsw_stream_get_pointer_reg() sst_hsw_stream_get_read_reg()
> sst_hsw_stream_get_mixer_id() sst_hsw_stream_get_hw_id()
> sst_hsw_mixer_set_volume_curve() sst_hsw_mixer_unmute()
> sst_hsw_mixer_mute() sst_hsw_stream_set_volume_curve()

Applied, thanks.

--XlS4q8O07AKt4+K1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UoOAAoJECTWi3JdVIfQyNsH/jpzLi/VXVrF2Cymj0VjQijN
hE7rMAPNlkjG/zzU7oiiLuFS67WuirF+sK+Xp5eXGLlReF+ye4RqqZcikxSH6YRn
5NLRyuBFOGa6oTBEkjt2U808Y1AEkpybpV77iTeM6vZvkwA4pMSUQWiKEmtvTB5k
NEBz3wbv1DeShzqMTdwzWXKeDK/XSjr/fxoNf3jgD1arM0iuqDfeT/V4hgNYa/pB
BRTPX21D1LICluoxdNExS/gY2Y972UO+kNakMEP3nGd0zT+ty1nxJaP0BDtiEjBB
m9JIZByN+wghWY4HoecvV8ZuF2HjnjFPM+4NVWT7sF+yE8BnVmgZpITfQAPxSn4=
=WRle
-----END PGP SIGNATURE-----

--XlS4q8O07AKt4+K1--
