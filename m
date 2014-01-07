From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Tue, 7 Jan 2014 17:35:10 +0000
Message-ID: <20140107173510.GD31886@sirena.org.uk>
References: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8357488760565766045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7985E265090
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:35:20 +0100 (CET)
In-Reply-To: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8357488760565766045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D0q9PqIqvBFeK6vt"
Content-Disposition: inline


--D0q9PqIqvBFeK6vt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 09:55:42PM +0530, Vinod Koul wrote:

>  struct snd_codec_desc {
>  	__u32 max_ch;
>  	__u32 sample_rates[MAX_NUM_SAMPLE_RATES];
> +	__u32 num_sample_rates;
>  	__u32 bit_rate[MAX_NUM_BITRATES];
>  	__u32 num_bitrates;
>  	__u32 rate_control;

This is adding a field to the userspace ABI which will break it...  not
sure if we care or not but it probably ought to be noted in the commit
log at the very least; people do build things like distros with headers
=66rom older kernels than the ones they run.

--D0q9PqIqvBFeK6vt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzDrLAAoJELSic+t+oim97r8QAJAtoXTWpaQ7TpzCc0mN1jE5
slu3+lboaIDw9Oz07m9aN5E+ZQfCbVvNAIwdDJfVTZlyL0Le5C2AkLe+T+1od0Lv
qAkiS4Prj2RLg5/ndBkUXdlPQbXF7AIlM5xOet9PCt/BrEFfwPaBo9XqxcwmRyF5
w7A91RqjArBD2Csx7GIn6xYvTGIzsscQWe+OyS24L7Sya1zE6I0LQ6nlOPTVRfcd
J0UGEDhWfrxyqVNdDl+IzValpVinwnYKvWe92t/Ewn9HUttIYRp7khbPHPh43nUm
qKko0bPz7V6UtjnrEfoWbbL9LSen1TLq6U94aB8mPzbhL/MxygbO1Deb1lDN5ykS
qy50PN6Jj4rPhUTeMUejofUjZzO9qNYVmahbm0937WFaFJ02oClDXJ+HzQwdhVBV
EtalPk1JfbVnV3sUcHlGV6Lb1z+WzgBoFlyBILBq88x0Sw6+mJ4hSClrhgoRdQhb
/yQh1R8nt6ChsfvxlwW1HE0YIL6ZJUGXUXrmKfxEZdBLzFK7aWkhvIdYbP7c+xwf
jaX/jYC1JvfCTCZB00Zurcr1d6cP3ZgTlYIMho/FqpfbNvOZ0W8ZUX5AnZoBdoYq
EKLJPpW9gzxPCTIX69c3VTxsDtC44V6fe0kkjiIZYnk+r182HCmXsHf7CaA9VVbg
Iw0fBJ84sJExjvaBVid6
=t4pr
-----END PGP SIGNATURE-----

--D0q9PqIqvBFeK6vt--

--===============8357488760565766045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8357488760565766045==--
