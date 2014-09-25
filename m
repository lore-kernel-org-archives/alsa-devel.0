From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 3/7] ASoC: Intel: mrfld: add DSP core
	controls
Date: Thu, 25 Sep 2014 16:08:13 +0100
Message-ID: <20140925150813.GU27755@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6392864643962876698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B97ED260524
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 17:08:40 +0200 (CEST)
In-Reply-To: <1411125368-5836-4-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6392864643962876698==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aZ/0/p6gSDXwzas7"
Content-Disposition: inline


--aZ/0/p6gSDXwzas7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2014 at 04:46:04PM +0530, Subhransu S. Prusty wrote:

> +static int sst_slot_get(struct snd_kcontrol *kcontrol,
> +                       struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct sst_enum *e =3D (void *)kcontrol->private_value;
> +       struct snd_soc_component *component =3D snd_kcontrol_chip(kcontro=
l);
> +       unsigned int ctl_no =3D e->reg;
> +       unsigned int is_tx =3D e->tx;
> +       unsigned int val, mux;
> +       u8 *map =3D is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;

So the "channel" map is for transmit and the "slot" map is for receive?
That naming doesn't seem at all obvious, I'd expect some confusion and
resulting bugs there. =20

This is a really big block of code and there's lots of things like this
in the code which may well *work* but don't seem robust - not flagging
up easy to detect errors for example - and I've been spotting things
like locking trouble as well.  This is all setting off alarm bells which
is worrying.

> +	mutex_lock(&drv->lock);
> +	/* first clear all registers of this bit */
> +	for (i =3D 0; i < e->max; i++)
> +		map[i] &=3D ~val;
> +
> +	if (mux =3D=3D 0) {/* kctl set to 'none' */
> +		mutex_unlock(&drv->lock);
> +		return 0;
> +	}

It's still not at all clear to me why we don't need to interact with the
hardware if we're settinng this to zero.  AFAICT from the previous
discussion this comment at the top of the file:

> + *  In the dpcm driver modelling when a particular FE/BE/Mixer/Pipe is a=
ctive
> + *  we forward the settings and parameters, rest we keep the values  in
> + *  driver and forward when DAPM enables them

is supposed to explain what's going on but since it's nowhere near the
code it's unlikely that people will have seen it and it's not terribly
easy to relate to the code here.  As far as I can tell the theory is
that something is going to trigger a power down of the DSP and it won't
matter but if this is the case it isn't at all clear from the immediate
code.

> +	if (type =3D=3D SST_MODULE_GAIN) {
> +		struct sst_gain_mixer_control *mc =3D (void *)kctl->private_value;
> +
> +		mc->w =3D w;
> +		module->kctl =3D kctl;
> +		list_add_tail(&module->node, &ids->gain_list);
> +	} else if (type =3D=3D SST_MODULE_ALGO) {
> +		struct sst_algo_control *bc =3D (void *)kctl->private_value;
> +
> +		bc->w =3D w;
> +		module->kctl =3D kctl;
> +		list_add_tail(&module->node, &ids->algo_list);
> +	}

This looks like it should be a switch statement with a default case to
trap any errors.

> +		if (idx =3D=3D NULL)
> +			continue;
> +		index  =3D strlen(kctl->id.name) - strlen(idx);

I keep on seeing lots of code with random double instead of single
spaces.

> +		if (strstr(kctl->id.name, "Volume") &&
> +		    !strncmp(kctl->id.name, w->name, index))
> +			ret =3D sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
> +
> +		else if (strstr(kctl->id.name, "params") &&
> +			 !strncmp(kctl->id.name, w->name, index))
> +			ret =3D sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
> +
> +		else if (strstr(kctl->id.name, "Switch") &&
> +			 !strncmp(kctl->id.name, w->name, index)) {
> +			struct sst_gain_mixer_control *mc =3D
> +						(void *)kctl->private_value;
> +
> +			mc->w =3D w;
> +
> +		} else if (strstr(kctl->id.name, "interleaver") &&

Both or no branches of an if statement should use { }.

> +			 !strncmp(kctl->id.name, w->name, index)) {
> +			struct sst_enum *e =3D (void *)kctl->private_value;
> +
> +			e->w =3D w;
> +
> +		} else if (strstr(kctl->id.name, "deinterleaver") &&
> +			 !strncmp(kctl->id.name, w->name, index)) {
> +
> +			struct sst_enum *e =3D (void *)kctl->private_value;
> +
> +			e->w =3D w;
> +		}

Again no fallthrough case.

--aZ/0/p6gSDXwzas7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJC/cAAoJECTWi3JdVIfQvTkH/imDJbW6njde7x/g27JS6eav
pd4sAmkFa2Y5bwhRi7tm9VDnWkTqd7/4WejHc9piIdV3q7XoE1vBGfKt2gLYke/M
OM5sB9Los4IobJM/xaYhz5eSWu8FiyMKfNBpDtHzPd7L7CwSJejrmxWh9KxgyudR
4xuoOXgSv4LI/jisZOVBiUCuX3PWaHgu9FXvJ1v8L5oFohcUZ0hl5QiHGoNXw33X
Apoq8IFraVHEOcIQiOdknCEL7vGIoWe16KUG86fFr4l7PNKRfADbrw36L4sfWqrD
7Uz24tPWH6Gz0krzSZZ6LrKaSLzN0YASPU/oTT2saKQUsyPCWjVoFMxoqfir8mg=
=XVfx
-----END PGP SIGNATURE-----

--aZ/0/p6gSDXwzas7--

--===============6392864643962876698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6392864643962876698==--
