From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 03/12] ALSA: control: Add init callback
	for kcontrol
Date: Sat, 6 Sep 2014 15:21:24 +0100
Message-ID: <20140906142124.GG2601@sirena.org.uk>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
 <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6937398671970216225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAD47262634
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 16:21:43 +0200 (CEST)
In-Reply-To: <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6937398671970216225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 06:05:58PM +0530, Subhransu S. Prusty wrote:
> Some controls need to initialize stuffs like pvt data, so they need a
> callback if the control creation is successful.

Adding Takashi - this is ALSA core code so he needs to review it.

> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  include/sound/control.h | 3 +++
>  sound/core/control.c    | 7 +++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/include/sound/control.h b/include/sound/control.h
> index 0426139..1389f69 100644
> --- a/include/sound/control.h
> +++ b/include/sound/control.h
> @@ -30,6 +30,7 @@ struct snd_kcontrol;
>  typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, struc=
t snd_ctl_elem_info * uinfo);
>  typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct=
 snd_ctl_elem_value * ucontrol);
>  typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct=
 snd_ctl_elem_value * ucontrol);
> +typedef int (snd_kcontrol_init_t) (struct snd_kcontrol * kcontrol);
>  typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
>  				    int op_flag, /* SNDRV_CTL_TLV_OP_XXX */
>  				    unsigned int size,
> @@ -52,6 +53,7 @@ struct snd_kcontrol_new {
>  	snd_kcontrol_info_t *info;
>  	snd_kcontrol_get_t *get;
>  	snd_kcontrol_put_t *put;
> +	snd_kcontrol_init_t *init;
>  	union {
>  		snd_kcontrol_tlv_rw_t *c;
>  		const unsigned int *p;
> @@ -71,6 +73,7 @@ struct snd_kcontrol {
>  	snd_kcontrol_info_t *info;
>  	snd_kcontrol_get_t *get;
>  	snd_kcontrol_put_t *put;
> +	snd_kcontrol_init_t *init;
>  	union {
>  		snd_kcontrol_tlv_rw_t *c;
>  		const unsigned int *p;
> diff --git a/sound/core/control.c b/sound/core/control.c
> index b961134..9d30663 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -256,6 +256,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kc=
ontrol_new *ncontrol,
>  	kctl.info =3D ncontrol->info;
>  	kctl.get =3D ncontrol->get;
>  	kctl.put =3D ncontrol->put;
> +	kctl.init =3D ncontrol->init;
>  	kctl.tlv.p =3D ncontrol->tlv.p;
>  	kctl.private_value =3D ncontrol->private_value;
>  	kctl.private_data =3D private_data;
> @@ -362,6 +363,12 @@ int snd_ctl_add(struct snd_card *card, struct snd_kc=
ontrol *kcontrol)
>  		err =3D -ENOMEM;
>  		goto error;
>  	}
> +	if (kcontrol->init) {
> +		err =3D kcontrol->init(kcontrol);
> +		if (err < 0)
> +			goto error;
> +	}
> +
>  	list_add_tail(&kcontrol->list, &card->controls);
>  	card->controls_count +=3D kcontrol->count;
>  	kcontrol->id.numid =3D card->last_numid + 1;
> --=20
> 1.9.0
>=20
>=20

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCxhjAAoJECTWi3JdVIfQ8swH/Ah9PcdWZSTRnx/HoZOrHUU/
9DQBQuaZCyo/CnlyC6+6Q+UTTjiv54jiaV0AjjkglUnTB4L7PbdY+PR9JttOlDoU
819XhZjPzF57ucoR1s83wRJXGXg+4eWLfURH412S7/v5xqlbze457m6peBlkM+sL
1tfsvtvvuY2dPPYiQZjKxVDVHiW21vvLbhDFzRhpJYaOAvqU6kkQMCYPG5MfM25S
xcmdDG0teI8Fx9lYOuNfy8zgxsZ1DKrw/Mpwe1NaKr0VFUoMfYXSJD343QMTgyNu
eoAeRh2Ti7bYo7YipvV82kEQEmDW7eL9u1KA8k+Q09Tt7OAhl7Mqu/+fXGcbq+0=
=+hz8
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--

--===============6937398671970216225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6937398671970216225==--
