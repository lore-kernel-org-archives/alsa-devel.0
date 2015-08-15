From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Sat, 15 Aug 2015 19:30:14 +0530
Message-ID: <20150815140014.GE13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-5-git-send-email-subhransu.s.prusty@intel.com>
 <20150814215310.GV10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9210487961896242197=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BF52650FE
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 15:58:16 +0200 (CEST)
In-Reply-To: <20150814215310.GV10748@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9210487961896242197==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 10:53:10PM +0100, Mark Brown wrote:
> On Sat, Aug 08, 2015 at 01:06:19AM +0530, Subhransu S. Prusty wrote:
>=20
> > +	/*
> > +	 * 16 bit is 16 bit container whereas 24 bit is in 32 bit container so
> > +	 * update bit depth accordingly
> > +	 */
> > +	if (format->valid_bit_depth =3D=3D SKL_DEPTH_16BIT)
> > +		format->bit_depth =3D format->valid_bit_depth;
> > +	else if (format->valid_bit_depth =3D=3D SKL_DEPTH_24BIT)
> > +		format->bit_depth =3D SKL_DEPTH_32BIT;
> > +
>=20
> What if the depth is neither 16 bit nor 24 bit?  Shouldn't this just be
> a simple override for the 24 bit case?

These are the only two DSP supports, so am not sure that overriding will
work with DSP. I think we should add else and error out.

>=20
> > +/*
> > + * Fill the BE gateway parameters
> > + * The BE gateway expects a blob of parameters which are kept in the A=
CPI
> > + * NHLT blob, so query the blob for interface type (i2s/pdm) and insta=
nce.
> > + * The port cna have multiple settings so pick based on the PCM
> > + * parameters
> > + */
> > +static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
> > +		struct skl_module_cfg *mconfig, struct skl_pipe_params *params)
> > +{
> > +	struct skl_pipe *pipe =3D mconfig->pipe;
> > +	struct nhlt_specific_cfg *cfg;
> > +	struct skl *skl =3D get_skl_ctx(dai->dev);
> > +	int link_type =3D skl_tplg_be_link_type(mconfig->dev_type);
> > +
> > +	memcpy(pipe->p_params, params, sizeof(*params));
> > +
> > +	/* update the blob based on virtual bus_id*/
> > +	cfg =3D (struct nhlt_specific_cfg *) skl_get_ep_blob(skl,
> > +			mconfig->vbus_id, link_type, params->s_fmt,
> > +			params->ch, params->s_freq, params->stream);
>=20
> I don't seem to have slk_get_ep_blob() but hopefully it's returning a
> void * in which case why do we need to cast it?  In any case it needs to
> be defined in mainline before this can be applied :(

It is already merged in your tree and part of NHLT patch. And my bad, it
returns struct nhlt_specific_cfg so the cast is not required and will fix

>=20
> > +	if (cfg) {
> > +		mconfig->formats_config.caps_size =3D cfg->size;
> > +		memcpy(mconfig->formats_config.caps, &cfg->caps, cfg->size);
> > +	} else {
> > +		dev_dbg(dai->dev, "Blob is NULL");
> > +		return -EINVAL;
> > +	}
>=20
> This seems like a more serious problem than something we just dev_dbg()
> about?

Yes this should be an error as it will fail and we can't start a stream
without this, will fix. Thanks for pointing.

>=20
> > +static int skl_tplg_be_set_params(struct snd_soc_dai *dai,
> > +					struct snd_soc_dapm_widget *w,
> > +					struct skl_pipe_params *params)
> > +{
> > +	if (!w->power) {
> > +		dev_dbg(dai->dev, "set params for widget=3D%s\n", w->name);
> > +		return skl_tplg_be_fill_pipe_params(dai, w->priv, params);
> > +	}
> > +
> > +	return -EINVAL;
>=20
> Shouldn't that be -EBUSY?  The normal idiom would be to check to see if
> we were busy and error out rather than writing it as only configuing if
> not busy (which looks like an error case now).

Not EBUSY. So here we are trying to set params for the pipe. So we would
expect that pipe (widget) should be powered up by DAPM, but if that is not
the case then we are in bad state. I am thinking EIO might suit this one be=
tter

>=20
> > +	list_for_each_entry(p, &w->sources, list_sink) {
> > +		if (p->connect && is_skl_dsp_widget_type(p->source) &&
> > +						 p->source->priv) {
> > +			ret =3D skl_tplg_be_set_params(dai, p->source, params);
> > +
> > +			if (ret < 0)
> > +				return ret;
> > +		} else {
> > +			ret =3D skl_tplg_be_set_src_pipe_params(dai, p->source,
> > +									 params);
> > +		}
>=20
> These two cases appear to be identical apart from ignoring the error in
> the else case...

Former is skl_tplg_be_set_params whereas latter is
skl_tplg_be_set_src_pipe_params(). In former case we set the params but in
former we set for source pipe

Agree we should check return here, will add that
>=20
> > +	}
> > +
> > +	return ret;
>=20
> ...unless it happens to be the last entry in the list in which case we
> pay attention.
>=20
> > +static int skl_tplg_be_set_sink_pipe_params(struct snd_soc_dai *dai,
> > +	struct snd_soc_dapm_widget *w, struct skl_pipe_params *params)
> > +{
> > +	struct snd_soc_dapm_path *p =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	dev_dbg(dai->dev, "widget name=3D%s\n", w->name);
> > +
> > +	list_for_each_entry(p, &w->sinks, list_source) {
> > +		if (p->connect && is_skl_dsp_widget_type(p->sink) &&
> > +						p->sink->priv) {
> > +			ret =3D skl_tplg_be_set_params(dai, p->sink, params);
> > +
> > +			if (ret < 0)
> > +				return ret;
> > +		} else {
> > +			ret =3D skl_tplg_be_set_sink_pipe_params(dai, p->sink,
> > +									 params);
> > +		}
> > +	}
>=20
> There's some more common code here and the same patterns as above...  :/

well the problem here is sink, source. Former was for source pipe using
p->source, here we have sink pipe and using p->sink.
Same here too that we either set params or for sink pipe

Jeeja did try to make this common but it becomes quite hard, if you have
a trick up your sleeve for this, am all ears :)

>=20
> > +	if (params->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > +		w =3D dai->playback_widget;
> > +
> > +		dev_dbg(dai->dev, "Stream name=3D%s\n", w->name);
> > +		return skl_tplg_be_set_src_pipe_params(dai, w, params);
> > +	}
> > +
> > +	if (params->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> > +		w =3D dai->capture_widget;
> > +
> > +		dev_dbg(dai->dev, "Stream name=3D%s\n", w->name);
> > +		return skl_tplg_be_set_sink_pipe_params(dai, w, params);
> > +	}
>=20
> Normally that'd be written as an if/else, and the only difference
> between the two cases here is which widget we pick...

Yes we can change to else. Btw should we rather do if and if else, and else
for error check, in case the value became bad. I am thinking latter.

--=20
~Vinod

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz0XuAAoJEHwUBw8lI4NHciQQAKTkeoz+zVMkIpZJVoPSERH5
omhwXN+uD7+C4sUXWsQZdUsc+Cwctyf9RpHls5mkoUYqUFZLNBuHdrHkeyn3s7ca
ygt2ySefn5RVUu+7b8drCsACLK4844Rz9W8Liou8Xb7m5bb1KP+GQ+bNTUXqo/8c
n42waAWedXqESIcMPx80P8qp95iKiz4Y25WCLYnzjT13C7olzOana0ztiyLxjvrV
GT6oAnhDTKugRSija5YqqnR9nSioDtoJGjPKrs+muvQcbPBKTS3jHYGekLafT1Ps
HqXjg9C7vftND6f8RyssSQ5XEQV6jqUtfuewWojYWj5mMSlXZfBFCluyHzKJ90Y1
75+dwKVaVLPTIio6DUINGZOhU7tAdNd6tMXHrlXCtVmF6LQcDuw7cQkmmaCVATRV
aBJiYcAe3UYdzFnVkgA2F0mArFO/wq0rhGt82giZnI/Sw3bApPBw3NOl7h30aEBN
vKY9NunWdMxGN4d5X7pGUg0OhsDBM0S3wWIdWpDfiOoY03bJ9bLQiBKQOdLQc+eH
sJAQUzH2RnNwBG5RLJtkNrjREObDsePmqVzGlQrEEKAnji3a4TEhd0+dQcg5EAQb
V93QS1wTBopYDAJQM6UfycY2St7nQFxVR73YbaIACaHwTt1iT/3XmNc067pt2UQq
HDM6/vzwHi0uDlP3SJNO
=ybuD
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

--===============9210487961896242197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9210487961896242197==--
