From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 3/7] ASoC: Intel: mrfld: add DSP core
	controls
Date: Thu, 25 Sep 2014 21:38:53 +0530
Message-ID: <20140925160853.GB1638@intel.com>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140925150813.GU27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3960975432556104871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E4B26041C
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 18:37:26 +0200 (CEST)
In-Reply-To: <20140925150813.GU27755@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3960975432556104871==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 04:08:13PM +0100, Mark Brown wrote:
> On Fri, Sep 19, 2014 at 04:46:04PM +0530, Subhransu S. Prusty wrote:
>=20
> > +static int sst_slot_get(struct snd_kcontrol *kcontrol,
> > +                       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       struct sst_enum *e =3D (void *)kcontrol->private_value;
> > +       struct snd_soc_component *component =3D snd_kcontrol_chip(kcont=
rol);
> > +       unsigned int ctl_no =3D e->reg;
> > +       unsigned int is_tx =3D e->tx;
> > +       unsigned int val, mux;
> > +       u8 *map =3D is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
>=20
> So the "channel" map is for transmit and the "slot" map is for receive?
> That naming doesn't seem at all obvious, I'd expect some confusion and
> resulting bugs there. =20
yes as multiple channels get interleaved to slot while transmitting and on
recive side various lots get de-interleaved to channels :)
These controls allow you to route stuff.

> This is a really big block of code and there's lots of things like this
> in the code which may well *work* but don't seem robust - not flagging
> up easy to detect errors for example - and I've been spotting things
> like locking trouble as well.  This is all setting off alarm bells which
> is worrying.
Ok will recheck this part and fix wherever required.

> > +	mutex_lock(&drv->lock);
> > +	/* first clear all registers of this bit */
> > +	for (i =3D 0; i < e->max; i++)
> > +		map[i] &=3D ~val;
> > +
> > +	if (mux =3D=3D 0) {/* kctl set to 'none' */
> > +		mutex_unlock(&drv->lock);
> > +		return 0;
> > +	}
>=20
> It's still not at all clear to me why we don't need to interact with the
> hardware if we're settinng this to zero.  AFAICT from the previous
> discussion this comment at the top of the file:
>=20
> > + *  In the dpcm driver modelling when a particular FE/BE/Mixer/Pipe is=
 active
> > + *  we forward the settings and parameters, rest we keep the values  in
> > + *  driver and forward when DAPM enables them
>=20
> is supposed to explain what's going on but since it's nowhere near the
> code it's unlikely that people will have seen it and it's not terribly
> easy to relate to the code here.  As far as I can tell the theory is
> that something is going to trigger a power down of the DSP and it won't
> matter but if this is the case it isn't at all clear from the immediate
> code.
None is just a SW state thats why :)

The DSP has the bitmap for interlever as explained in sst_send_slot_map()
/*
 * channel map value is a bitfield where each bit represents a slot
 *
 *                        76543210      # 0 =3D slot 0, 1 =3D slot 1
 *
 * e.g. codec1_0 tx map =3D 00000101b -> data from codec_out1_0 goes into s=
lot
 * 0, 2
 */
so based on the channel selected here we will set the map and send to DSP.
For none case we don't need to do anything. Yes this bit need this
explanation so will add up

>=20
> > +	if (type =3D=3D SST_MODULE_GAIN) {
> > +		struct sst_gain_mixer_control *mc =3D (void *)kctl->private_value;
> > +
> > +		mc->w =3D w;
> > +		module->kctl =3D kctl;
> > +		list_add_tail(&module->node, &ids->gain_list);
> > +	} else if (type =3D=3D SST_MODULE_ALGO) {
> > +		struct sst_algo_control *bc =3D (void *)kctl->private_value;
> > +
> > +		bc->w =3D w;
> > +		module->kctl =3D kctl;
> > +		list_add_tail(&module->node, &ids->algo_list);
> > +	}
>=20
> This looks like it should be a switch statement with a default case to
> trap any errors.
>=20
> > +		if (idx =3D=3D NULL)
> > +			continue;
> > +		index  =3D strlen(kctl->id.name) - strlen(idx);
>=20
> I keep on seeing lots of code with random double instead of single
> spaces.
this shouldn't be, will fix

> > +		if (strstr(kctl->id.name, "Volume") &&
> > +		    !strncmp(kctl->id.name, w->name, index))
> > +			ret =3D sst_fill_module_list(kctl, w, SST_MODULE_GAIN);
> > +
> > +		else if (strstr(kctl->id.name, "params") &&
> > +			 !strncmp(kctl->id.name, w->name, index))
> > +			ret =3D sst_fill_module_list(kctl, w, SST_MODULE_ALGO);
> > +
> > +		else if (strstr(kctl->id.name, "Switch") &&
> > +			 !strncmp(kctl->id.name, w->name, index)) {
> > +			struct sst_gain_mixer_control *mc =3D
> > +						(void *)kctl->private_value;
> > +
> > +			mc->w =3D w;
> > +
> > +		} else if (strstr(kctl->id.name, "interleaver") &&
>=20
> Both or no branches of an if statement should use { }.
will fix

>=20
> > +			 !strncmp(kctl->id.name, w->name, index)) {
> > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > +
> > +			e->w =3D w;
> > +
> > +		} else if (strstr(kctl->id.name, "deinterleaver") &&
> > +			 !strncmp(kctl->id.name, w->name, index)) {
> > +
> > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > +
> > +			e->w =3D w;
> > +		}
>=20
> Again no fallthrough case.
would that be valid. We have only volume, params, mute, interlevaer and
deinterleaver controls only :)
Can add fall thru for therotical if you feel that is right thing to do.

Thanks
--=20
~Vinod

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUJD4VAAoJEHwUBw8lI4NHBckP/0Ps9JbLFidBSwtZiGlj2taS
XUB2ASazyJry1FWFsYOF6iD9/cn+AqNV9ZdxK/ZpxW9t2wO8x66v1r6eerHjwl15
9H+GSFc8iuDUl+RrnynEu9A6RXYvL/M5n+6RiyXWpTIg9phZkXBD4auQqtHvRV/K
l2cal9wKwvC2sT6I9Jx+bp5Q0O9q1EsHL81Wt9vA0mTN5s1B/C9irFV+wP58AUCv
mGs3shhuIp3ajRXmcKjbkA+eVicC+UH4PiDZqSEGustTy81zmx1jqEtLHeXWzkoR
Kn761JJF0tUAfiVh4lpQSBKiOY4JKkqzw6mDHHkHTJkavIDem52PUgk3d39FrZx7
sGVjrNpjJQ6CZIhj37aOiR5pelL4VyHr3vqVuynfwQzExXdK2o4MWm54DJuWkulL
1jH75lX+UGn/Aqaz9dz1EMi83dp0XkBcKcI0XkHj2p8kAuOO1UP5516MGpAhjZGh
83WxTF7zbQY17AJ9k1arOTrn73lKWLYdFbp9NnQ3ItTL9RK9vkVH+kud5LhnHKDw
LyW4nM/Fo/D4wedx9SSyAYcgoL+zNe+PheopzuFd94vTLvE0QY9W97DeJU4dPppR
ZDTzP2+VlyhoieDRvD9DPi9ChreCROdWihAnYn/ZE7MEd0hYQM+i9CQqp1BGvIbB
V8i5o//+HMeiMH2b726P
=HZEz
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--

--===============3960975432556104871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3960975432556104871==--
