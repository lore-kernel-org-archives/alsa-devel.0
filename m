From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 5/7] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Mon, 6 Oct 2014 08:10:10 +0530
Message-ID: <20141006024010.GQ1638@intel.com>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-6-git-send-email-subhransu.s.prusty@intel.com>
 <20141002181228.GA4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7110218141882406365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E00A72605A9
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 05:12:15 +0200 (CEST)
In-Reply-To: <20141002181228.GA4273@sirena.org.uk>
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


--===============7110218141882406365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 07:12:28PM +0100, Mark Brown wrote:
> On Fri, Sep 19, 2014 at 04:46:06PM +0530, Subhransu S. Prusty wrote:
>=20
> > +#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name)			\
> > +	static const struct snd_kcontrol_new kctl_name[] =3D {			\
> > +		SOC_DAPM_SINGLE("media0_in", SND_SOC_NOPM, SST_IP_MEDIA0, 1, 0),	\
> > +		SOC_DAPM_SINGLE("media1_in", SND_SOC_NOPM, SST_IP_MEDIA1, 1, 0),	\
> > +		SOC_DAPM_SINGLE("media2_in", SND_SOC_NOPM, SST_IP_MEDIA2, 1, 0),	\
> > +		SOC_DAPM_SINGLE("media3_in", SND_SOC_NOPM, SST_IP_MEDIA3, 1, 0),	\
> > +	}
>=20
> These should be Switch controls?
Yup I will fix this one.

>=20
> > +	snd_soc_dapm_new_controls(dapm, sst_dapm_widgets,
> > +			ARRAY_SIZE(sst_dapm_widgets));
> > +	snd_soc_dapm_add_routes(dapm, intercon,
> > +			ARRAY_SIZE(intercon));
> > +	snd_soc_dapm_new_widgets(dapm->card);
>=20
> We should be able to do this from the component but we can't yet...
We can convert once ready :)

I still have lots of stuff to do once this series is in. We also need to
enable dynamic firmware here once liam upstreams basic support :)

Thanks
--=20
~Vinod

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUMgEKAAoJEHwUBw8lI4NHtHYQANbUmvHkYpQuIzixRJrMLmpC
muF05W36wS4ibWJpH0NFX5nYqLQOEHQqOiniqI6jhgcesm0Zkuh20LyFmGnNUDgx
8pCQtUr0RGMX13wi0JpJ3Scjt4aK1q1qwWwGtmrK2XMGCKrIOX3NS3aliJ4u5trD
0zHwr0kuiouNiOoXHzWxaJvBKfv8h6KCNVk6WzeDJy6bGUg0vBKerCGRjPdkLUhb
aPg18WNFE83RicOWzBSNB/Tg111DRcLMeR4C/3zFj8BbSKcqCKDG76Cuh7SyFjyF
vnTe7OaClNWluNG4cZKzfJVuZ7YLrdw/nI8mF1Vslzl9/+4+m52qhrCCMc/hTysW
gn1OCFGg/Pia7mqhOjA5U+9dvGb/4EKNLvbV7Ocxr2xILURJWRCDfnkQPE8opdY6
nvZaE+ugmWs1jCnr1DMm0r9PFcNeeB58eOENdy6JQGklP06xny7AvIVJphokip4r
97ViafcBzjsvuLnIWZY/oHQWheZegus5BiFBSM+LVWBdM7xF39YtUCMdZKM2IKds
SRzR28otV/uoINHFxisa29lvJSVjc8WRHJPhQeIye9P0i0J+9yKGSYQo5TzgKlGB
Y43C+CK4yaDcrE+c30c09MmDn2dVpISAbyrN1o76+ARNWE3Jz7j01d2YaOeO42fC
1MMIS3+8edTN6MWkWSvr
=WpVR
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

--===============7110218141882406365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7110218141882406365==--
