From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Mon, 26 Nov 2018 14:02:00 +0000
Message-ID: <20181126140200.GC9715@sirena.org.uk>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6493480045862632393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D59B526751A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 15:02:03 +0100 (CET)
In-Reply-To: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============6493480045862632393==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 24, 2018 at 10:05:42PM +0200, Dimitris Papavasiliou wrote:

> +static int pcm512x_digital_playback_switch_get(struct snd_kcontrol *kcontrol,
> +					       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
> +
> +	mutex_lock(&pcm512x->mutex);
> +	ucontrol->value.integer.value[0] = !(pcm512x->mute & 0x4);
> +	ucontrol->value.integer.value[1] = !(pcm512x->mute & 0x2);
> +	mutex_unlock(&pcm512x->mutex);
> +
> +	return 0;
> +}

Just remove the control, no need to jump through these hoops.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv7/NcACgkQJNaLcl1U
h9DABwf/SvYGuczpS+8r0U8Og7odpJTbxEaUSceGqnGlhNZG40v+puNE8zRnLovS
n1y7WOARA3QBzQ43P0iTiDwS4nXZrWn7iPpttPdYbMdr+ek3354NYwL6jJgQQd5Q
Y13Fl+KUHYbTmVZ+zx/p4Wc1aTiS7egK9grFB1M/GnKYogwWq1RRRJP8RNzg/1ZN
3POKEH8sIYA+Ljqw5sAqH84IgSYlu2BXBB/KR/m/DDfQ8luINnaqLhFB+18x7PJZ
lqSMZdbYYiF5VH9SL3p3IPgXLZkisjkzx3PDWLZ2AXT9+0zjVRbARp2lfX91jdWZ
ybjRPlkaS8S8U6dP/YommNyRJzY+qg==
=ddYm
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

--===============6493480045862632393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6493480045862632393==--
