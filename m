From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Add basic debugfs entries
Date: Mon, 8 Jun 2015 18:40:41 +0100
Message-ID: <20150608174041.GK14071@sirena.org.uk>
References: <1433774222-25103-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6546632606704732438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 086292604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 19:40:50 +0200 (CEST)
In-Reply-To: <1433774222-25103-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6546632606704732438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e4HPWByEyAOAEWhK"
Content-Disposition: inline


--e4HPWByEyAOAEWhK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2015 at 03:37:02PM +0100, Richard Fitzgerald wrote:

> +++ b/sound/soc/codecs/wm5102.c
> @@ -1875,6 +1875,8 @@ static int wm5102_codec_probe(struct snd_soc_codec =
*codec)
>  	struct wm5102_priv *priv =3D snd_soc_codec_get_drvdata(codec);
>  	int ret;
> =20
> +	wm_adsp_init_debugfs(&priv->core.adsp[0], codec);
> +

Why are we adding this init to every individual CODEC rather than doing
it when we initialize the DSP (which there are calls for already)?

> +#ifdef CONFIG_DEBUG_FS
> +static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const cha=
r *s);
> +static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char=
 *s);
> +static void wm_adsp_debugfs_clear(struct wm_adsp *dsp);
> +#else
> +static inline void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp,
> +						 const char *s)
> +{
> +}
> +
> +static inline void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp,
> +						const char *s)
> +{
> +}
> +
> +static inline void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
> +{
> +}
> +#endif
> +

Why not just put the functions here rather than prototypes?

> +static ssize_t wm_adsp_debugfs_string_read(struct wm_adsp *dsp,
> +					  char __user *user_buf,
> +					  size_t count, loff_t *ppos,
> +					  const char *string)
> +{
> +	char *temp;
> +	int len;
> +	ssize_t ret;
> +
> +	if (!string || !dsp->running)
> +		return 0;

Does debugfs ensure that the right thing happens and this gets treated
as EOF rather than a "zero length read, please retry" (which something
might decide to busy wait trying)?  I'd have expected either an error or
substituting in an empty/informative string here.

> +	temp =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!temp)
> +		return -ENOMEM;
> +
> +	len =3D snprintf(temp, PAGE_SIZE, "%s\n", string);

Given that we already have the string I don't understand why we're
allocating the temporary buffer - if it's just the length we're looking
for then strlen() should be enough?

> +} wm_adsp_debugfs_fops[] =3D {
> +	{
> +		.name =3D "wmfw_file",

> +		.name =3D "bin_file",

Bikeshedding but _name not _file perhaps?  It's not going to give you a
copy of the firmware/coefficients.

--e4HPWByEyAOAEWhK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddOYAAoJECTWi3JdVIfQOWUH+gPiJCLrnctvlqRszErUIDQp
F6FEHqomdeVJoHWisl140IrmNH3Uox9NAHUaYOeAk7IjsspKhOUA8fK2staUDP4e
AJOY6+5Zz+ebCX4fM9AZ8z8IxWzwdzRmGKNj+uWuPqttxTVuPa5Cs+wn/q26Ur2r
p0FELXajhalVhVMXKWGpc7A1ndWtXoEHpAcpIhVUqp1zqCgrdQErNn9zBIFeYJz8
ZZZ9rUZBT4pB77VqV7XM8LvboHVWu3UmLLHNQDBwCTLIUzQYbBh0mXfGwSuB4Grk
AGppxw3mPZAC1CfuP6BbB/QF9Hc59bahWiPmYhWcXTpWo5kBgQz19f1obcgE2y4=
=1GwS
-----END PGP SIGNATURE-----

--e4HPWByEyAOAEWhK--

--===============6546632606704732438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6546632606704732438==--
