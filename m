From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 5/7] ASOC: hda: add DSP platfrom controls
 widget event handlers
Date: Sun, 26 Apr 2015 19:44:52 +0530
Message-ID: <20150426141452.GR2738@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-6-git-send-email-vinod.koul@intel.com>
 <20150424175115.GC22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8238865398950278952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F58F2606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:17:41 +0200 (CEST)
In-Reply-To: <20150424175115.GC22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8238865398950278952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:51:15PM +0100, Mark Brown wrote:
> On Sun, Apr 19, 2015 at 02:27:31AM +0530, Vinod Koul wrote:
>=20
> > +static int is_hda_widget_type(struct snd_soc_dapm_widget *w)
> > +{
> > +	return ((w->id =3D=3D snd_soc_dapm_dai_link) ||
> > +		(w->id =3D=3D snd_soc_dapm_dai_in) ||
> > +		(w->id =3D=3D snd_soc_dapm_aif_in) ||
> > +		(w->id =3D=3D snd_soc_dapm_aif_out) ||
> > +		(w->id =3D=3D snd_soc_dapm_dai_out)) ? 1 : 0;
>=20
> Please use switch statements, and again no need to convert logic values
> into logic values.
OK

>=20
> > +static int hda_sst_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
> > +	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
> > +{
> > +	int ret =3D 0;
> > +	struct ssth_module_config *mconfig =3D w->priv;
> > +	struct ssth_pipe *s_pipe =3D mconfig->pipe;
> > +
> > +	dev_dbg(ctx->dev, "%s: widget =3D%s type=3D%d\n", __func__, w->name, =
w_type);
> > +
> > +	/*check resource available */
> > +	if (!hda_sst_is_pipe_mcps_available(pinfo, ctx, mconfig))
> > +		return -1;
>=20
> Proper error code please.
Sure

>=20
> > +	if (w_type =3D=3D SSTH_WIDGET_VMIXER ||
> > +		w_type =3D=3D SSTH_WIDGET_MIXER) {
>=20
> switch.
Since this is checking for these two types only, I think if maybe fine, but
dont mind swicth too.

> > +
> > +		if (!hda_sst_is_pipe_mem_available(pinfo, ctx, mconfig))
> > +			return -ENOMEM;
> > +
> > +		ret =3D ssth_create_pipeline(ctx, mconfig->pipe);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (list_empty(&s_pipe->w_list)) {
> > +			ret =3D hda_sst_get_pipe_widget(ctx->dev, w, s_pipe);
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +		ret =3D hda_init_pipe_modules(ctx, s_pipe, pinfo);
> > +		if (ret < 0)
> > +			return ret;
>=20
> The error handling here appears to be a bit incomplete, we don't unwind
> anything we did.
Yes let me check that.

> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		return hda_sst_dapm_pre_pmu_event(w, w_type, ctx, pinfo);
> > +	break;
>=20
> Please follow the kernel coding style.
oops, will fix

> > +static int hda_sst_vmixer_event(struct snd_soc_dapm_widget *w,
> > +		struct snd_kcontrol *k, int event)
> > +{
> > +	struct snd_soc_dapm_context *dapm =3D w->dapm;
> > +
> > +	dev_dbg(dapm->dev, "%s: widget =3D %s\n", __func__, w->name);
> > +	return hda_sst_event_handler(w, event, SSTH_WIDGET_VMIXER);
> > +}
> > +
> > +static int hda_sst_mixer_event(struct snd_soc_dapm_widget *w,
> > +			struct snd_kcontrol *k, int event)
> > +{
> > +	struct snd_soc_dapm_context *dapm =3D w->dapm;
> > +
> > +	dev_dbg(dapm->dev, "%s: widget =3D %s\n", __func__, w->name);
> > +
> > +	return hda_sst_event_handler(w, event, SSTH_WIDGET_MIXER);
> > +}
>=20
> Lots of indirection and wrapping going on here which seems to make
> things more confusing.  Can you try writing out the event handling
> directly and having it call common functions to perform the shared
> operations rather than having a single event handler with per type
> cases?  Or alternatively use the DAPM widget type rather than your
> own ones.
Okay let me cleanup this code is next series

>=20
> > +	/* if FE - Playback, then parse sink list , Capture then source list
> > +	if BE - Playback, then parse source list , Capture then sink list
> > +	*/
>=20
> Coding style on comments too BTW.
will fix

>=20
> > +	if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> > +		w =3D dai->playback_widget;
> > +		(is_fe) ? (dir =3D 1) : (dir =3D 0);
>=20
> This looks like a very complicated way of writing dir =3D is_fe.
Yes for sure :)

--=20
~Vinod
--=20

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPLcAAoJEHwUBw8lI4NHLd4QANc6SM/A2TLilHjgo8qeLgEU
ZkeumFPlqnajgX2QBSLgBly4pwrYiWeRbYDuJGT2Q9LAKntwwJYHW73F733TpD4w
UnodwmyNMJXMFbcyJv+TGu1xCyoDNUwYJmxvZW22HxOexWKMKSnwHjBvcprmFuRA
hfzA0EfZB2e58xCoptZ9V22625/Hr5HA1U8OvYP8rV2PeR6Fe+SnRBRy63tCuQey
LCDNSV6frdokFG6tTTK7DI12MAoFOB7Y3dL2OHqtt17/SE4N74fRf6L00xQIZylK
oDcCstHVZgO/Yx/kVKVU0PB0rJpv8mGsgnV1jw0QyY49oTzgKC4l0DMruC9eAJ3o
doQd7swRj9fBLQFSlkABfv8evtPiHDzht3GZoD24/ejHjpob+9Carl2FA67nrGpx
Z1nCBOy7szyW/2nVg+vTaxghdxuxmXRArj1XoVPrPi7KLB+xxqKMKiv9EOaOPyNL
u8X+IWYCD49SVDBYVE4mOSxoXLLBKqEc2H7djEBStzwGW1Ra0DKTU6n1MAOaXmCd
owtcx4q9U79TwuEqBAO+85OxClzftwKNQ47bAg5qGpyNmuMFY4C4AvtYEnVIFw1q
9ACjefVAMN1H04WpPPyv2uRLhblnxv2v4WzVqIxV83GIOtZhWRcIczVwEylMfWg/
WpHYIl1mXj+8hvMKJF6x
=R+9O
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--

--===============8238865398950278952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8238865398950278952==--
