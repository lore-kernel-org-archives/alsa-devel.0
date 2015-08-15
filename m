From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/9] ASoC: Intel: Skylake: add DSP platform
 widget event handlers
Date: Sat, 15 Aug 2015 19:12:08 +0530
Message-ID: <20150815134208.GD13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
 <20150814214336.GU10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8328250152953464314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C12B261522
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 15:40:09 +0200 (CEST)
In-Reply-To: <20150814214336.GU10748@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8328250152953464314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 10:43:36PM +0100, Mark Brown wrote:
> On Sat, Aug 08, 2015 at 01:06:18AM +0530, Subhransu S. Prusty wrote:
>=20
> > +	/* If its not SKL DSP type dont handle */
> > +	if (source->priv =3D=3D NULL &&  (!is_skl_dsp_widget_type(w)))
> > +		return 0;
>=20
> Why would this event be assigned to a widget that is not a suitable
> type, and what if it's an unsuitable widget type that happens ton have
> private data?  I'm not sure I understand the priv check.

Yes rethinking now I don't see why this would be called for events we don't
register as you pointed. I will recheck this bit and get back.

> You've also got a typo with "don't" and an extra space after the &&.
Oops, will fix. Thanks for pointing.

> > +	list_for_each_entry(p, &w->sinks, list_source) {
> > +		if (!p->connect)
> > +			continue;
>=20
> Hrm.  Do we handle routing changes well?

Yes we do :)
This is the pmu handler for a mixer widget. Here we need to send Bind event
to firmware for the paths which are connected, so if a path is not connected
we don't need to send bind event so we skip that.

>=20
> > +			/* Add connected path to one global list */
> > +			path_list->dapm_path =3D p;
> > +			list_add_tail(&path_list->node, &skl->dapm_path_list);
> > +			break;
>=20
> We have our own private path list here which includes the DAPM path...
> can't we outsource some of this to the topology and DAPM code?  I'm a
> little fuzzy on what the list is for, it appears to be used mainly for
> deallocation though it's called dapm_path_list (which is a bit worrying).

If you look at the usage of the dapm_path_list, it is used in pmd handler
for this mixer. For a mixer there can be many paths and we need to
disconnect the previously connected path. DAPM will disconnect and send
event, so we wont know which paths were disconnected and thats why we keep a
track if this by using this list. At PMU we keep adding and at PMD we check
the path which was disconnected and send the event for that.
This gives driver very quick lookup of which disconnect to send. I am not
sure if we should be changing framework for this...

> > +static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widg=
et *w,
> > +								struct skl *skl)
> > +{
>=20
> This looks a lot like the previous function, there's similar duplication
> in the other event functions.

Actually logic is quite different. The skl_tplg_mixer_dapm_post_pmu_event is
for mixer and is supposed to bind to source pipe and start
The previous one is for PGA and starts sink pipelines it is connected to and
then its own. It doesn't do bind.

Said that I will check and try to see if common code for checking and
starting can be factored out from these into a common helper

>=20
> > +	}
> > +	if (src_pipe_started) {
>=20
> Missing blank line here.
Will fix

>=20
> > +/*
> > + * In modelling, we assume ther will be one mixer in a pipeline. If a =
second
> > + * one is required that is created as another pipe entity.
> > + * The mixer is resposible for pipe management and represent a pipeline
> > + * instance
> > + */
>=20
> You mean to say you assume there will be *exactly* one mixer?
Yes :) and if we need another mixer then that will become another pipeline

Thanks
--=20
~Vinod

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz0GwAAoJEHwUBw8lI4NH2KsP/3PJCgFdis6JCKMyY8+OE/q+
rNlYhxCgY2QBrCSrRYJmG75Kce6dc1UPOz2rSrpVxfCF04rrY9gzAeteJomP91Ld
2pRuow7JfmMmKNJJkHxKlCZTsSNRezhMv8XKfOM+eJzsoTLy6+Z/VPE8Sqb/QKhp
h6e9H/Wsuaoumu38QaKzE0jTaHL65GFwTGHTfNYbZ2RoJ80EZYvIueS3NrEv5OcL
2fpwVipas3OVyZDb5zil6Goj/prjZMNQFhu6dAmjeTWH7/2vfPkUslV6FjiG5p0I
0h/T8nLDTPwE4y8xO8VT8mFKJZmQ2xXB7tdXxI9fyNo1+I4p8apLg3p6Qg097mFV
GaUDnEVb2t4no7RKQALWTYEJGA9fxF6M4NhdUfZwHTEQTXGJWTe9Gc7U24YySekd
xuu6ymMx8S4jv+z1O+OyP3ocYShltxjjoGskNnrZPehvCOp0BVtI/esdFtW9GNFD
1pbeN+B3+OLYrS1MBQ1lvfwC0N1jCyCFRZPvDmgsirzdpp96ezpLgxGA9bDs8wFA
FMGFr6M0lw4F3RuKbfttlYNa415wguYOkNkkQTbN42tT/9b3r3f6iz+5+UbU7iF0
LKEYag4AjbAP/OuaUTPjyrnNx+p1MPRT8pcVlGuQ5euw8ye9vsK8qrWQa4kiiXG0
YqDTce1jzQBzLQVqAy0i
=G7ps
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

--===============8328250152953464314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8328250152953464314==--
