From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/9] ASoC: Intel: Skylake: add DSP platform
 widget event handlers
Date: Sat, 15 Aug 2015 20:42:04 +0530
Message-ID: <20150815151204.GH13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
 <20150814214336.GU10748@sirena.org.uk>
 <20150815134208.GD13546@localhost>
 <20150815143638.GC10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7352437146447941263=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 20D8126513F
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 17:10:04 +0200 (CEST)
In-Reply-To: <20150815143638.GC10748@sirena.org.uk>
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


--===============7352437146447941263==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 07:36:38AM -0700, Mark Brown wrote:
> On Sat, Aug 15, 2015 at 07:12:08PM +0530, Vinod Koul wrote:
> > On Fri, Aug 14, 2015 at 10:43:36PM +0100, Mark Brown wrote:
>=20
> > > > +	list_for_each_entry(p, &w->sinks, list_source) {
> > > > +		if (!p->connect)
> > > > +			continue;
>=20
> > > Hrm.  Do we handle routing changes well?
>=20
> > Yes we do :)
> > This is the pmu handler for a mixer widget. Here we need to send Bind e=
vent
> > to firmware for the paths which are connected, so if a path is not conn=
ected
> > we don't need to send bind event so we skip that.
>=20
> And we couldn't connect in any other way?  This case is fine but I'm
> worrying about what happens if that connection gets made later - we
> won't get another PMU event since the widget is already powered.

Yes you are right this won't be handled here, but will be handled in source
pipe it is connecting to. The DAPM event will be called for that pipe, and
there we check if source or sink pipe is already running which is clue to
driver that we should do bind there rather than here

I will add that part as well in event handler comments

> > > > +			/* Add connected path to one global list */
> > > > +			path_list->dapm_path =3D p;
> > > > +			list_add_tail(&path_list->node, &skl->dapm_path_list);
> > > > +			break;
>=20
> > > We have our own private path list here which includes the DAPM path...
> > > can't we outsource some of this to the topology and DAPM code?  I'm a
> > > little fuzzy on what the list is for, it appears to be used mainly for
> > > deallocation though it's called dapm_path_list (which is a bit worryi=
ng).
>=20
> > If you look at the usage of the dapm_path_list, it is used in pmd handl=
er
> > for this mixer. For a mixer there can be many paths and we need to
>=20
> This is the sort of thing where the whole lack of documentation thing
> that I keep going on about becomes really important - there's a limited
> amount of time I can spend on any individual patch series and so things
> that need to be reverse engineered are just going to get queried a lot
> of the time (and even if they get reverse engineered the feedback is
> often going to be that the code needs to be clearer).

Okay, I did try to add comments to help understand but looks like I still
have more work to do. Will try to add these details as well

> > disconnect the previously connected path. DAPM will disconnect and send
> > event, so we wont know which paths were disconnected and thats why we k=
eep a
> > track if this by using this list. At PMU we keep adding and at PMD we c=
heck
> > the path which was disconnected and send the event for that.
> > This gives driver very quick lookup of which disconnect to send. I am n=
ot
> > sure if we should be changing framework for this...
>=20
> So this is about generating a notification to say which routes are being
> disconnected?  That seems like a fairly general thing, I can imagine
> that being quite common for DSPs - indeed it seems essential given that
> we won't always trigger any power changes on disconnection.

Okay fair point. Would it be okay to carry this approach here for now and
with later DAPM updates for next kernel cycle?

>=20
> > > > +static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_=
widget *w,
> > > > +								struct skl *skl)
> > > > +{
>=20
> > > This looks a lot like the previous function, there's similar duplicat=
ion
> > > in the other event functions.
>=20
> > Actually logic is quite different. The skl_tplg_mixer_dapm_post_pmu_eve=
nt is
> > for mixer and is supposed to bind to source pipe and start
> > The previous one is for PGA and starts sink pipelines it is connected t=
o and
> > then its own. It doesn't do bind.
>=20
> There's certainly a lot of visual similarity there.

Oh yes, they do look a lot similar...


--=20
~Vinod

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz1bEAAoJEHwUBw8lI4NHlIgQAMzaFT1SbBlEIpVz4KUE/AmW
7If4lzoVCCvqVo8E2gsXUS9+Mrde2uV/AA94s9rTWb1Y+BHihvXi3q0cYbOuMxkX
cxmQ2b6jAPMYRTUBPr6GsuS52SeVZ425sImGo13tTKmC7Dr8O6Dt+SWBhLRduB3W
PlVHwK5uJo2ZOh914iJNu1+vbjMbPKmXcZcTEf+cO77bA/jszJyWd3xAQe3xxl5e
0yqyFq1pdYLP4rvoYzFzVsQ2yptsGYgcILzo5fhL4C5RJzAFkCA/ttAdsiydUvhc
TzF/pBittDybKKpxLrLsoG2Zc86NglQrw6CjN3snSyNu7Gq/sQhd2/Iiz054kn7/
EiB6KfV5wsbJp9EePCCpLPn6OmwZDRLwyAO/XZxjukLHwy+nkUCeQvR08uEErVys
gYTfgKOAr0PZwa+43gWvoxV/D8sLsdvgTeCB0w780CIjrlNZPsWZ6IERmLQGxsBG
hk4iBk7lnGcl6IIvCJmbeknVb95upW00Y2BONkZbTmEXtwSNT9WwsfBm6Vh7dSlV
/7dyjCXlwFFrR1nuZqzkrD+NC+Tzy+AP/lWLIvDXxS5xRuQOk/BddjS1MxhM8BEc
RQUflLnAuIk+IFSfqRMWg6AM7GxNb2nOVfU8hdbLVuLbEQue97acCnnCpufCJ3KW
jqS5MsSlJERVkMFhQUtd
=PZuL
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

--===============7352437146447941263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7352437146447941263==--
