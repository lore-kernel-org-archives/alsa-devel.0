From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/9] ASoC: Intel: Skylake: add DSP platform
 widget event handlers
Date: Fri, 14 Aug 2015 22:43:36 +0100
Message-ID: <20150814214336.GU10748@sirena.org.uk>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7398327036144711826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 960BF26653B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:13 +0200 (CEST)
In-Reply-To: <1438976184-6160-4-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7398327036144711826==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YgBy8fL35x4aZQ30"
Content-Disposition: inline


--YgBy8fL35x4aZQ30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 08, 2015 at 01:06:18AM +0530, Subhransu S. Prusty wrote:

> +	/* If its not SKL DSP type dont handle */
> +	if (source->priv == NULL &&  (!is_skl_dsp_widget_type(w)))
> +		return 0;

Why would this event be assigned to a widget that is not a suitable
type, and what if it's an unsuitable widget type that happens ton have
private data?  I'm not sure I understand the priv check.

You've also got a typo with "don't" and an extra space after the &&.

> +	list_for_each_entry(p, &w->sinks, list_source) {
> +		if (!p->connect)
> +			continue;

Hrm.  Do we handle routing changes well?

> +			/* Add connected path to one global list */
> +			path_list->dapm_path = p;
> +			list_add_tail(&path_list->node, &skl->dapm_path_list);
> +			break;

We have our own private path list here which includes the DAPM path...
can't we outsource some of this to the topology and DAPM code?  I'm a
little fuzzy on what the list is for, it appears to be used mainly for
deallocation though it's called dapm_path_list (which is a bit worrying).

> +static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
> +								struct skl *skl)
> +{

This looks a lot like the previous function, there's similar duplication
in the other event functions.

> +	}
> +	if (src_pipe_started) {

Missing blank line here.

> +/*
> + * In modelling, we assume ther will be one mixer in a pipeline. If a second
> + * one is required that is created as another pipe entity.
> + * The mixer is resposible for pipe management and represent a pipeline
> + * instance
> + */

You mean to say you assume there will be *exactly* one mixer?

--YgBy8fL35x4aZQ30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzmEIAAoJECTWi3JdVIfQFyUH/3IeZeoGblPxYHszyiOHluJQ
KgTnWuENmrXMIMctWc7etGH4Jnv9G2fX/PX+GkN5sC4NsNEb3KvkQtyz1UqvNncX
gG97j3Zz8qKMRYbv4cFVbsTtD+INb2aG03m74UfyeCR5aHTsQ2T9lA4sMaWPOi3y
H8v5ijET3Lu2dYuk461WbZP/DKPbOwn2pYvBGazdpcvn9m7dpAOCtstyaEUXYtgB
dH5Jq1tMFw/euXKYqv+8oLEnljpeuO+ux8HUPPMFqnowyxR1GMOcrXhyQ1bF72d2
U2kpVsSzOR4Sace64f2O4ks/vLz5FBHD/F3iXWGQEeK31anTwoFbV/LA/YsFaB4=
=UY3a
-----END PGP SIGNATURE-----

--YgBy8fL35x4aZQ30--

--===============7398327036144711826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7398327036144711826==--
