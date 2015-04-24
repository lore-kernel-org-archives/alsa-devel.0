From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 5/7] ASOC: hda: add DSP platfrom controls
 widget event handlers
Date: Fri, 24 Apr 2015 18:51:15 +0100
Message-ID: <20150424175115.GC22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6560912215909920913=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA602605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:51:22 +0200 (CEST)
In-Reply-To: <1429390653-8194-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6560912215909920913==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24SFnTCu3s+ZPDTc"
Content-Disposition: inline


--24SFnTCu3s+ZPDTc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 19, 2015 at 02:27:31AM +0530, Vinod Koul wrote:

> +static int is_hda_widget_type(struct snd_soc_dapm_widget *w)
> +{
> +	return ((w->id == snd_soc_dapm_dai_link) ||
> +		(w->id == snd_soc_dapm_dai_in) ||
> +		(w->id == snd_soc_dapm_aif_in) ||
> +		(w->id == snd_soc_dapm_aif_out) ||
> +		(w->id == snd_soc_dapm_dai_out)) ? 1 : 0;

Please use switch statements, and again no need to convert logic values
into logic values.

> +static int hda_sst_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
> +	int w_type, struct ssth_lib *ctx, struct hda_platform_info *pinfo)
> +{
> +	int ret = 0;
> +	struct ssth_module_config *mconfig = w->priv;
> +	struct ssth_pipe *s_pipe = mconfig->pipe;
> +
> +	dev_dbg(ctx->dev, "%s: widget =%s type=%d\n", __func__, w->name, w_type);
> +
> +	/*check resource available */
> +	if (!hda_sst_is_pipe_mcps_available(pinfo, ctx, mconfig))
> +		return -1;

Proper error code please.

> +	if (w_type == SSTH_WIDGET_VMIXER ||
> +		w_type == SSTH_WIDGET_MIXER) {

switch.

> +
> +		if (!hda_sst_is_pipe_mem_available(pinfo, ctx, mconfig))
> +			return -ENOMEM;
> +
> +		ret = ssth_create_pipeline(ctx, mconfig->pipe);
> +		if (ret < 0)
> +			return ret;
> +		if (list_empty(&s_pipe->w_list)) {
> +			ret = hda_sst_get_pipe_widget(ctx->dev, w, s_pipe);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		ret = hda_init_pipe_modules(ctx, s_pipe, pinfo);
> +		if (ret < 0)
> +			return ret;

The error handling here appears to be a bit incomplete, we don't unwind
anything we did.

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		return hda_sst_dapm_pre_pmu_event(w, w_type, ctx, pinfo);
> +	break;

Please follow the kernel coding style.

> +static int hda_sst_vmixer_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *k, int event)
> +{
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +
> +	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
> +	return hda_sst_event_handler(w, event, SSTH_WIDGET_VMIXER);
> +}
> +
> +static int hda_sst_mixer_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *k, int event)
> +{
> +	struct snd_soc_dapm_context *dapm = w->dapm;
> +
> +	dev_dbg(dapm->dev, "%s: widget = %s\n", __func__, w->name);
> +
> +	return hda_sst_event_handler(w, event, SSTH_WIDGET_MIXER);
> +}

Lots of indirection and wrapping going on here which seems to make
things more confusing.  Can you try writing out the event handling
directly and having it call common functions to perform the shared
operations rather than having a single event handler with per type
cases?  Or alternatively use the DAPM widget type rather than your
own ones.

> +	/* if FE - Playback, then parse sink list , Capture then source list
> +	if BE - Playback, then parse source list , Capture then sink list
> +	*/

Coding style on comments too BTW.

> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		w = dai->playback_widget;
> +		(is_fe) ? (dir = 1) : (dir = 0);

This looks like a very complicated way of writing dir = is_fe.

--24SFnTCu3s+ZPDTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOoKSAAoJECTWi3JdVIfQDIIIAIUzrG4aatfliq1qqLxMXGLq
MzYd3UZSmYZFJ2ljomA1iZsmaC7y3cndmZiIe79yawuJGu9y23ccejtT3QGx75CP
Ofh1lxkxvBVtXOZTUWXf5xT8jKdAw5qZSnvpoUZemG4oyRqiWBfvSJTpnZERrVAI
90MkPH8Ai1/DZSWGOq9+v6+XIcQ3cfJRxFEJJlck75pbSZeHK1U3HPlcp0Izbe/0
VDK+BA0aH9iZVQ3aFj7iUTogjEBNVja/rXTTADeGf49bfnexfiLt5Wghmv/M1xCf
U8lm6ifP/SNL+kD6FS+KFg30DjWSqt8QHFhj/oLJjaQyzBYz3RyBz7TKxXP91Ko=
=0Gpq
-----END PGP SIGNATURE-----

--24SFnTCu3s+ZPDTc--

--===============6560912215909920913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6560912215909920913==--
