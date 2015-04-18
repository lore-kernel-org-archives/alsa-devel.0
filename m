From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/13] ASoC: wm_adsp: Add support for DSP
	control flags
Date: Sat, 18 Apr 2015 18:23:06 +0100
Message-ID: <20150418172306.GA26185@sirena.org.uk>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1428928085-20250-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7965439787031255747=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 918202617BB
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 19:23:15 +0200 (CEST)
In-Reply-To: <1428928085-20250-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7965439787031255747==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1G2Bc0EDIhoSmEt"
Content-Disposition: inline


--k1G2Bc0EDIhoSmEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 01:28:03PM +0100, Charles Keepax wrote:
> The DSP control information contains various hints about the usage of
> the controls use these when handling the control.

> @@ -418,6 +419,9 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
>  	struct wm_coeff_ctl *ctl =3D (struct wm_coeff_ctl *)kcontrol->private_v=
alue;
>  	char *p =3D ucontrol->value.bytes.data;
> =20
> +	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_WRITEABLE))
> +		return -EPERM;
> +
>  	memcpy(ctl->cache, p, ctl->len);
> =20
>  	ctl->set =3D 1;

What would be even better for these would be to apply these at control
creation time so that controls that lack read or write support just
don't have the relevant operations in the first place.  That would not
be simpler and would allow the rest of the stack to do the right thing,
for example setting SNDRV_CTL_ELEM_ACCESS_READ and _WRITE properly.

--k1G2Bc0EDIhoSmEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpL5AAoJECTWi3JdVIfQ7okH/jiHvRbPrRJQ0gNXtKtMvWO6
gLDgveM/wvUiw9xx5kchn7PKx+TOLdy08sflDvQTbevTwdmdg+/1uXctPrUREiA8
up9ET116OSevikGpMmQZvheuzZM0X4NWj0b74qLhztKNKWxs4GElxKjiWgloxYtq
0O1QwuGJp9MHuFFVJ0DdPmIjfeg4T570rSIr4zQUvAS8Kc9yJzhyJDz/j1ulf9gv
iUia1FiTU3pbzz6k7mkyqiB9UmwcyLnK7W3sRjafs9ecevjfvvi9vxbiQogfTbnf
P38aZSPBK7zeFiUYipaoSJ2cM7XSh0NrFq3nQAVT/elCUEA4D7KKTUhJ2X43164=
=gRkq
-----END PGP SIGNATURE-----

--k1G2Bc0EDIhoSmEt--

--===============7965439787031255747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7965439787031255747==--
