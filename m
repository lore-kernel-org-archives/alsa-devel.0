From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: Intel: add kcontrol to
 enable/disable sound effect module waves
Date: Wed, 11 Mar 2015 12:57:23 +0000
Message-ID: <20150311125723.GG28806@sirena.org.uk>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
 <1425955287-29661-4-git-send-email-han.lu@intel.com>
 <20150310203730.GN28806@sirena.org.uk>
 <B51200AC81AB024499A3C2C9A1BB90A8373CC6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2904899393109119123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B292651D5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 13:57:28 +0100 (CET)
In-Reply-To: <B51200AC81AB024499A3C2C9A1BB90A8373CC6@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lu, Han" <han.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2904899393109119123==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v1t52WyqlzjC8f44"
Content-Disposition: inline


--v1t52WyqlzjC8f44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 07:07:12AM +0000, Lu, Han wrote:

Again, please fix your mailer to word wrap within paragraphs - this mail
is very difficult to read.

> > On Tue, Mar 10, 2015 at 10:41:23AM +0800, han.lu@intel.com wrote:
> >=20
> > > +static int hsw_waves_switch_put(struct snd_kcontrol *kcontrol,
> > > +				struct snd_ctl_elem_value *ucontrol) {
> > > +	struct snd_soc_platform *platform =3D
> > snd_soc_kcontrol_platform(kcontrol);
> > > +	struct hsw_priv_data *pdata =3D
> > snd_soc_platform_get_drvdata(platform);
> > > +	struct sst_hsw *hsw =3D pdata->hsw;
> > > +	int ret =3D 0;
> > > +	enum sst_hsw_module_id id =3D SST_HSW_MODULE_WAVES;
> > > +	bool switch_on =3D (bool)ucontrol->value.integer.value[0];

> > > +	if (sst_hsw_is_module_loaded(hsw, id)) {
> > > +		if (switch_on =3D=3D sst_hsw_is_module_active(hsw, id))
> > > +			return 0;
> > > +
> > > +		/* ipc is valid only when module is loaded */
> > > +		if (switch_on)
> > > +			ret =3D sst_hsw_module_enable(hsw, id, 0);
> > > +		else
> > > +			ret =3D sst_hsw_module_disable(hsw, id, 0);
> > > +	}

> > I'm not clear how this setting is saved when the module is not in RAM o=
n the
> > DSP.  If the module enable/disable calls do that that's fine but I'd ex=
pect the
> > function to return an error if the module isn't loaded (or better yet f=
or the
> > control not to be made visible to userspace at all) - we shouldn't be s=
ilently
> > ignoring what the user is setting.

> [Han] if module is not in RAM on the DSP, sst_hsw_is_module_loaded()
> will return false. Also sst_hsw_module_enable() and
> sst_hsw_module_disable() will check the module status in DSP before
> send IPC commands to DSP.  In case sst_hsw_is_module_loaded() return
> false, (eg. System go RTD3 and modules in DSP RAM be unloaded) the
> user setting will be stored in variant u32 enabled_modules_rtd3, which
> is implemented in patch 0005. So which is better for next version of
> patch, to add error return here, merge patch 0005 with 0004, or  do
> not change this part? Thanks.

It's better to merge the two patches so that it's clear that everything
is working fine - in general the idea is that things should work after
every patch and people shouldn't be finding problems in the patch series
which are fixed later on in the same series.

--v1t52WyqlzjC8f44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADuyAAoJECTWi3JdVIfQDGMH/jOJY7R60QRsAd7VyP9U8FIr
c3KPqsVhk/6RQvM+GbtCE2rUPl2hdvZn5p8OQLlhn6ORo72dTNJMxYmJeZj1e34v
W+GbBicORumTppoFjnZ96NCwMWZRzCEQm1tS3smNvTbnr22Fa8XCHdoJ7S/gg42/
uCHEpq+e8jValPrC0pzuLGgH27IDKzhWXrauKqSAuYrTI4TI9mSlfwloeFakShG+
Fovl+QUZhKhW56GWxolXmnqJukZTA0hNTQhPgN9ZYstlaM2HMJyxvi5HMxdsTlMF
MHSjGhzYcTORQ754jk/Anev0vPY/EjtzcAZvHsxAfdWa2dfeba/i70mA56cpW/4=
=HI3g
-----END PGP SIGNATURE-----

--v1t52WyqlzjC8f44--

--===============2904899393109119123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2904899393109119123==--
